const cds = require('@sap/cds');
const json2xml = require('json2xml');
const axios = require('axios');

module.exports = cds.service.impl(async function () {
    const PurchaseOrderAPI = await cds.connect.to("CE_PURCHASEORDER_0001");
    const { Transporters, PurchaseOrders, Entry } = this.entities;

    this.before(['CREATE', 'UPDATE'], 'Entry', async (req) => {
        const { Details, TransporterName_Name, Purchase } = req.data;

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
                                'PurchaseOrderItem',
                                'OrderQuantity',
                                'BaseUnit',
                                'StorageLocation'
                            )
                            .where({ PurchaseOrder: PurchaseOrder });
        
                        if (purchaseOrderDetails) {
                            purchase.Material = purchaseOrderDetails.Material;
                            purchase.PurchaseOrderItem = purchaseOrderDetails.PurchaseOrderItem;
                            purchase.OrderQuantity = purchaseOrderDetails.OrderQuantity;
                            purchase.BaseUnit = purchaseOrderDetails.BaseUnit;
                            purchase.StorageLocation = purchaseOrderDetails.StorageLocation;
                        } else {
                            req.error(400, `No details found for Manufacturing Order ${Order}`);
                        }
                    } catch (error) {
                        req.error(500, `Error fetching data for Manufacturing Order ${Order}: ${error.message}`);
                    }
                }
            }
        }
    });

    this.on("READ", "PurchaseOrders", async (req) => {
        req.query.SELECT.columns = [
            { ref: ["PurchaseOrder"] },
            { ref: ["PurchaseOrderItem"] },
            { ref: ["Material"] },
            { ref: ["BaseUnit"] },
            { ref: ["OrderQuantity"] },
            { ref: ["StorageLocation"] },
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
    
        // Fetch the Entry with associated compositions
        const rowData = await SELECT.one.from(Entry)
        .columns(
        '*', 
        {ref:['Details'],expand:['*']},
        {ref:['Purchase'],expand:['*']},
        {ref:['Weight'],expand:['*']}
    )
    .where({ ID });
    
        if (!rowData) {
            return req.error(404, `No data found for ID: ${ID}`);
        }
    
        console.log("Row data:", rowData);
    
        // Function to generate XML
        const xmlfun = (rowData) => {
            const xmlData = json2xml({ Entry: rowData }, { header: true });
            return xmlData;
        };
    
        const callxml = xmlfun(rowData);
    
        console.log("Generated XML:", callxml);
        const base64EncodedXML = Buffer.from(callxml).toString('base64');
    
        console.log("Base64 Encoded XML:", base64EncodedXML);
    
        try {
            // Fetch OAuth token
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
        
    });
    
});