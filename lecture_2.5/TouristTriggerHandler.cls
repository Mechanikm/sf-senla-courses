public class TouristTriggerHandler {
    public static Boolean wasExecuted;
    @future
    public static void markDuplicates(Set<Id> newTouristsIds) {
        if (newTouristsIds == null || newTouristsIds.isEmpty()) return;
        List<Tourist__c> filteredByIds = new List<Tourist__c>();
        
        filteredByIds = TouristManager.getFilterById(newTouristsIds);
        if (filteredByIds.isEmpty()) return;
        
        Set<Id> duplicateNewTouristsIds = new Set<Id>();
        
        for (Tourist__c tourist :filteredByIds) {
            if (newTouristsIds.contains(tourist.Id)) {
                duplicateNewTouristsIds.add(tourist.Id);
            }
        }
        
        List <Tourist__c> forMarkIsDuplicate = TouristManager.getFilterById(duplicateNewTouristsIds);
        if (duplicateNewTouristsIds.isEmpty()) return;
        
        for (Tourist__c tourist :forMarkIsDuplicate) {
            tourist.IsDuplicate__c = true;
        }
        update forMarkIsDuplicate;
    }
}