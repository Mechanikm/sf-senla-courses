public inherited sharing class FlightDeleterBatch implements Database.Batchable<SObject>, Database.Stateful {
    private final String query = ('SELECT Id, StatusT__c, CreatedDate  FROM FLIGHT__C WHERE StatusT__C = ' + 
        Constants.FLIGHT_STATUS_DECLINED + ' OR CreatedDate != LAST_N_DAYS:30');
    private Map <Id, Integer> countTourists = new Map<Id,Integer>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Flight__c> forDelFlights) {
        Set<Id> touristIds = new Set<Id>();
        Set<Id> idFlightsToDelete = new Set<Id>();
        
        for (Flight__c flight :forDelFlights) {
            touristIds.add(flight.tourist__c);
            idFlightsToDelete.add(flight.Id);
        }
        List<Tourist__c> touristsForCount = TouristManager.getFilterById(touristIds);
        
        for (Tourist__c tourist :touristsForCount) {
            Integer count = 0;
            
            for (Flight__c flight :forDelFlights) {
                if (tourist.Id == flight.Tourist__r.Id) {
                    count++;
                }
            }
            Integer previous = countTourists.get(tourist.Id);
            If (previous == null) {
                previous = 0;
            }
            countTourists.put(tourist.Id, count + previous);
        }
        delete forDelFlights;
    }
    
    public void finish(Database.BatchableContext bc) {
        
        List<Admin_Setting__mdt> listEmail = [
            SELECT EmailForMessages__c 
            fROM Admin_Setting__mdt
        ];
        String emailAdress = listEmail[0].EmailForMessages__c;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {emailAdress};
            mail.setToAddresses(toAddresses);
        mail.setSubject(Constants.FLIGHT_REPORT);
        mail.setPlainTextBody(Constants.EMAIL_MESSAGE_DEL_FLIGHTS + countTourists);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}