public inherited sharing class TouristManager {
    public static List<sObject> FilterAnyName (String nameForSearch) {
        List <sObject> FilterAnyName = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Name 
            LIKE :nameForSearch];
        return FilterAnyName;
    }
/*
- выбрать туристов (имя, возраст) чье имя содержит Джон
- выбрать туристов (имя, возраст) с возрастом 20, 22, 24 года
- выбрать туристов (имя, возраст), у которых рейс стартовал в 2020 году.
- выбрать туристов (имя, возраст) со списком рейсов (дата старта, название)
- выбрать туристов (имя, возраст) которые не зарегистрировались ни на один рейс
*/
}