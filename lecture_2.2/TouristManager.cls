public inherited sharing class TouristManager {
    
    public static List<Tourist__c> getFilterByName (String nameForSearch) {
        if (String.isBlank(nameForSearch)) {
            return new List<Tourist__c>();
        }
        String extNameForSearch = '%' + nameForSearch + '%';
        List <Tourist__c> filterName = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Name 
            LIKE :extNameForSearch
        ];
        return filterName;
    }
    
    public static List<Tourist__c> getFilterByAge (Integer ageForSearch) {
        if (ageForSearch == null || ageForSearch <= 0) {
            return new List<Tourist__c>();
        }
        List <Tourist__c> filterAge = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Age__c = :ageForSearch
        ];
        return filterAge;
    }
    
    public static List<Tourist__c> getFilterByFlightYear (Integer yearForSearch) {
        if (yearForSearch == null || yearForSearch <= 0) {
            return new List<Tourist__c>();
        }
        List<JunctionTouristFlight__c> filterFlightYear = [
            SELECT 	Tourist__r.Name, 
            Tourist__r.Age__c 
            FROM JunctionTouristFlight__c 
            WHERE CALENDAR_YEAR(Flight__r.Flight_Date__c) = :yearForSearch
        ];
        List<Tourist__c> filtered = new List<Tourist__c>();
        
        for (Integer i = 0; i < filterFlightYear.size(); i++) {
            filtered[i] = (filterFlightYear.get(i).Tourist__r);
        }
        return filtered;
    }
    
    public static List<Tourist__c> getFilterByExistingFlight () {
        List<JunctionTouristFlight__c> filterExistingFlight = [
            SELECT Tourist__r.Name, 
            Tourist__r.Age__c, 
            Flight__r.Name, 
            Flight__r.Flight_Date__c
            FROM JunctionTouristFlight__c 
            WHERE Flight__r.Name != null
        ];
        List<Tourist__c> filtered = new List<Tourist__c>();
        
        for (Integer i = 0; i < filterExistingFlight.size(); i++) {
            filtered[i] = (filterExistingFlight.get(i).Tourist__r);
        }
        return filtered;
    }
    
    public static List<Tourist__c> getFilterByWithoutFlight() {
        List<JunctionTouristFlight__c> filterWithoutFlight = [
            SELECT Tourist__r.Name, 
            Tourist__r.Age__c
            FROM JunctionTouristFlight__c 
            WHERE Flight__r.Name = ''
        ];
        List<Tourist__c> filtered = new List<Tourist__c>();
        
        for (Integer i = 0; i < filterWithoutFlight.size(); i++) {
            filtered[i] = (filterWithoutFlight.get(i).Tourist__r);
        }
        return filtered;
    }
    
    public static List<Tourist__c> getFilterByNameEmail (List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> filterEmailName = new List<Tourist__c>();
        List<Tourist__c> filtered = new List<Tourist__c>();        
        Set<String> emails = new Set<String>();
        Set<String> names = new Set<String>();
        
        for (Tourist__c tourist :newTourists) {
            emails.add(Tourist.Tourists_email__c);
            names.add(Tourist.Name);
        }    
        
        filterEmailName = [
            SELECT 	Name, 
            Tourists_email__c, 
            IsDuplicate__c
            FROM 	Tourist__c
            WHERE (Tourist__c.Tourists_email__c IN :emails
                   AND Tourist__c.Name IN :names)
        ];
        
        for (Tourist__c tourist :filterEmailName) {
            for (Tourist__c touristInc :newTourists) {
                If (tourist.Tourists_email__c == touristInc.Tourists_email__c
                    && tourist.Name == touristInc.Name) {
                        filtered.add(touristInc);
                    }
            }
        }
        return filtered;
    }
}