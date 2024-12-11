namespace com.satinfotech.sat;

using { managed, cuid } from '@sap/cds/common';
using { CE_PURCHASEORDER_0001 as external } from '../srv/external/CE_PURCHASEORDER_0001';

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
    @title: 'Transporter Phone Number'
    TransporterPh : String(20);
    @title: 'Driver Name'
    DriverName : Date;
    @title: 'Driver Phone Number'
    Driverph : String(20);
    @title: 'Note'
    Note : String(500);

    Details : Composition of many {
    @UI.Hidden 
    key ID:UUID;
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
        @UI.Hidden 
        key ID:UUID;
            @title: 'Purchase Order'
            PurchaseOrder :String(10);
            @title: 'Item'
            PurchaseOrderItem : Decimal(10, 2);
            @title: 'Material'
            Material : String(50);
            @title: 'Base Unit'
            BaseUnit : String;
            @title: 'Quantity'
            OrderQuantity : Decimal;
            @title: 'Storage Location'
            StorageLocation : String(50);
    }
}

entity PurchaseOrders as projection on external.PurchaseOrderItem {
            *
};

entity Transporters {
    @title: 'Name'
    key Name : String(100);
}
