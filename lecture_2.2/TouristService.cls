public inherited sharing class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
        List<Tourist__c> filteredbyNameEmail = new List<Tourist__c>();
        List<Tourist__c> filtered = new List<Tourist__c>();
        filteredbyNameEmail = TouristManager.getfilterbyNameEmail(newTourists);
        
        if (newTourists != null) {
            for (Tourist__c tourist :newTourists) {
                tourist.IsDuplicate__c = true;
                filtered.add(tourist);
            }
        }
        update filtered;
    }
}