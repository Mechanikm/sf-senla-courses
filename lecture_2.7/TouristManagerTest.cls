@IsTest
class TouristManagerTest {
    
    @TestSetup
    static void setupTouristsBase() {
        List<Tourist__c> tourists = new List<Tourist__c>();
        for (Integer i = 1; i <= 10; i++) {
            Tourist__c anotherMember = new Tourist__c (
                Name = ('Jack ' + i ), 
                Birthdate__c = Date.Today().addYears(-20),
                Tourists_email__c = (i + '-email@mail.com'),
                Active__c = false
            );
            tourists.add(anotherMember);
        } 
        insert tourists;
    }    
    
    @IsTest
    static void getFilterById_EmptyInput() {
        List<Tourist__c> isEmptyList = TouristManager.getFilterById(null);
        
        System.assertEquals(0, isEmptyList.size());
    }
    
    @IsTest
    static void getFilterById_Test() {
        Set<Id> ids = new Set<Id>();
        List<Tourist__c> tourists = new List<Tourist__c>();
        for (Tourist__c tourist :tourists = [
           									 SELECT Id
            								 FROM Tourist__c
            								 LIMIT 4
        ]) {
            ids.add(tourist.Id);
        }
        
        System.assertEquals(4, TouristManager.getFilterById(iDs).size());
    }
    
    @IsTest
    static void getInactiveTouristsWithFlights_TestEmptyInput() {
        List<Tourist__c> isEmptyList = TouristManager.getInactiveTouristsWithFlights(null);
        
        System.assertEquals(0, isEmptyList.size());
    }
    
    @IsTest
    static void getInactiveTouristsWithFlights_Test() {
        TestDataFactory.createFlightsWithTourists();
        Map<Id, Tourist__c> idsTourists = new Map<Id, Tourist__c>([SELECT Id FROM Tourist__c]);
        List<Tourist__c> tourists = TouristManager.getInactiveTouristsWithFlights(idsTourists);
        
        System.assertEquals(10, tourists.size());
    }
    
    @IsTest
    static void getFilterByNameEmail_TestEmptyInput() {
        List<Tourist__c> isEmptyList = TouristManager.getFilterByNameEmail(null);
        
        System.assertEquals(0, isEmptyList.size());
    }
    
    @IsTest
    static void getFilterByNameEmail_Test() {
        List<Tourist__c> tourists = new List<Tourist__c>();
        
        for (Integer i = 1; i <= 5; i++) {
            Tourist__c anotherMember = new Tourist__c (
                Name = ('Jack ' + i*2 ), 
                Birthdate__c = Date.Today().addYears(-20),
                Tourists_email__c = (i*2 + '-email@mail.com'),
                Active__c = false
            );
            tourists.add(anotherMember);
        }
        
        System.assertEquals(5, TouristManager.getFilterByNameEmail(tourists).size());
    }
}