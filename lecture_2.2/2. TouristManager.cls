public inherited sharing class TouristManager {
    public static List<sObject> FilterAnyName (String nameForSearch) {
        String extNameForSearch = '%'+nameForSearch+'%';
        List <sObject> FilterAnyName = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Name 
            LIKE :extNameForSearch];
        return FilterAnyName;
    }
    //Checking in anonimous console
    // List<sObject> tourlist = new List<sObject>();
    //tourlist = TouristManager.FilterAnyName('Vasya');
    //System.debug(tourlist);
//Answer sysdebug: 00:29:58:021 USER_DEBUG [3]|DEBUG|(Tourist__c:{Name=Vasya Nepupkin, Age__c=10, Id=a005g00002pZoHZAA0}, Tourist__c:{Name=Vasya Pupkin, Age__c=18, Id=a005g00002pZoHUAA0})    
    
    /*
- выбрать туристов (имя, возраст) чье имя содержит Джон
- выбрать туристов (имя, возраст) с возрастом 20, 22, 24 года
- выбрать туристов (имя, возраст), у которых рейс стартовал в 2020 году.
- выбрать туристов (имя, возраст) со списком рейсов (дата старта, название)
- выбрать туристов (имя, возраст) которые не зарегистрировались ни на один рейс
*/
}