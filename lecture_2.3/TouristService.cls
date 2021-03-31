public inherited sharing class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
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