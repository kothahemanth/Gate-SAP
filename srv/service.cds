using {com.satinfotech.sat as db} from '../db/schema';

service satinfotech {

    entity Entry as projection on db.Entry;
    entity Transporters as projection on db.Transporters;

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