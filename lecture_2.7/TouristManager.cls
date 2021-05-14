public inherited sharing class TouristManager {
    
    public static List<Tourist__c> getFilterById (Set<Id> idTourists) {
        if (idTourists == null || idTourists.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> matchTourists = new List<Tourist__c>();
        matchTourists = [
            SELECT Id,
            Name,
            Birthdate__c,
            Tourists_email__c
            FROM Tourist__c
            WHERE Id IN :idTourists
        ];
        return matchTourists;
    } 
    
       public static List<Tourist__c> getInactiveTouristsWithFlights (Map<Id, Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> touristsWithFlights = [
            SELECT Active__c,
            (SELECT Id FROM Flights__r)
            FROM Tourist__c
            WHERE Tourist__c.Active__c = false AND Id IN :newTourists.keyset()
        ];
        return touristsWithFlights;
    }
    
    public static List<Tourist__c> getFilterByNameEmail (List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> filtered = new List<Tourist__c>();        
        Set<String> emails = new Set<String>();
        Set<String> names = new Set<String>();
        
        for (Tourist__c tourist :newTourists) {
            emails.add(Tourist.Tourists_email__c);
            names.add(Tourist.Name);
        }    
        filtered = [
            SELECT Name, 
            Tourists_email__c, 
            IsDuplicate__c
            FROM Tourist__c
            WHERE (Tourist__c.Tourists_email__c IN :emails
                   AND Tourist__c.Name IN :names)
        ];
        return filtered;
    } 
}