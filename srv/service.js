const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  
  this.before(['CREATE', 'UPDATE'], 'Entry', async (req) => {
    const { Details } = req.data;

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
            const differenceWeight = AcceptedWeight - netWeight;
            const weightPackingMaterial = AcceptedWeight - netWeight;
            const averageWeight = AcceptedWeight + differenceWeight;

            detail.GrossWeightSupplier = grossWeight;
            detail.NetWeightSupplier = netWeight;
            detail.DifferenceWeight = differenceWeight;
            detail.WeightPackingMaterial = weightPackingMaterial;
            detail.AverageWeight = averageWeight;
        });
    }
});

});
