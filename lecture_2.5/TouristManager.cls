public inherited sharing class TouristManager {
    
    public static List<Tourist__c> getFilterById (Set<Id> idTourists) {
        if (idTourists == null || idTourists.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> matchTourists = new List<Tourist__c>();
        matchTourists = [
            SELECT Id,
            Name
            FROM Tourist__c
            WHERE Id IN :idTourists
        ];
        return matchTourists;
    } 
    
    public static List<Tourist__c> getTouristsWithFlights (Map<Id, Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> touristsWithFlights = [
            SELECT Active__c,
            (SELECT Id FROM Flights__r)
            FROM Tourist__c
            WHERE Id IN :newTourists.keyset()
        ];
        return touristsWithFlights;
    }
}