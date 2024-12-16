const cds = require('@sap/cds');
const json2xml = require('json2xml');
const axios = require('axios');

module.exports = cds.service.impl(async function () {
    const PurchaseOrderAPI = await cds.connect.to("CE_PURCHASEORDER_0001");
    const { Transporters, PurchaseOrders, Entry,PurchasePricing } = this.entities;

    this.before(['CREATE', 'UPDATE'], 'Entry', async (req) => {
        const { Details, TransporterName_Name, Purchase, Weight } = req.data;

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
       return  await PurchaseOrderAPI.run(req.query);
    });

    this.on("READ", "PurchaseOrders", async (req) => {
        req.query.SELECT.columns = [
            { ref: ["PurchaseOrder"] },
            { ref: ["PurchaseOrderItem"] },
            { ref: ["Plant"]},
            { ref: ["Material"] },
            { ref: ["BaseUnit"] },
            { ref: ["OrderQuantity"] },
            { ref: ["StorageLocation"] },
            { ref: ["CompanyCode"] },
            { ref: ["TaxCode"] },
            { ref: ["ConsumptionTaxCtrlCode"]},
            { ref: ["OrderPriceUnit"]},
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
    
        // Fetch the main row data including Purchase details
        const rowData = await SELECT.one.from(Entry)
            .columns(
                '*', 
                { ref: ['Details'], expand: ['*'] },
                { ref: ['Purchase'], expand: ['*'] },
                { ref: ['Weight'], expand: ['*'] }
            )
            .where({ ID });
    
        if (!rowData) {
            return req.error(404, `No data found for ID: ${ID}`);
        }
    
        console.log("Row data before PurchasePricing:", rowData);
        
        const fetchPricingElements = async () => {
          
            const extractedData = rowData.Purchase.map(purchase => ({
                PurchaseOrder: purchase.PurchaseOrder,
                PurchaseOrderItem: purchase.PurchaseOrderItem
            }));
            const pricingPromises = extractedData.map(async (purchase) => {
                const { PurchaseOrder, PurchaseOrderItem } = purchase;
                console.log('Fetching pricing for:', PurchaseOrder, PurchaseOrderItem);
                
                const purchasePricingData = await PurchaseOrderAPI.run(
                    SELECT.from('PurOrderItemPricingElement')
                        .where({
                            PurchaseOrder: String(PurchaseOrder),  
                            PurchaseOrderItem: String(PurchaseOrderItem)  
                        })
                        .columns('ConditionType', 'ConditionQuantity', 'ConditionAmount')
                );
                
                console.log('Filtered Pricing Elements for', PurchaseOrder, PurchaseOrderItem, purchasePricingData);
                
                // Map the pricing data to an array of objects where each object represents a pricing element
                const pricingElements = purchasePricingData.map(pricing => ({
                    ConditionType: pricing.ConditionType,
                    ConditionQuantity: pricing.ConditionQuantity,
                    ConditionAmount: pricing.ConditionAmount
                }));
                
                return { PurchaseOrder, PurchaseOrderItem, pricingElements };
            });
            
            const pricingData = await Promise.all(pricingPromises);
            console.log('pricingData',pricingData)
            // const pricingPromises = extractedData.map(async (purchase) => {
            //     const { PurchaseOrder, PurchaseOrderItem } = purchase;
            //     console.log('Fetching pricing for:', PurchaseOrder, PurchaseOrderItem);
                
            //     const purchasePricingData = await PurchaseOrderAPI.run(
            //         SELECT.from('PurOrderItemPricingElement')
            //             .where({
            //                 PurchaseOrder: String(PurchaseOrder),  
            //                 PurchaseOrderItem: String(PurchaseOrderItem)  
            //             })
            //             .columns('ConditionType', 'ConditionQuantity','ConditionAmount')
            //     );
                
            //     console.log('Filtered Pricing Elements for', PurchaseOrder, PurchaseOrderItem, purchasePricingData);
                
            //     return { PurchaseOrder, PurchaseOrderItem, pricingElements: purchasePricingData };
            // });
    
         
            // const pricingData = await Promise.all(pricingPromises);
            
           
            rowData.Purchase.forEach((purchase) => {
                const pricingInfo = pricingData.find(p => p.PurchaseOrder === purchase.PurchaseOrder && p.PurchaseOrderItem === purchase.PurchaseOrderItem);
                if (pricingInfo) {
                    purchase.PricingElements = pricingInfo.pricingElements;
                }
            });
            
            console.log("Row data after attaching pricing:", rowData);
            rowData.Purchase.forEach((purchase, index) => {
                console.log(`Purchase ${index + 1}:`);
                console.log('Pricing Elements:', purchase.PricingElements);  // Print Pricing Elements for each purchase
            });
        
            
            return rowData;  // Return the row data with the attached pricing
        };
        
        // Call the function to fetch and attach pricing data
        try {
            const updatedRowData = await fetchPricingElements();
            
            const xmlfun = (rowData) => {
                // Convert row data to XML format, including PricingElement tags
                const json2xmlOptions = { header: true, prettyPrint: true };
                
                // Iterate through purchases and pricing elements to create the desired XML structure
                const rowDataWithPricingElements = {
                    Entry: {
                        ...rowData,  // Include the rest of the rowData
                        Purchase: rowData.Purchase.map(purchase => ({
                            ...purchase,
                            PricingElements: purchase.PricingElements ? purchase.PricingElements.map(pricing => ({
                                PricingElement: {
                                    ConditionType: pricing.ConditionType,
                                    ConditionQuantity: pricing.ConditionQuantity,
                                    ConditionAmount:pricing.ConditionAmount,

                                }
                            })) : []
                        }))
                    }
                };
                
                const xmlData = json2xml(rowDataWithPricingElements, json2xmlOptions);
                return xmlData;
            };
            
            const xmlOutput = xmlfun(updatedRowData);
            console.log("Generated XML:", xmlOutput);
            const base64EncodedXML = Buffer.from(xmlOutput).toString('base64');
    
        console.log("Base64 Encoded XML:", base64EncodedXML);
    
        try {
            const authResponse = await axios.get('https://chembonddev.authentication.us10.hana.ondemand.com/oauth/token', {
                params: {
                    grant_type: 'client_credentials'
                },
                auth: {
                    username: 'sb-ffaa3ab1-4f00-428b-be0a-1ec55011116b!b142994|ads-xsappname!b65488',
                    password: 'e44adb92-4284-4c5f-8d41-66f8c1125bc5$F4bN1ypCgWzc8CsnjwOfT157HCu5WL0JVwHuiuwHcSc='
                }
            });
    
            const accessToken = authResponse.data.access_token;
            console.log("Access Token:", accessToken);
    
            // Render the PDF
            const pdfResponse = await axios.post('https://adsrestapi-formsprocessing.cfapps.us10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName', {
                xdpTemplate: "hemanth/Default",
                xmlData: base64EncodedXML, 
                formType: "print",
                formLocale: "",
                taggedPdf: 1,
                embedFont: 0
            }, {
                headers: {
                    Authorization: `Bearer ${accessToken}`,
                    'Content-Type': 'application/json'
                }
            });
    
            const fileContent = pdfResponse.data.fileContent;
            console.log("File Content:", fileContent);
    
            return fileContent;
    
        } catch (error) {
            console.error("Error occurred:", error);
            return req.error(500, "An error occurred while processing your request.");
        }
            
            // You can send the XML data as the response or use it further
            //return xmlOutput;
        } catch (error) {
            console.error('Error fetching or processing pricing data:', error);
            return req.error(500, 'Error fetching or processing pricing data');
        }
        
        
    });
    
});