public inherited sharing class FlightDeleterBatch implements Database.Batchable<SObject>, Database.Stateful {
    private final String query = 'SELECT Id, StatusT__c, CreatedDate  FROM FLIGHT__C WHERE StatusT__C = ' + 
        Constants.FLIGHT_STATUS_DECLINED + ' OR CreatedDate != LAST_N_DAYS:30';
    private Map<Id, Integer> countTourists = new Map<Id, Integer>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Flight__c> flights) {
        Set<Id> touristIds = new Set<Id>();
        Set<Id> idFlightsToDelete = new Set<Id>();
        List<Id> listIdFlightsToDelete = new List<Id>();
        
        for (Flight__c flight :flights) {
            touristIds.add(flight.tourist__r.Id);
            idFlightsToDelete.add(flight.Id);
            
        }
        List<Tourist__c> touristsForCount = TouristManager.getFilterById(touristIds);
        
        for (Flight__c flight :flights) {
            Map<Id, Integer> countTouristsJunc = new Map<Id, Integer>();
            
            for (Tourist__c tourist :touristsForCount) {
                if (tourist.Id == flight.Tourist__r.Id) {
                    Integer previous = countTouristsJunc.get(tourist.Id);
                    If (previous == null) {
                        previous = 0;         
                    }
                    countTouristsJunc.put(tourist.Id, previous++);
                }
            }
            List<Flight__c> forDeleteResult = new List<Flight__c>();
            forDeleteResult.add(flight);
            Database.DeleteResult[] resultDeletionList = Database.delete(forDeleteResult, false);
            
            If (resultDeletionList[0].isSuccess()) {
                Set<Id> valuesForAdding = countTouristsJunc.keySet();
                for (Id ids :valuesForAdding) {
                    Integer previous = countTourists.get(ids);
                    If (previous == null) {
                        previous = 0;
                    }
                    countTourists.put(ids, previous + countTouristsJunc.get(ids));
                }
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        String emailForReport = [
        SELECT EmailForMessages__c 
        FROM Admin_Setting__mdt
        ][0].EmailForMessages__c;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {emailForReport};
        mail.setToAddresses(toAddresses);
        mail.setSubject(Constants.FLIGHT_REPORT);
        mail.setPlainTextBody(Constants.EMAIL_MESSAGE_DEL_FLIGHTS + countTourists);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}