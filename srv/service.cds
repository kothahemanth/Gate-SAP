using {com.satinfotech.sat as db} from '../db/schema';
// using { API_PRODUCTION_ORDER_2_SRV as PurchaseOrderAPI } from '../srv/external/API_PRODUCTION_ORDER_2_SRV';

service satinfotech {

    entity Entry as projection on db.Entry actions {
        action productData() returns String;
    };
    entity Transporters as projection on db.Transporters;
    entity PurchaseOrders as projection on db.PurchaseOrders;

}

entity PurchaseOrders as projection on db.PurchaseOrders{
    @title: 'Purchase Order'
    PurchaseOrder : Decimal(10, 2),
    @title: 'Material'
    Material : String(50),
    @title: 'Quantity'
    OrderQuantity : Decimal(20),
    @title: 'Item'
    PurchaseOrderItem : String,
    @title: 'Quantity Unit'
    BaseUnit : String(20),
    @title: 'Storage Location'
    StorageLocation : String(50),
    *
}

annotate satinfotech.Entry with @odata.draft.enabled;
annotate satinfotech.Transporters with @odata.draft.enabled;

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

annotate satinfotech.Entry with @(
    UI.LineItem: [
        {
            Label: 'Serial Number',
            ![@HTML5.CssDefaults]: {width:'5rem'},
            Value: SerialNo
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
            Label: 'Item',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: PurchaseOrderItem
        },
        {
            Label: 'Material',
            ![@HTML5.CssDefaults]: {width:'6rem'},
            Value: Material
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
                }
            ]
        }
    );
};
