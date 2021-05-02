public inherited sharing class WeatherForecastUpdater {
    public virtual class BaseException extends Exception {}
    public class WeatherForecastException extends BaseException {} 
    
    public static void updateForecasts() {
        List<Space_Point__c> allSpacePoints = WeatherForecastUpdaterManager.getAllSpacePoints();
        List <Weather_Daily_Forecast__c> actualSpacePointsWeather = new List<Weather_Daily_Forecast__c>();
        List <Weather_Daily_Forecast__c> oldSpacePointsWeather = new List<Weather_Daily_Forecast__c>();
        List <Weather_Daily_Forecast__c> junctionSpacePointsWeather = new List<Weather_Daily_Forecast__c>();
        List <Weather_Daily_Forecast__c> junctionOldSpacePointsWeather = new List<Weather_Daily_Forecast__c>();
        Map<Date, Decimal> dataDateAndTemp = new Map<Date, Decimal>();
        
        for (Space_Point__c sPoint :allSpacePoints) {
            try {
                dataDateAndTemp = weatherForecastService.getForecasts(sPoint.Latitude__c, sPoint.Longitude__c);
                junctionSpacePointsWeather = WeatherForecastUpdaterService.listOfWeather(sPoint.Id, dataDateAndTemp);
                junctionOldSpacePointsWeather = WeatherForecastUpdaterManager.getOldWeatherForecast(sPoint.Id, dataDateAndTemp.keyset());
            } catch (WeatherForecastException ex) {
                System.debug(Constants.FINALLY_EXCEPTIONS_HAPPENED + ex.getMessage());
            }
            if (!(junctionSpacePointsWeather.isEmpty()) && junctionSpacePointsWeather != null) {
                actualSpacePointsWeather.addAll(junctionSpacePointsWeather);
            }
            if (!(junctionOldSpacePointsWeather.isEmpty()) && junctionOldSpacePointsWeather != null) {
                oldSpacePointsWeather.addAll(junctionOldSpacePointsWeather);
            }        
        }
        
        if (!(oldSpacePointsWeather.isEmpty()) && oldSpacePointsWeather != null) {
            delete oldSpacePointsWeather;
        }
        if (!(actualSpacePointsWeather.isEmpty()) && actualSpacePointsWeather != null) {
            insert actualSpacePointsWeather;
        }   
    }
}