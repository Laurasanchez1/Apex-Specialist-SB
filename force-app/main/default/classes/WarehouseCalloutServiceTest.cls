@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
    @IsTest
    static void testWarehouseCalloutService(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        
        Test.startTest();
        WarehouseCalloutService instance = new WarehouseCalloutService();
        System.enqueueJob(instance);
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Product2]);   
        
    }

}