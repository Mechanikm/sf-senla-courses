public class TouristTriggerHandler {
    public static Boolean wasExecuted;
    
    @future
    public static void markDuplicatesAsync(Set<Id> newTouristsIds) {
        if (newTouristsIds == null || newTouristsIds.isEmpty()) return;
        List <Tourist__c> forMarkIsDuplicate = new List <Tourist__c>();
        List<Tourist__c> filteredByIds = TouristManager.getFilterById(newTouristsIds);
        List<Tourist__c> touristsWithSameNameEmail = TouristManager.getFilterByNameEmail(filteredByIds);
        
        for (Tourist__c tourist :touristsWithSameNameEmail) {
            
            for (Tourist__c touristInc :filteredByIds) {
                if (tourist.Tourists_email__c == touristInc.Tourists_email__c && tourist.Name == touristInc.Name && tourist.Id != touristInc.Id) {
                    tourist.IsDuplicate__c = true;
                    forMarkIsDuplicate.add(tourist);
                }
            }
        } 
        update forMarkIsDuplicate;
    }
}