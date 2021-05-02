public inherited sharing class WeatherForecastUpdaterManager {
    
    public static List<Space_Point__c> getAllSpacePoints() {
        return [
            SELECT Id,
            Name,
            City__c, 
            Latitude__c, 
            Longitude__c 
            FROM Space_Point__c
        ];
    }
    
    public static List<Weather_Daily_Forecast__c> getOldWeatherForecast(Id sPointId, Set<Date> oldWeather){
        return [
            SELECT Id
            FROM Weather_Daily_Forecast__c
            WHERE (Date__c IN :oldWeather OR Date__c = null) AND Space_Point__c = :sPointId
        ];
    }
}