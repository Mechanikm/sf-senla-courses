public inherited sharing class TouristService {
   
    public static void markDuplicates(List<Tourist__c> newTourists) {
        TouristManager.filterNameMail(newTourists);
    }
}