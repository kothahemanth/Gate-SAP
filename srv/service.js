const cds = require('@sap/cds');
const json2xml = require('json2xml');
const axios = require('axios');

module.exports = cds.service.impl(async function () {
    const PurchaseOrderAPI = await cds.connect.to("CE_PURCHASEORDER_0001");
    const { Transporters, PurchaseOrders, Entry, PurchasePricing, FreightInfo } = this.entities;

    this.before(['CREATE', 'UPDATE'], 'Entry', async (req) => {
        const { Details, TransporterName_Name, Purchase, Weight, Freight_Desc } = req.data;

        if (Details && Array.isArray(Details)) {
            Details.forEach((detail) => {
                const { AcceptedWeight, BagWeightParty } = detail;

                if (AcceptedWeight == null || BagWeightParty == null) {
                    req.error(400, 'AcceptedWeight and BagWeightParty are required in Details.');
                }

                if (typeof AcceptedWeight !== 'number' || typeof BagWeightParty !== 'number') {
                    req.error(400, 'AcceptedWeight and BagWeightParty must be numeric in Details.');
                }
                const grossWeight = AcceptedWeight;
                const netWeight = AcceptedWeight - BagWeightParty;
                const differenceWeight = grossWeight - netWeight;
                const weightPackingMaterial = AcceptedWeight - netWeight;
                const averageWeight = AcceptedWeight + differenceWeight;

                detail.GrossWeightSupplier = grossWeight;
                detail.NetWeightSupplier = netWeight;
                detail.DifferenceWeight = differenceWeight;
                detail.WeightPackingMaterial = weightPackingMaterial;
                detail.AverageWeight = averageWeight;
            });
        }

        if (TransporterName_Name) {
            const existingTransporter = await SELECT.one.from(Transporters).where({ Name: TransporterName_Name });

            if (!existingTransporter) {
                await INSERT.into(Transporters).entries({ Name: TransporterName_Name });
            }
        }

        if (Freight_Desc) {
            const existingFreight = await SELECT.one.from(FreightInfo).where({ Desc: Freight_Desc });
            if (existingFreight) {
                await INSERT.into(FreightInfo).entries({ Desc: Freight_Desc});
            }
        }
    
        if (Purchase && Array.isArray(Purchase)) {
            for (const purchase of Purchase) {
                const { Order } = purchase;

                if (Order) {
                    try {
                        const purchaseOrderDetails = await SELECT.one
                            .from('satinfotech.PurchaseOrders')
                            .columns(
                                'Material',
                                'Plant',
                                'PurchaseOrderItem',
                                'PurchaseOrderItemText',
                                'OrderQuantity',
                                'BaseUnit',
                                'StorageLocation',
                                'TaxCode',
                                'CompanyCode',
                                'ConsumptionTaxCtrlCode',
                                'OrderPriceUnit'
                            )
                            .where({ PurchaseOrder: PurchaseOrder });

                        if (purchaseOrderDetails) {
                            purchase.Material = purchaseOrderDetails.Material;
                            purchase.Plant = purchaseOrderDetails.Plant;
                            purchase.PurchaseOrderItem = purchaseOrderDetails.PurchaseOrderItem;
                            purchase.PurchaseOrderItemText = purchaseOrderDetails.PurchaseOrderItemText;
                            purchase.OrderQuantity = purchaseOrderDetails.OrderQuantity;
                            purchase.BaseUnit = purchaseOrderDetails.BaseUnit;
                            purchase.StorageLocation = purchaseOrderDetails.StorageLocation;
                            purchase.TaxCode = purchaseOrderDetails.TaxCode;
                            purchase.CompanyCode = purchaseOrderDetails.CompanyCode;
                            purchase.ConsumptionTaxCtrlCode = purchaseOrderDetails.ConsumptionTaxCtrlCode;
                            purchase.OrderPriceUnit = purchaseOrderDetails.OrderPriceUnit;
                        } else {
                            req.error(400, `No details found for Manufacturing Order ${Order}`);
                        }
                    } catch (error) {
                        req.error(500, `Error fetching data for Manufacturing Order ${Order}: ${error.message}`);
                    }
                }
            }
        }

        if (Weight && Array.isArray(Weight)) {
            Weight.forEach((weight) => {
                const { FirstWt, SecondWt, ThirdWt } = weight;

                if (FirstWt == null || SecondWt == null || ThirdWt == null) {
                    req.error(400, 'FirstWt, SecondWt and ThirdWt are required in Weight.');
                }

                if (typeof FirstWt !== 'number' || typeof SecondWt !== 'number' || typeof ThirdWt !== 'number') {
                    req.error(400, 'FirstWt, SecondWt and ThirdWt must be numeric in Details.');
                }
                const Wght = FirstWt + SecondWt + ThirdWt;
                const AvgWght = Wght / 3;

                weight.LxAvgWt = AvgWght;
            });
        }
    });

    this.on("READ", "PurchasePricing", async (req) => {
        try {
            return await PurchaseOrderAPI.run(req.query);
        } catch (error) {
            console.error("Error reading PurchasePricing:", error);
            req.error(500, "Failed to fetch data from PurchasePricing API");
        }
    });

    this.on("READ", "SupplierInfo", async (req) => {
        req.query.SELECT.columns = [
            { ref: ["_SupplierAddress"], expand:['*'] },
        ];
        try {
            return await PurchaseOrderAPI.run(req.query);
        } catch (error) {
            console.error("Error reading PurchaseOrders:", error);
            req.error(500, "Failed to fetch data from PurchaseOrders API");
        }
    });

    this.on('READ', FreightInfo, async (req) => {
        const stat = [
            { "Desc": "Paid" },
            { "Desc": "Not Paid" },
        ];
        stat.$count = stat.length;
        return stat;
    });

    this.on("READ", "PurchaseOrders", async (req) => {
        req.query.SELECT.columns = [
            { ref: ["PurchaseOrder"] },
            { ref: ["PurchaseOrderItem"] },
            { ref: ["PurchaseOrderItemText"] },
            { ref: ["Plant"] },
            { ref: ["Material"] },
            { ref: ["BaseUnit"] },
            { ref: ["OrderQuantity"] },
            { ref: ["StorageLocation"] },
            { ref: ["CompanyCode"] },
            { ref: ["TaxCode"] },
            { ref: ["ConsumptionTaxCtrlCode"] },
            { ref: ["OrderPriceUnit"] },
        ];
        try {
            return await PurchaseOrderAPI.run(req.query);
        } catch (error) {
            console.error("Error reading PurchaseOrders:", error);
            req.error(500, "Failed to fetch data from PurchaseOrders API");
        }
    });

    this.on('productData', 'Entry', async (req) => {
        console.log(req.params);
        const { ID } = req.params[0];
    
        const rowData = await SELECT.one.from(Entry)
            .columns(
                '*',
                { ref: ['Details'], expand: ['*'] },
                { ref: ['Purchase'], expand: ['*'] },
                { ref: ['Weight'], expand: ['*'] },
                { ref: ['Remarks'], expand: ['*']}
            )
            .where({ ID });
    
        if (!rowData) {
            return req.error(404, `No data found for ID: ${ID}`);
        }
    
        console.log("Row data before processing:", rowData);
    
        const fetchPricingAndSupplierDetails = async () => {
            const extractedData = rowData.Purchase.map(purchase => ({
                PurchaseOrder: purchase.PurchaseOrder,
                PurchaseOrderItem: purchase.PurchaseOrderItem
            }));
    
            const pricingPromises = extractedData.map(async (purchase) => {
                const { PurchaseOrder, PurchaseOrderItem } = purchase;
    
                const purchasePricingData = await PurchaseOrderAPI.run(
                    SELECT.from('PurOrderItemPricingElement')
                        .columns('ConditionType', 'ConditionQuantity', 'ConditionAmount', 'ConditionRateRatio')
                        .where({
                            PurchaseOrder: String(PurchaseOrder),
                            PurchaseOrderItem: String(PurchaseOrderItem)
                        })
                );
    
                console.log('Pricing Elements:', purchasePricingData);
    
                const supplierAddressData = await PurchaseOrderAPI.run(
                    SELECT.from('PurchaseOrder')
                        .columns(
                            '*',
                            {
                                ref: ['_SupplierAddress'],
                                expand: [
                                    'CityName',
                                    'PostalCode',
                                    'StreetName',
                                    'OrganizationName1',
                                    'EmailAddress',
                                    'SupplierAddressID'
                                ]
                            }
                        )
                        .where({ PurchaseOrder: String(PurchaseOrder) })
                );
    
                let supplierAddress = [];
                if (supplierAddressData && supplierAddressData.length > 0) {
                    supplierAddress = supplierAddressData.map(purchaseOrder => ({
                        CityName: purchaseOrder._SupplierAddress.CityName,
                        PostalCode: purchaseOrder._SupplierAddress.PostalCode,
                        StreetName: purchaseOrder._SupplierAddress.StreetName,
                        OrganizationName1: purchaseOrder._SupplierAddress.OrganizationName1,
                        EmailAddress: purchaseOrder._SupplierAddress.EmailAddress,
                        SupplierAddressID: purchaseOrder._SupplierAddress.SupplierAddressID
                    }));
                }
    
                console.log('Supplier Address:', supplierAddress);
    
                return {
                    PurchaseOrder,
                    PurchaseOrderItem,
                    pricingElements: purchasePricingData || [],
                    supplierAddress
                };
            });
    
            const pricingData = await Promise.all(pricingPromises);
    
            rowData.Purchase.forEach((purchase) => {
                const pricingInfo = pricingData.find(p =>
                    p.PurchaseOrder === purchase.PurchaseOrder &&
                    p.PurchaseOrderItem === purchase.PurchaseOrderItem
                );
                if (pricingInfo) {
                    purchase.PricingElements = pricingInfo.pricingElements;
                    purchase.SupplierAddress = pricingInfo.supplierAddress; 
                }
            });
    
            console.log("Row data after attaching details:", rowData);
            return rowData;
        };
    
        try {
            const updatedRowData = await fetchPricingAndSupplierDetails();

            const xmlfun = (rowData) => {
                const json2xmlOptions = { header: true, prettyPrint: true };
            
                const rowDataWithPurchaseElements = {
                    Entry: {
                        ...rowData,
                        Purchase: rowData.Purchase.map(purchase => ({
                            PurchaseElements: {
                            PurchaseOrder: purchase.PurchaseOrder,
                            PurchaseOrderItem: purchase.PurchaseOrderItem,
                            PurchaseOrderItemText: purchase.PurchaseOrderItemText,
                            Plant: purchase.Plant,
                            TaxCode: purchase.TaxCode,
                            BaseUnit: purchase.BaseUnit,
                            Material: purchase.Material,
                            CompanyCode: purchase.CompanyCode,
                            OrderQuantity: purchase.OrderQuantity,
                            OrderPriceUnit: purchase.OrderPriceUnit,
                            StorageLocation: purchase.StorageLocation || '',
                            ConsumptionTaxCtrlCode: purchase.ConsumptionTaxCtrlCode,
                            
                                PricingElements: purchase.PricingElements ? purchase.PricingElements.map(pricing => ({
                                    PricingElement: {
                                        ConditionType: pricing.ConditionType,
                                        ConditionQuantity: pricing.ConditionQuantity,
                                        ConditionAmount: pricing.ConditionAmount,
                                        ConditionRateRatio: pricing.ConditionRateRatio
                                    }
                                })) : [],
                                SupplierAddress: purchase.SupplierAddress ? purchase.SupplierAddress.map(address => ({
                                    Address: {
                                        CityName: address.CityName,
                                        PostalCode: address.PostalCode,
                                        StreetName: address.StreetName,
                                        OrganizationName1: address.OrganizationName1,
                                        EmailAddress: address.EmailAddress,
                                        SupplierAddressID: address.SupplierAddressID
                                    }
                                })) : []
                            }
                        }))
                    }
                };
            
                const xmlData = json2xml(rowDataWithPurchaseElements, json2xmlOptions);
                return xmlData;
            };
    
            const xmlOutput = xmlfun(updatedRowData);
            console.log("Generated XML:", xmlOutput);
            const base64EncodedXML = Buffer.from(xmlOutput).toString('base64');
    
            console.log("Base64 Encoded XML:", base64EncodedXML);
    
            try {
                const authResponse = await axios.get('https://chembonddev.authentication.us10.hana.ondemand.com/oauth/token', {
                    params: { grant_type: 'client_credentials' },
                    auth: {
                        username: 'sb-ffaa3ab1-4f00-428b-be0a-1ec55011116b!b142994|ads-xsappname!b65488',
                        password: 'e44adb92-4284-4c5f-8d41-66f8c1125bc5$F4bN1ypCgWzc8CsnjwOfT157HCu5WL0JVwHuiuwHcSc='
                    }
                });
    
                const accessToken = authResponse.data.access_token;
                console.log("Access Token:", accessToken);
    
                const pdfResponse = await axios.post(
                    'https://adsrestapi-formsprocessing.cfapps.us10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName',
                    {
                        xdpTemplate: "Test/Default",
                        xmlData: base64EncodedXML,
                        formType: "print",
                        formLocale: "",
                        taggedPdf: 1,
                        embedFont: 0
                    },
                    {
                        headers: {
                            Authorization: `Bearer ${accessToken}`,
                            'Content-Type': 'application/json'
                        }
                    }
                );
    
                const fileContent = pdfResponse.data.fileContent;
                console.log("File Content:", fileContent);
    
                return fileContent;
    
            } catch (error) {
                console.error("Error occurred during PDF generation:", error);
                return req.error(500, "Error generating PDF.");
            }
    
        } catch (error) {
            console.error('Error fetching or processing data:', error);
            return req.error(500, 'Error fetching or processing data');
        }
    });    
    
});