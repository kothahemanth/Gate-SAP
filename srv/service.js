const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  this.before(['CREATE', 'UPDATE'], 'GateEntry', (req) => {
    const { AcceptedWeight, NetWeightSupplier } = req.data;

    if (AcceptedWeight != null && NetWeightSupplier != null) {
      if (typeof AcceptedWeight === 'number' && typeof NetWeightSupplier === 'number') {
        const difference = AcceptedWeight - NetWeightSupplier;
        const dis = AcceptedWeight;

        req.data.DifferenceWeight = difference;
        req.data.WeightPackingMaterial = difference; 
        req.data.BagWeightParty = difference; 
        req.data.GrossWeightSupplier = dis;

      } else {
        req.error(400, 'AcceptedWeight and NetWeightSupplier must be numeric values.');
      }
    } else {
      req.error(400, 'AcceptedWeight and NetWeightSupplier must be provided.');
    }
  });

  this.before(['CREATE', 'UPDATE'], 'GateEntry', (req) => {
    const { AcceptedWeight, DifferenceWeight } = req.data;

    if (AcceptedWeight != null && DifferenceWeight != null) {
      if (typeof AcceptedWeight === 'number' && typeof DifferenceWeight === 'number') {

        const average = AcceptedWeight + DifferenceWeight;

        req.data.AverageWeight = average;

      } else {
        req.error(400, 'AcceptedWeight and DifferenceWeight must be numeric values.');
      }
    } else {
      req.error(400, 'AcceptedWeight and DifferenceWeight must be provided.');
    }
  });
});
