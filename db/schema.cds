namespace com.satinfotech.sat;

using { managed, cuid } from '@sap/cds/common';
// using { API_PRODUCTION_ORDER_2_SRV as external } from '../srv/external/API_PRODUCTION_ORDER_2_SRV';

entity Entry : cuid, managed {
    key ID : UUID;
    @title: 'Serial Number'
    SerialNo : Integer;
    @title: 'Location Code'
    LocationCode : String(10);
    @title: 'Station From'
    StationFrom : String(50);
    @title: 'Description'
    Description : String(255);
    @title: 'Item Description'
    ItemDescription : String(255);
    @title: 'Document Date'
    DocumentDate : Date;
    @title: 'Time'
    Time : Time;
    @title: 'Posting Date'
    PostingDate : Date;
    @title: 'L.R. No'
    LRNo : String(20);
    @title: 'L.R. No Date'
    LRNoDate : Date;
    @title: 'Vehicle No'
    VehicleNo : String(20);
    @title: 'Transporter'
    Transporter : String(100);
    @title: 'Transporter Name'
    TransporterName : Association to Transporters;
    @title: 'Note'
    Note : String(500);

    Details : Composition of many {
        @title: 'Store Level'
        StoreLevel : String(50);
        @title: 'Average Weight'
        @readonly AverageWeight : Decimal(10, 2);
        @title: 'Container Weight'
        ContainerWeight : Decimal(10, 2);
        @title: 'Accepted Weight'
        AcceptedWeight : Decimal(10, 2);
        @title: 'Gross Weight (Supplier)'
        @readonly GrossWeightSupplier : Decimal(10, 2);
        @title: 'Net Weight (Supplier)'
        @readonly NetWeightSupplier : Decimal(10, 2);
        @title: 'Difference Weight'
        @readonly DifferenceWeight : Decimal(10, 2);
        @title: 'Packing Material'
        PackingMaterial : String(100);
        @title: 'Weight of Packing Material'
        @readonly WeightPackingMaterial : Decimal(10, 2);
        @title: 'Bag Weight (Party)'
        BagWeightParty : Decimal(10, 2);
        @title: 'Bag Weight (LX)'
        BagWeightLX : Decimal(10, 2);
        @title: 'Type of Scrap'
        TypeOfScrap : String(50);
        @title: 'Unloading By'
        UnloadingBy : String(50);
        @title: 'Challan No'
        ChallanNo : String(20);
        @title: 'Source No'
        SourceNo : String(50);
        @title: 'Source Type'
        SourceType : String(50);
    };

    Purchase : Composition of many {

            @title: 'Purchase Order'
            ManufacturingOrder : Decimal(10, 2);
            @title: 'Item'
            ManufacturingOrderItem : Decimal(10, 2);
            @title: 'Material'
            Material : String(50);
            @title: 'Quantity'
            TotalQuantity : Decimal(10, 2);
            @title: 'Quantity Unit'
            ProductionUnit : String(20);
            @title: 'Storage Location'
            StorageLocation : String(50);

    }


}

entity PurchaseOrders  {
            @title: 'Purchase Order'
            ManufacturingOrder : Decimal(10, 2);
            @title: 'Item'
            ManufacturingOrderItem : Decimal(10, 2);
            @title: 'Material'
            Material : String(50);
            @title: 'Quantity'
            TotalQuantity : Decimal(10, 2);
            @title: 'Quantity Unit'
            ProductionUnit : String(20);
            @title: 'Storage Location'
            StorageLocation : String(50);
}

entity Transporters {
    @title: 'Name'
    key Name : String(100);
}
