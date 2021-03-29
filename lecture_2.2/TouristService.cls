public inherited sharing class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
       
        List<Tourist__c> filtered = new List<Tourist__c>();
        if (newTourists != null || newTourists.isEmpty() == false) {
        
            List<Tourist__c> filteredByNameEmail = new List<Tourist__c>();
            filteredbyNameEmail = TouristManager.getfilterbyNameEmail(newTourists);
        
            if (newTourists != null) {
                for (Tourist__c tourist :newTourists) {
                    tourist.IsDuplicate__c = true;
                    filtered.add(tourist);
                }
            }
        }
        update filtered;
    }
}