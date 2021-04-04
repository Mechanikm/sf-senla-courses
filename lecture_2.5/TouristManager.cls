public inherited sharing class TouristManager {
    
    public static List<Tourist__c> getFilterById (Set<Id> idTourists) {
        if (idTourists == null || idTourists.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> matchTourists = new List<Tourist__c>();
        matchTourists = [
            SELECT Id,
            Birthdate__c
            FROM Tourist__c
            WHERE Id IN :idTourists
        ];
        return matchTourists;
    } 
}