public inherited sharing class TouristManager {
    public static List<sObject> filterName (String nameForSearch) {//Tourists with curtain name
        String extNameForSearch = '%'+nameForSearch+'%';
        List <sObject> filterName = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Name 
            LIKE :extNameForSearch];
        return filterName;
    }
    //To prewiev method
    //Checking in anonimous console
    // List<sObject> tourlist = new List<sObject>();
    //tourlist = TouristManager.filterName('Vasya');
    //System.debug(tourlist);
    //Answer sysdebug: 00:29:58:021 USER_DEBUG [3]|DEBUG|(Tourist__c:{Name=Vasya Nepupkin, Age__c=10, Id=a005g00002pZoHZAA0}, Tourist__c:{Name=Vasya Pupkin, Age__c=18, Id=a005g00002pZoHUAA0})    
    
    public static List<sObject> filterAge (Integer ageForSearch) {//Tourists with curtain age
        List <sObject> filterAge = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Age__c = :ageForSearch];
        return filterAge;
    }
    
    public static List<sObject> filterFlightYear (Integer yearForSearch) {//Tourists flighted in curtain year
        List<sObject> filterFlightYear = [
            SELECT Tourist__r.Name, Tourist__r.Age__c 
            FROM JunctionTouristFlight__c 
            WHERE CALENDAR_YEAR(Flight__r.Flight_Date__c) = :yearForSearch];
        return filterFlightYear;
    }
    
    public static List<sObject> filterExistingFlight () {//Tourists with flight
        List<sObject> filterExistingFlight = [
            SELECT Tourist__r.Name, Tourist__r.Age__c, 
            	   Flight__r.Name, Flight__r.Flight_Date__c
            FROM JunctionTouristFlight__c 
            WHERE Flight__r.Name <> ''];
        return filterExistingFlight;
    }
    
    public static List<sObject> filterWithoutFlight() {//Tourists without flight
        List<sObject> filterWithoutFlight = [
            SELECT Tourist__r.Name, Tourist__r.Age__c
            FROM JunctionTouristFlight__c 
            WHERE Flight__r.Name = ''];
        return filterWithoutFlight;
    }
}