public inherited sharing class TouristManager {
    
    public static List<Tourist__c> filterName (String nameForSearch) {//Tourists with curtain name
        String extNameForSearch = '%' + nameForSearch + '%';
        List <Tourist__c> filterName = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Name 
            LIKE :extNameForSearch];
        return filterName;
    }
    
    public static List<Tourist__c> filterAge (Integer ageForSearch) {//Tourists with curtain age
        List <Tourist__c> filterAge = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Age__c = :ageForSearch];
        return filterAge;
    }
    
    public static List<Tourist__c> filterFlightYear (Integer yearForSearch) {//Tourists flighted in curtain year
        List<JunctionTouristFlight__c> filterFlightYear = [
            SELECT Tourist__r.Name, Tourist__r.Age__c 
            FROM JunctionTouristFlight__c 
            WHERE CALENDAR_YEAR(Flight__r.Flight_Date__c) = :yearForSearch];
        List<Tourist__c> filtered = new List<Tourist__c>();
        
        for (Integer i = 0; i < filterFlightYear.size(); i++) {
            filtered[i] = (filterFlightYear.get(i).Tourist__r);
        }
        return filtered;
    }
    
    public static List<Tourist__c> filterExistingFlight () {//Tourists with flight
        List<JunctionTouristFlight__c> filterExistingFlight = [
            SELECT Tourist__r.Name, Tourist__r.Age__c, 
            Flight__r.Name, Flight__r.Flight_Date__c
            FROM JunctionTouristFlight__c 
            WHERE Flight__r.Name != null];
        List<Tourist__c> filtered = new List<Tourist__c>();
        
        for (Integer i = 0; i < filterExistingFlight.size(); i++) {
            filtered[i] = (filterExistingFlight.get(i).Tourist__r);
        }
        return filtered;
    }
    
    public static List<Tourist__c> filterWithoutFlight() {//Tourists without flight
        List<JunctionTouristFlight__c> filterWithoutFlight = [
            SELECT Tourist__r.Name, Tourist__r.Age__c
            FROM JunctionTouristFlight__c 
            WHERE Flight__r.Name = ''];
        List<Tourist__c> filtered = new List<Tourist__c>();
        
        for (Integer i = 0; i < filterWithoutFlight.size(); i++) {
            filtered[i] = (filterWithoutFlight.get(i).Tourist__r);
        }
        return filtered;
    }
}