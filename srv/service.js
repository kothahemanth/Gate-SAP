const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  this.before(['CREATE', 'UPDATE'], 'GateEntry', (req) => {
    const { AcceptedWeight, BagWeightParty } = req.data;

    if (AcceptedWeight != null && BagWeightParty != null) {
      if (typeof AcceptedWeight === 'number' && typeof BagWeightParty === 'number') {
        const difference = AcceptedWeight - BagWeightParty;

        req.data.NetWeightSupplier = difference;
        // req.data.WeightPackingMaterial = difference; 
        // req.data.BagWeightParty = difference; 
        // req.data.GrossWeightSupplier = dis;

      } else {
        req.error(400, 'AcceptedWeight and NetWeightSupplier must be numeric values.');
      }
    } else {
      req.error(400, 'AcceptedWeight and NetWeightSupplier must be provided.');
    }
  });

  this.before(['CREATE', 'UPDATE'], 'GateEntry', (req) => {
    const { AcceptedWeight, NetWeightSupplier } = req.data;

    if (AcceptedWeight != null && NetWeightSupplier != null) {
      if (typeof AcceptedWeight === 'number' && typeof NetWeightSupplier === 'number') {

        const average = AcceptedWeight - NetWeightSupplier;
        const dis = AcceptedWeight;

        req.data.GrossWeightSupplier = dis;
        req.data.DifferenceWeight = average;
        req.data.WeightPackingMaterial = average;

      } else {
        req.error(400, 'AcceptedWeight and DifferenceWeight must be numeric values.');
      }
    } else {
      req.error(400, 'AcceptedWeight and DifferenceWeight must be provided.');
    }
  });
});
