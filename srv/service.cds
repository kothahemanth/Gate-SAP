using {com.satinfotech.sat as db} from '../db/schema';

service satinfotech {

    entity GateEntry as projection on db.GateEntry;

}

annotate satinfotech.GateEntry with @odata.draft.enabled;

annotate satinfotech.GateEntry with @(
    UI.LineItem: [
        {
            Label: 'Serial Number',
            Value: SerialNo
        },
        {
            Label: 'Location Code',
            Value: LocationCode
        },
        {
            Label: 'Station From',
            Value: StationFrom
        },
        {
            Label: 'Description',
            Value: Description
        },
        {
            Label: 'Item Description',
            Value: ItemDescription
        },
        {
            Label: 'Document Date',
            Value: DocumentDate
        },
        {
            Label: 'Time',
            Value: Time
        },
        {
            Label: 'Posting Date',
            Value: PostingDate
        },
        {
            Label: 'L.R. No',
            Value: LRNo
        },
        {
            Label: 'L.R. No Date',
            Value: LRNoDate
        },
        {
            Label: 'Vehicle No',
            Value: VehicleNo
        },
        {
            Label: 'Transporter',
            Value: Transporter
        },
        {
            Label: 'Transporter Name',
            Value: TransporterName
        },
        {
            Label: 'Note',
            Value: Note
        },
        {
            Label: 'Store Level',
            Value: StoreLevel
        },
        {
            Label: 'Average Weight',
            Value: AverageWeight
        },
        {
            Label: 'Container Weight',
            Value: ContainerWeight
        },
        {
            Label: 'Accepted Weight',
            Value: AcceptedWeight
        },
        {
            Label: 'Gross Weight (Supplier)',
            Value: GrossWeightSupplier
        },
        {
            Label: 'Net Weight (Supplier)',
            Value: NetWeightSupplier
        },
        {
            Label: 'Difference Weight',
            Value: DifferenceWeight
        },
        {
            Label: 'Packing Material',
            Value: PackingMaterial
        },
        {
            Label: 'Weight of Packing Material',
            Value: WeightPackingMaterial
        },
        {
            Label: 'Bag Weight (Party)',
            Value: BagWeightParty
        },
        {
            Label: 'Bag Weight (LX)',
            Value: BagWeightLX
        },
        {
            Label: 'Type of Scrap',
            Value: TypeOfScrap
        },
        {
            Label: 'Unloading By',
            Value: UnloadingBy
        },
        {
            Label: 'Challan No',
            Value: ChallanNo
        },
        {
            Label: 'Source No',
            Value: SourceNo
        },
        {
            Label: 'Source Type',
            Value: SourceType
        }
    ],
    UI.FieldGroup #GateEntryDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: SerialNo
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: LocationCode
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: StationFrom
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: Description
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: ItemDescription
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: DocumentDate
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: Time
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: PostingDate
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: LRNo
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: LRNoDate
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: VehicleNo
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: Transporter
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: TransporterName
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: Note
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: StoreLevel
            },
            // {
            //     $Type: 'UI.DataField',
            //     ![@HTML5.CssDefaults]: {width:'7rem'},
            //     Value: AverageWeight
            // },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: ContainerWeight
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: AcceptedWeight
            },
            // {
            //     $Type: 'UI.DataField',
            //     ![@HTML5.CssDefaults]: {width:'7rem'},
            //     Value: GrossWeightSupplier
            // },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: NetWeightSupplier
            },
            // {
            //     $Type: 'UI.DataField',
            //     Value: DifferenceWeight
            // },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: PackingMaterial
            },
            // {
            //     $Type: 'UI.DataField',
            //     Value: WeightPackingMaterial
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Value: BagWeightParty
            // },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: BagWeightLX
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: TypeOfScrap
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: UnloadingBy
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: ChallanNo
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: SourceNo
            },
            {
                $Type: 'UI.DataField',
                ![@HTML5.CssDefaults]: {width:'5rem'},
                Value: SourceType
            }
        ]
    },

    UI.Facets: [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GateEntryFacet',
        Label : 'Gate Entry Details',
        Target: '@UI.FieldGroup#GateEntryDetails'
    }]
);
