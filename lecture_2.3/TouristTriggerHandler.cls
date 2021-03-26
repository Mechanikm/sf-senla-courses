public class TouristTriggerHandler {
    public static Boolean wasExecuted;
    
    public static List<Flight__c> getfilterbyActivity (Map<Id, Tourist__c> newTourists) {
        if (newTourists == null) {
            return new List<Flight__c>();
        }
        List<Tourist__c> touristsWithFlights = [
            SELECT Active__c,
            (SELECT Id FROM Flights__r)
            FROM Tourist__c
            WHERE Id IN :newTourists.keyset()
        ];
        
        List<Flight__c> filtered = new List<Flight__c>();
        for (Tourist__c tr :touristsWithFlights) {
            for (Flight__c fl :tr.Flights__r) {
                fl.StatusT__c = 'Declined';
                filtered.add(fl);
            }
        }
        return filtered;
    }
}