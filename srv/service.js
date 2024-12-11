const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const PurchaseOrderAPI = await cds.connect.to("CE_PURCHASEORDER_0001");
    const { Transporters, PurchaseOrders } = this.entities;

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
});