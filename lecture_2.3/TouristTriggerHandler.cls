public class TouristTriggerHandler {
    public static Boolean wasExecuted;
    
    public static List<Flight__c> onAfterUpdate (Map<Id, Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
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
                fl.StatusT__c = Constants.FLIGHT_STATUS_DECLINED;
                filtered.add(fl);
            }
        }
        return filtered;
    }

    public static void onBeforeInsert(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) return;
        List<Tourist__c> filtered = new List<Tourist__c>();
      
        filteredByNameEmail = TouristManager.getFilterByNameEmail(newTourists);
        if (filteredByNameEmail == null || filteredByNameEmail.isEmpty()) return;
        
        for (Tourist__c tourist :filteredByNameEmail) {
            
            for (Tourist__c touristInc :newTourists) {
                if (tourist.Tourists_email__c == touristInc.Tourists_email__c && tourist.Name == touristInc.Name) {
                    tourist.IsDuplicate__c = true;
                }
            }
        }
    }
}