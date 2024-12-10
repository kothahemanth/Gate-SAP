// const cds = require('@sap/cds');

// module.exports = cds.service.impl(async function () {
  
//   this.before(['CREATE', 'UPDATE'], 'Entry', async (req) => {
//     const { Details } = req.data;

//     if (Details && Array.isArray(Details)) {
//         Details.forEach((detail) => {
//             const { AcceptedWeight, BagWeightParty } = detail;

//             if (AcceptedWeight == null || BagWeightParty == null) {
//                 req.error(400, 'AcceptedWeight and BagWeightParty are required in Details.');
//             }

//             if (typeof AcceptedWeight !== 'number' || typeof BagWeightParty !== 'number') {
//                 req.error(400, 'AcceptedWeight and BagWeightParty must be numeric in Details.');
//             }

//             const grossWeight = AcceptedWeight;
//             const netWeight = AcceptedWeight - BagWeightParty;
//             const differenceWeight = AcceptedWeight - netWeight;
//             const weightPackingMaterial = AcceptedWeight - netWeight;
//             const averageWeight = AcceptedWeight + differenceWeight;

//             detail.GrossWeightSupplier = grossWeight;
//             detail.NetWeightSupplier = netWeight;
//             detail.DifferenceWeight = differenceWeight;
//             detail.WeightPackingMaterial = weightPackingMaterial;
//             detail.AverageWeight = averageWeight;
//         });
//     }
// });

// this.before(['CREATE', 'UPDATE'], 'Entry', async (req) => {
//     const { TransporterName_Name } = req.data;
//     const { Transporters } = this.entities;
//     if (TransporterName_Name) {
//         // Check if the transporter already exists
//         const existingTransporter = await SELECT.one.from(Transporters).where({ Name: TransporterName_Name });

//         if (!existingTransporter) {
//             // Create a new transporter entry
//             await INSERT.into(Transporters).entries({ Name: TransporterName_Name });
//         }
//     }
// });


// });

const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const PurchaseOrderAPI = await cds.connect.to("API_PRODUCTION_ORDER_2_SRV");
    const { Transporters } = this.entities;

    this.before(['CREATE', 'UPDATE'], 'Entry', async (req) => {
        const { Details, TransporterName_Name } = req.data;

        // Handle Details processing
        if (Details && Array.isArray(Details)) {
            Details.forEach((detail) => {
                const { AcceptedWeight, BagWeightParty } = detail;

                if (AcceptedWeight == null || BagWeightParty == null) {
                    req.error(400, 'AcceptedWeight and BagWeightParty are required in Details.');
                }

                if (typeof AcceptedWeight !== 'number' || typeof BagWeightParty !== 'number') {
                    req.error(400, 'AcceptedWeight and BagWeightParty must be numeric in Details.');
                }

                // Calculate weights
                const grossWeight = AcceptedWeight;
                const netWeight = AcceptedWeight - BagWeightParty;
                const differenceWeight = AcceptedWeight - netWeight;
                const weightPackingMaterial = AcceptedWeight - netWeight;
                const averageWeight = AcceptedWeight + differenceWeight;

                // Update the detail object with calculated fields
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
    });

    this.before("READ", "PurchaseOrders", async (req) => {
        req.query.SELECT.columns = [
            { ref: ["ManufacturingOrder"] },
            { ref: ["Material"] },
            { ref: ["TotalQuantity"] },
            { ref: ["ProductionUnit"] },
            { ref: ["to_ProductionOrderItem"], expand: ["*"] }
        ];
        try {
            let res = await PurchaseOrderAPI.run(req.query);
            console.log(res);
            if (!Array.isArray(res)) {
                res = [res];
            }
            res.forEach((element) => {
                element.to_ProductionOrderItem.forEach((item) => {
                    element.req_material = item.Material;
                    element.req_requiredquantity = item.RequiredQuantity; 
                });
            });
            console.log(res);
            return res;
        } catch (error) {
            console.error("Error reading SalesOrder:", error);
            return req.error(500, "Failed to fetch data from SalesOrder service");
        }
    });
});

