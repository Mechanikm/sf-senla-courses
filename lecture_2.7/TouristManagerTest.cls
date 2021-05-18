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
        List<Tourist__c> tourists = new List<Tourist__c>();
        List<Trip__c> trips = new List<Trip__c>();
        List<Integer> dateDeviation = new List<Integer>{-120, -60, 0, 0, 0, 1, 30, 60, 90, 120};
        List<Flight__c> flights = new List<Flight__c>();
        
        tourists = TestDataFactory.createTourists(20);
        trips = TestDataFactory.createTrips(10, dateDeviation);
        flights = TestDataFactory.createFlights(10, tourists, trips);
        Database.SaveResult[] testing = Database.insert(flights, false);
               
        Map<Id, Tourist__c> idsTourists = new Map<Id, Tourist__c>([SELECT Id FROM Tourist__c]);
        List<Tourist__c> testTourists = TouristManager.getInactiveTouristsWithFlights(idsTourists);
        
        List<Flight__c> chechFl = new List<Flight__c>();
        chechFl = [
            SELECT Id, Name
            FROM Flight__c
        ];
        System.debug(chechFl.size());
        System.assertEquals(10, testTourists.size());
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