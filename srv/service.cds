using {com.satinfotech.sat as db} from '../db/schema';
// using { API_PRODUCTION_ORDER_2_SRV as PurchaseOrderAPI } from '../srv/external/API_PRODUCTION_ORDER_2_SRV';

service satinfotech {

    entity Entry as projection on db.Entry actions {
        action productData() returns String;
    };
    entity Transporters as projection on db.Transporters;
    entity FreightInfo as projection on db.FreightInfo;
    entity PurchaseOrders as projection on db.PurchaseOrders;
entity PurchasePricing as projection on db.PurchasePricing{
  key  PurchaseOrder,
   key  PurchaseOrderItem,
    ConditionType,
    ConditionAmount,
    ConditionQuantity,

}

}
entity PurchasePricing as projection on db.PurchasePricing{
    key PurchaseOrder,
    key PurchaseOrderItem,
    ConditionType,
    ConditionAmount,
    ConditionQuantity,
    ConditionRateRatio
}

entity PurchaseOrders as projection on db.PurchaseOrders{
    @title: 'Purchase Order'
    PurchaseOrder : Decimal(10, 2),
    @title: 'Material'
    Material : String(50),
    @title: 'Plant'
    Plant : String(50),
    @title: 'Quantity'
    OrderQuantity : Decimal(20),
    @title: 'Item'
    PurchaseOrderItem : String,
    @title: 'Purchase Order Item Text'
    PurchaseOrderItemText : String(150),
    @title: 'Quantity Unit'
    BaseUnit : String(20),
    @title: 'Storage Location'
    StorageLocation : String(50),
    @title: 'Tax Code'
    TaxCode : String(50),
    @title: 'Company Code'
    CompanyCode : String(50),
    @title: 'HSN Code'
    ConsumptionTaxCtrlCode : String(50),
    @title: 'UOP'
    OrderPriceUnit : String(50),
    *
}

annotate satinfotech.Entry with @odata.draft.enabled;
annotate satinfotech.Transporters with @odata.draft.enabled;
annotate satinfotech.FreightInfo with @odata.draft.enabled;

annotate satinfotech.Transporters with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: Name
    },
],
UI.FieldGroup #TransportDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Name
            },
        ]
    }
);

annotate satinfotech.FreightInfo with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: Desc
    },
],
UI.FieldGroup #FreightInfoDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Desc
            },
        ]
    }

);

annotate satinfotech.Entry with @(
    UI.LineItem: [
        {
            Label: 'Serial Number',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: SerialNo
        },
        {
            Label: 'GRN No.',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: GRN_No
        },
        {
            Label: 'GRN Date',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: GRN_Date
        },
        {
            Label: 'Order No.',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Order_no
        },
        {
            Label: 'Order Date',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Order_date
        },
        {
            Label: 'Purchaser',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Purchaser_name
        },
        {
            Label: 'Location Code',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: LocationCode
        },
        {
            Label: 'Station From',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: StationFrom
        },
        {
            Label: 'Description',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Description
        },
        {
            Label: 'Item Description',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: ItemDescription
        },
        {
            Label: 'Document Date',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: DocumentDate
        },
        {
            Label: 'Time',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Time
        },
        {
            Label: 'Posting Date',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: PostingDate
        },
        {
            Label: 'L.R. No',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: LRNo
        },
        {
            Label: 'L.R. No Date',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: LRNoDate
        },
        {
            Label: 'Vehicle No',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: VehicleNo
        },
        {
            Label: 'Transporter',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Transporter
        },
        {
            Label: 'Transporter Name',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: TransporterName_Name
        },
        {
            Label: 'Transporter Phone Number',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: TransporterPh
        },
        {
            Label: 'Driver Name',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: DriverName
        },
        {
            Label: 'Driver Phone Number',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Driverph
        },
        {
            Label: 'Note',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Note
        },
        {
            Label: 'Freight',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Freight_Desc
        },
        {
            Label: 'Pay-to Vendor No.',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: VendorNo
        },
    ],
    UI.FieldGroup #GateEntryDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: SerialNo
            },
            {
                $Type: 'UI.DataField',
                Value: GRN_No
            },
            {
                $Type: 'UI.DataField',
                Value: GRN_Date
            },
            {
                $Type: 'UI.DataField',
                Value: Order_no
            },
            {
                $Type: 'UI.DataField',
                Value: Order_date
            },
            {
                $Type: 'UI.DataField',
                Value: Purchaser_name
            },
            {
                $Type: 'UI.DataField',
                Value: LocationCode
            },
            {
                $Type: 'UI.DataField',
                Value: StationFrom
            },
            {
                $Type: 'UI.DataField',
                Value: Description
            },
            {
                $Type: 'UI.DataField',
                Value: ItemDescription
            },
            {
                $Type: 'UI.DataField',
                Value: DocumentDate
            },
            {
                $Type: 'UI.DataField',
                Value: Time
            },
            {
                $Type: 'UI.DataField',
                Value: PostingDate
            },
            {
                $Type: 'UI.DataField',
                Value: LRNo
            },
            {
                $Type: 'UI.DataField',
                Value: LRNoDate
            },
            {
                $Type: 'UI.DataField',
                Value: VehicleNo
            },
            {
                $Type: 'UI.DataField',
                Value: Transporter
            },
            {
                $Type: 'UI.DataField',
                Value: TransporterName_Name
            },
            {
                $Type: 'UI.DataField',
                Value: TransporterPh
            },
            {
                $Type: 'UI.DataField',
                Value: DriverName
            },
            {
                $Type: 'UI.DataField',
                Value: Driverph
            },
            {
                $Type: 'UI.DataField',
                Value: Note
            },
            {
                $Type: 'UI.DataField',
                Value: Freight_Desc
            },
            {
                $Type: 'UI.DataField',
                Value: VendorNo
            },
        ]
    },

    UI.Facets: [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GateEntryFacet',
        Label : 'Gate Entry Details',
        Target: '@UI.FieldGroup#GateEntryDetails'
    },
    {
        $Type : 'UI.ReferenceFacet',
        ID    : 'MaterialInfoFacet',
        Label : 'Material Information',
        Target: 'Details/@UI.LineItem',
    },
    {
        $Type : 'UI.ReferenceFacet',
        ID    : 'PurchaseInfoFacet',
        Label : 'Purchase Information',
        Target: 'Purchase/@UI.LineItem',
    },
    {
        $Type : 'UI.ReferenceFacet',
        ID    : 'WeightInfoFacet',
        Label : 'Weight Information',
        Target: 'Weight/@UI.LineItem',
    },
    {
        $Type : 'UI.ReferenceFacet',
        ID    : 'RemarksInfoFacet',
        Label : 'Remarks Information',
        Target: 'Remarks/@UI.LineItem',
    }
    ]
);

annotate satinfotech.Entry.Details with @(
    UI.LineItem: [
        {
            Label: 'Store Level',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: StoreLevel
        },
        {
            Label: 'Average Weight',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: AverageWeight
        },
        {
            Label: 'Container Weight',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: ContainerWeight
        },
        {
            Label: 'Accepted Weight',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: AcceptedWeight
        },
        {
            Label: 'Gross Weight (Supplier)',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: GrossWeightSupplier
        },
        {
            Label: 'Net Weight (Supplier)',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: NetWeightSupplier
        },
        {
            Label: 'Difference Weight',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: DifferenceWeight
        },
        {
            Label: 'Packing Material',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: PackingMaterial
        },
        {
            Label: 'Weight of Packing Material',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: WeightPackingMaterial
        },
        {
            Label: 'Bag Weight (Party)',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: BagWeightParty
        },
        {
            Label: 'Bag Weight (LX)',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: BagWeightLX
        },
        {
            Label: 'Type of Scrap',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: TypeOfScrap
        },
        {
            Label: 'Unloading By',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: UnloadingBy
        },
        {
            Label: 'Challan No',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: ChallanNo
        },
        {
            Label: 'Challan Date',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: ChallanDate
        },
        {
            Label: 'Source No',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: SourceNo
        },
        {
            Label: 'Source Type',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: SourceType
        }
    ],
);

annotate satinfotech.Entry.Details with @(UI.FieldGroup #WeightInformation: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
                $Type: 'UI.DataField',
                Value: StoreLevel
            },
            {
                $Type: 'UI.DataField',
                Value: AverageWeight
            },
            {
                $Type: 'UI.DataField',
                Value: ContainerWeight
            },
            {
                $Type: 'UI.DataField',
                Value: AcceptedWeight
            },
            {
                $Type: 'UI.DataField',
                Value: GrossWeightSupplier
            },
            {
                $Type: 'UI.DataField',
                Value: NetWeightSupplier
            },
            {
                $Type: 'UI.DataField',
                Value: DifferenceWeight
            },
            {
                $Type: 'UI.DataField',
                Value: PackingMaterial
            },
            {
                $Type: 'UI.DataField',
                Value: WeightPackingMaterial
            },
            {
                $Type: 'UI.DataField',
                Value: BagWeightParty
            },
            {
                $Type: 'UI.DataField',
                Value: BagWeightLX
            },
            {
                $Type: 'UI.DataField',
                Value: TypeOfScrap
            },
            {
                $Type: 'UI.DataField',
                Value: UnloadingBy
            },
            {
                $Type: 'UI.DataField',
                Value: ChallanNo
            },
            {
                $Type: 'UI.DataField',
                Value: ChallanDate
            },
            {
                $Type: 'UI.DataField',
                Value: SourceNo
            },
            {
                $Type: 'UI.DataField',
                Value: SourceType
            }
    ]
});

annotate satinfotech.Entry.Purchase with @(
    UI.LineItem: [
        {
            Label: 'Purchase Order',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: PurchaseOrder
        },
        {
            Label: 'P.O Item',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: PurchaseOrderItem
        },
        {   
            ![@UI.Hidden],
            Label: 'P.O Item Text',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: PurchaseOrderItemText
        },   
        {
            Label: 'Material',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: Material
        },
        {
            ![@UI.Hidden],
            Label: 'Plant',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: Plant
        },
        {
            Label: 'Base Unit',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: BaseUnit
        },
        {
            Label: 'Quantity',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: OrderQuantity
        },
        {
            Label: 'Storage Location',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: StorageLocation
        },
        {
            ![@UI.Hidden],
            Label: 'Company Code',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: CompanyCode
        },
        {
            ![@UI.Hidden],
            Label: 'Tax Code',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: TaxCode
        },
        {
            ![@UI.Hidden],
            Label: 'HSN Code',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: ConsumptionTaxCtrlCode
        },
        {
            ![@UI.Hidden],
            Label: 'UOP',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: OrderPriceUnit
        },
        {
            Label: 'Department',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: Departmen
        },
        {
            Label: 'Indent No.',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: indentNo
        },
    ],
);

annotate satinfotech.Entry.Purchase with @(UI.FieldGroup #Information: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
                $Type: 'UI.DataField',
                Value: PurchaseOrder
            },
            {
                $Type: 'UI.DataField',
                Value: PurchaseOrderItem
            },
            {
                $Type: 'UI.DataField',
                Value: PurchaseOrderItemText
            },
            {
                $Type: 'UI.DataField',
                Value: Material
            },
            {
                $Type: 'UI.DataField',
                Value: Plant
            },
            {
                $Type: 'UI.DataField',
                Value: BaseUnit
            },
            {
                $Type: 'UI.DataField',
                Value: OrderQuantity
            },
            {
                $Type: 'UI.DataField',
                Value: StorageLocation
            },
            {
                $Type: 'UI.DataField',
                Value: CompanyCode
            },
            {
                $Type: 'UI.DataField',
                Value: TaxCode
            },
            {
                $Type: 'UI.DataField',
                Value: ConsumptionTaxCtrlCode
            },
            {
                $Type: 'UI.DataField',
                Value: OrderPriceUnit
            },
            {
                $Type: 'UI.DataField',
                Value: Departmen
            },
            {
                $Type: 'UI.DataField',
                Value: indentNo
            },
    ]
});

annotate satinfotech.Entry.Weight with @(
    UI.LineItem: [
        {
            Label: '1st Wt.',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: FirstWt
        },
        {
            Label: '2nd Wt.',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: SecondWt
        },
        {
            Label: '3rd Wt.',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: ThirdWt
        },
        {
            Label: 'Lx Avg Wt.',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: LxAvgWt
        },
        {
            Label: 'Lx Net Wt.',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: LxNetWt
        },
        {
            Label: 'Diff. Wt. (+/-)',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: DiffWt
        },
        {
            Label: 'Port Wt.',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: PortWt
        },
        {
            Label: 'Cont Wt.',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: ContWt
        },
        {
            Label: 'Party Gross Wt.',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: PartyGrWt
        },
        {
            Label: 'Party Net Wt',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: PartyNetWt
        },
        {
            Label: 'Party Wt.',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: PartyWt
        },
        {
            Label: 'Container No./Seal No.',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: Conwt
        },
    ],
);

annotate satinfotech.Entry.Weight with @(UI.FieldGroup #Information: {
    $Type: 'UI.FieldGroupType',
    Data : [
            {
                $Type: 'UI.DataField',
                Value: FirstWt
            },
            {
                $Type: 'UI.DataField',
                Value: SecondWt
            },
            {
                $Type: 'UI.DataField',
                Value: ThirdWt
            },
            {
                $Type: 'UI.DataField',
                Value: LxAvgWt
            },
            {
                $Type: 'UI.DataField',
                Value: LxNetWt
            },
            {
                $Type: 'UI.DataField',
                Value: DiffWt
            },
            {
                $Type: 'UI.DataField',
                Value: PortWt
            },
            {
                $Type: 'UI.DataField',
                Value: ContWt
            },
            {
                $Type: 'UI.DataField',
                Value: PartyGrWt
            },
            {
                $Type: 'UI.DataField',
                Value: PartyNetWt
            },
            {
                $Type: 'UI.DataField',
                Value: PartyWt
            },
            {
                $Type: 'UI.DataField',
                Value: Conwt
            },
    ]
});

annotate satinfotech.Entry.Remarks with @(
    UI.LineItem: [
        {
            Label: 'Remarks',
            ![@HTML5.CssDefaults]: {width:'9rem'},
            Value: remark
        }
    ],
);

annotate satinfotech.Entry.Remarks with @(UI.FieldGroup #RemarksInformation: {
    $Type: 'UI.FieldGroupType',
    Data : [
            {
                $Type: 'UI.DataField',
                Value: remark
            },
    ]
});

annotate PurchaseOrders with @(
    UI.LineItem: [
        {
            Label: 'Purchase Order',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: PurchaseOrder
        },
        {
            Label: 'Item',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: PurchaseOrderItem
        },
        {
            Label: 'Material',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: Material
        },
        {
            Label: 'Quantity',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: BaseUnit
        },
        {
            Label: 'Quantity Unit',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: OrderQuantity
        },
        {
            Label: 'Storage Location',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: StorageLocation
        },
    ],
);

annotate PurchaseOrders with @(UI.FieldGroup #Information: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
                $Type: 'UI.DataField',
                Value: PurchaseOrder
            },
            {
                $Type: 'UI.DataField',
                Value: PurchaseOrderItem
            },
            {
                $Type: 'UI.DataField',
                Value: Material
            },
            {
                $Type: 'UI.DataField',
                Value: BaseUnit
            },
            {
                $Type: 'UI.DataField',
                Value: OrderQuantity
            },
            {
                $Type: 'UI.DataField',
                Value: StorageLocation
            },
    ]
});

annotate satinfotech.Entry with {
    TransporterName @(
        // Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Transporters',
            CollectionPath: 'Transporters',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: TransporterName_Name,
                    ValueListProperty: 'Name'
                }
            ]
        }
    );
};

annotate satinfotech.Entry with {
    Freight @(
        // Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'FreightInfo',
            CollectionPath: 'FreightInfo',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Freight_Desc,
                    ValueListProperty: 'Desc'
                }
            ]
        }
    );
};

annotate satinfotech.Entry.Purchase with {
    PurchaseOrder @(
        Common.ValueList: {
            Label: 'PurchaseOrder',
            CollectionPath: 'PurchaseOrders',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'PurchaseOrder',
                    ValueListProperty: 'PurchaseOrder'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'PurchaseOrderItem',  
                    ValueListProperty: 'PurchaseOrderItem'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'PurchaseOrderItemText',  
                    ValueListProperty: 'PurchaseOrderItemText'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'Plant',  
                    ValueListProperty: 'Plant'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'Material',  
                    ValueListProperty: 'Material'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'BaseUnit',  
                    ValueListProperty: 'BaseUnit'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'OrderQuantity',  
                    ValueListProperty: 'OrderQuantity'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'StorageLocation',  
                    ValueListProperty: 'StorageLocation'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'TaxCode',  
                    ValueListProperty: 'TaxCode'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'CompanyCode',  
                    ValueListProperty: 'CompanyCode'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'ConsumptionTaxCtrlCode',  
                    ValueListProperty: 'ConsumptionTaxCtrlCode'
                },
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'OrderPriceUnit',  
                    ValueListProperty: 'OrderPriceUnit'
                }
            ]
        }
    );
};
