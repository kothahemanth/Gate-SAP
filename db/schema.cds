namespace com.satinfotech.sat;

using { managed, cuid } from '@sap/cds/common';

entity GateEntry : cuid, managed {
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
    TransporterName : String(100);                    
    @title: 'Note'
    Note : String(500);                               
    @title: 'Store Level'
    StoreLevel : String(50);                         
    @title: 'Average Weight'
    AverageWeight : Decimal(10, 2);                  
    @title: 'Container Weight'
    ContainerWeight : Decimal(10, 2);                 
    @title: 'Accepted Weight'
    AcceptedWeight : Decimal(10, 2);                  
    @title: 'Gross Weight (Supplier)'
    GrossWeightSupplier : Decimal(10, 2);             
    @title: 'Net Weight (Supplier)'
    NetWeightSupplier : Decimal(10, 2);              
    @title: 'Difference Weight'
    DifferenceWeight : Decimal(10, 2);               
    @title: 'Packing Material'
    PackingMaterial : String(100);                    
    @title: 'Weight of Packing Material'
    WeightPackingMaterial : Decimal(10, 2);           
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
}
