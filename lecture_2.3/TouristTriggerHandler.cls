public class TouristTriggerHandler {
    public static Boolean wasExecuted;
    
    public static void onAfterUpdate (Map<Id, Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
            return;
        }
        List<Tourist__c> touristsWithFlights = TouristManager.getInactiveTouristsWithFlights(newTourists);
        if (touristsWithFlights.isEmpty()) {
            return;
        }
        List<Flight__c> filtered = new List<Flight__c>();
        
        for (Tourist__c tourist :touristsWithFlights) {
            
            for (Flight__c flight :tourist.Flights__r) {
                flight.StatusT__c = Constants.FLIGHT_STATUS_DECLINED;
                filtered.add(flight);
            }
        }
        update filtered;
    }
    
    public static void onBeforeInsert(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) return;
        List<Tourist__c> filteredByNameEmail = new List<Tourist__c>();
        
        filteredByNameEmail = TouristManager.getFilterByNameEmail(newTourists);
        if (filteredByNameEmail.isEmpty()) return;
        
        for (Tourist__c tourist :filteredByNameEmail) {
            
            for (Tourist__c touristInc :newTourists) {
                if (tourist.Tourists_email__c == touristInc.Tourists_email__c && tourist.Name == touristInc.Name) {
                    tourist.IsDuplicate__c = true;
                }
            }
        }
    }
}