namespace com.satinfotech.sat;

using { managed, cuid } from '@sap/cds/common';
using { CE_PURCHASEORDER_0001 as external } from '../srv/external/CE_PURCHASEORDER_0001';

entity Entry : cuid, managed {
    key ID : UUID;
    @title: 'Serial Number'
    SerialNo : String(150);
    @title : 'GRN NO.'
    GRN_No : String(150);
    @title : 'GRN Date'
    GRN_Date : Date;
    @title: 'Order No'
    Order_no : String(150);
    @title: 'Order Date'
    Order_date : Date;
    @title: 'Purchaser'
    Purchaser_name : String(150);
    @title: 'Location Code'
    LocationCode : String(150);
    @title: 'Station From'
    StationFrom : String(150);
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
    LRNo : String(150);
    @title: 'L.R. No Date'
    LRNoDate : Date;
    @title: 'Vehicle No'
    VehicleNo : String(150);
    @title: 'Transporter'
    Transporter : String(100);
    @title: 'Transporter Name'
    TransporterName : Association to Transporters;
    @title: 'Transporter Phone Number'
    TransporterPh : String(150);
    @title: 'Driver Name'
    DriverName : String(150);
    @title: 'Driver Phone Number'
    Driverph : String(150);
    @title: 'Note'
    Note : String(150);
    @title: 'Freight'
    Freight : Association to FreightInfo;

    Details : Composition of many {
    @UI.Hidden 
    key ID:UUID;
        @title: 'Store Level'
        StoreLevel : String(150);
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
        TypeOfScrap : String(150);
        @title: 'Unloading By'
        UnloadingBy : String(150);
        @title: 'Challan No'
        ChallanNo : String(120);
        @title: 'Challan No'
        ChallanDate : Date;
        @title: 'Source No'
        SourceNo : String(150);
        @title: 'Source Type'
        SourceType : String(150);
    };

    Purchase : Composition of many {
        @UI.Hidden 
        key ID:UUID;
            @title: 'Purchase Order'
            PurchaseOrder :String(150);
            @title: 'Item'
            @readonly PurchaseOrderItem : Decimal(10, 2);
            @title: 'Purchase Order Item Text'
            @readonly PurchaseOrderItemText : String(150);
            @title: 'Material'
            @readonly Material : String(150);
            @title: 'Plant'
            @readonly Plant : String(150);
            @title: 'Base Unit'
            @readonly BaseUnit : String(150);
            @title: 'Quantity'
            @readonly OrderQuantity : Decimal(10, 2);
            @title: 'Storage Location'
            @readonly StorageLocation : String(150);
            @title: 'Company Code'
            @readonly CompanyCode : String(150);
            @title: 'Tax Code'
            @readonly TaxCode : String(150);
            @title: 'HSN Code'
            @readonly ConsumptionTaxCtrlCode : String(150);
            @title: 'UOP'
            @readonly OrderPriceUnit : String(150);
            @title: 'Department'
            Departmen : String(150);
            @title: 'Indent No.'
            indentNo : String(150);
            
    };

    Weight : Composition of many {
        @UI.Hidden 
        key ID:UUID;
            @title: '1st Wt.'
            FirstWt :Decimal(10, 2);
            @title: '2nd Wt.'
            SecondWt : Decimal(10, 2);
            @title: '3rd Wt.'
            ThirdWt : Decimal(10, 2);
            @title: 'Lx Avg Wt.'
            @readonly LxAvgWt : Decimal(10, 2);
            @title: 'Lx Net Wt.'
            LxNetWt : Decimal(10, 2);
            @title: 'Diff. Wt. (+/-)'
            DiffWt : Decimal(10, 2);
            @title: 'Port Wt.'
            PortWt : Decimal(10, 2);
            @title: 'Cont Wt.'
            ContWt : Decimal(10, 2);
            @title: 'Party Gross Wt.'
            PartyGrWt : Decimal(10, 2);
            @title: 'Party Net Wt.'
            PartyNetWt :Decimal(10, 2);
            @title: 'Party Wt.'
            PartyWt : Decimal(10, 2);
            @title: 'Container No./Seal No.'
            Conwt : String(50);
    }

    Remarks : Composition of many {
        @UI.Hidden 
        key ID:UUID;
            @title: 'Remarks'
            remark :String(300); 
    }
}
entity PurchaseOrders as projection on external.PurchaseOrderItem {
            *
};

entity PurchasePricing as projection on external.PurOrderItemPricingElement {
            *
};

entity Transporters {
    @title: 'Name'
    key Name : String(100);
}

entity FreightInfo {
    @title: 'Info'
    key Desc : String(100);
}