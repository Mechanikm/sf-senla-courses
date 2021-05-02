public class WeatherForecastUpdaterService {
    
    public static List<Weather_Daily_Forecast__c> listOfWeather (Id sPointId, Map <Date, Decimal> weatherDataSet) {
        List<Weather_Daily_Forecast__c> sPointsWithWeather = new List<Weather_Daily_Forecast__c>();
        Set<Date> datesFromForecast = weatherDataSet.keyset();
        
        for (Date dateKey :datesFromForecast) {
            Weather_Daily_Forecast__c newWeather = new Weather_Daily_Forecast__c (Name = Constants.NAME_DAILY_FORECAST, Space_Point__c = sPointId, Date__c = dateKey, Average_Temperature__c = weatherDataSet.get(dateKey));
            sPointsWithWeather.add(newWeather);
        }
        return sPointsWithWeather;
    }
}