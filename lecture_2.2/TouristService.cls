public inherited sharing class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
        List<Tourist__c> filtered = new List<Tourist__c>();
        filtered = TouristManager.getfilterbyNameMail(newTourists);
        update filtered;
    }
}