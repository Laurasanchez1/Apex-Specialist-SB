public with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    public void execute(QueueableContext context){
        // Setup HTTP request
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(WAREHOUSE_URL);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        
        // Check response and deserialize
        List<Object> results = new List<Object>();
        List<Product2> equipments = new List<Product2>();
        if(res.getStatusCode()==200){
            results = (List<Object>) JSON.deserializeUntyped(res.getBody());
            for(Object obj: results){
                Map<String,Object> equMap = (Map<String,Object>) obj;
                Product2 e1 = new Product2();
                e1.Replacement_Part__c= true;
                e1.Cost__c= (Double) equMap.get('cost');
                e1.Current_Inventory__c= (Integer) equMap.get('quantity');
                e1.Lifespan_Months__c= (Integer) equMap.get('lifespan');
                e1.Maintenance_Cycle__c= (Integer) equMap.get('maintenanceperiod');
                e1.Warehouse_SKU__c= (String) equMap.get('sku');
                e1.ProductCode= (String) equMap.get('_id');
                e1.Name = (String) equMap.get('name');
                equipments.add(e1);
            }
            if(equipments.size()>0){
                upsert equipments Warehouse_SKU__c;
            }
        }
        
    }


    
}