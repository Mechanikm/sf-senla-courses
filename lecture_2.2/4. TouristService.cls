public inherited sharing class TouristService {
    public static void markDuplicates(List<Tourist__c> newTourists) {
        List<Tourist__c> allTourists = new List<Tourist__c>(); 
        List<Tourist__c> forUpdate = new List<Tourist__c>();
        allTourists = [SELECT 	Name, 
                       			Tourists_email__c, 
                       			IsDuplicate__c
                       FROM 	Tourist__c];
        
        for (Tourist__c base :allTourists) {
            for (Tourist__c nt :newTourists) {
                if ((base.Name == nt.Name) && (base.Tourists_email__c == nt.Tourists_email__c)) {
                    nt.isDuplicate__c = true;
                    forUpdate.add(nt);
                }
            }
        }
//prepare to update (Duplicates may need to remove?)
//update forUpdate;
    }
}