public inherited sharing class TouristManager {
    
    public static List<Tourist__c> getfilterbyName (String nameForSearch) {
        if (nameForSearch == null) {
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
    
    public static List<Tourist__c> getfilterbyAge (Integer ageForSearch) {
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
    
    public static List<Tourist__c> getfilterbyFlightYear (Integer yearForSearch) {
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
    
    public static List<Tourist__c> getfilterbyExistingFlight () {
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
    
    public static List<Tourist__c> getfilterbyWithoutFlight() {
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
    
    public static List<Tourist__c> getfilterbyNameMail (List<Tourist__c> newTourists) {
        if (newTourists == null) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> filterNameMail = new List<Tourist__c>();
        List<Tourist__c> filtered = new List<Tourist__c>();        
        
        for (Tourist__c tr :newTourists) {
            filterNameMail = [
                SELECT 	Name, 
                Tourists_email__c, 
                IsDuplicate__c
                FROM 	Tourist__c
                WHERE (Tourist__c.Tourists_email__c = :tr.Tourists_email__c 
                       AND Tourist__c.Name = :tr.Name)
            ];
        }
        if (filterNameMail != null) {
            for (Tourist__c fnm :filterNameMail) {
                for (Tourist__c nt :newTourists) {
                    if (fnm.Tourists_email__c == nt.Tourists_email__c 
                        && fnm.Name == nt.Name) {
                            nt.IsDuplicate__c = true;
                        }
                    filtered.add(nt);
                }
            }
        }
        return filtered;
    }
}