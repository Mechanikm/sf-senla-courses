public inherited sharing class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) return;
        List<Tourist__c> filtered = new List<Tourist__c>();
      
        List<Tourist__c> filteredByNameEmail = new List<Tourist__c>();
        filteredByNameEmail = TouristManager.getFilterByNameEmail(newTourists);
        
        if (newTourists != null) {
            for (Tourist__c tourist :newTourists) {
                tourist.IsDuplicate__c = true;
                filtered.add(tourist);
            }
        }
        update filtered;
    }
}