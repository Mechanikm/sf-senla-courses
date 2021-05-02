public class WeatherForecastService {
    public virtual class BaseException extends Exception {}
    public class WeatherForecastException extends BaseException {} 
    
    public static Map<Date, Decimal> getForecasts(Decimal latitude, Decimal longitude) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily?lat=' + latitude + '&lon=' + longitude);
        request.setMethod(Constants.HTTP_METHOD_GET);
        request.setHeader('x-rapidapi-key', '18e9db9b18mshf61c99e00cfe313p1c9516jsn4164a4b7e2d7');
        HttpResponse response = http.send(request);
        Map<Date, Decimal> dateAndTempMap = new Map<Date, Decimal>();
        
        try {
            if (response.getStatusCode() == Constants.HTTP_STATUS_CODE_200) {
                Map<String, Object> answerFromSite = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> multidata = (List<Object>) answerFromSite.get('data');
                
                for (Integer i = 0; i < multidata.size(); i++) {
                    Map<String, Object> junctionMap = (Map<String, Object>) multidata[i];
                    Date forecastDate = Date.valueOf(String.ValueOf(junctionMap.get(Constants.NAME_DATETIME)));
                    Decimal forecastTemp = averageTemperature(Decimal.valueOf(String.valueOf(junctionMap.get(Constants.NAME_MIN_TEMP))),
                                                              Decimal.valueOf(String.valueOf(junctionMap.get(Constants.NAME_MAX_TEMP))));
                    dateAndTempMap.put(forecastDate, forecastTemp); 
                }
            }
        } catch (WeatherForecastException ex) {
            System.debug(Constants.FINALLY_EXCEPTIONS_HAPPENED + ex.getMessage());
        } return dateAndTempMap;
    }
    
    private static Decimal averageTemperature (Decimal min, Decimal max) {
        if (min == null || max == null) {return Constants.ABSOLUTE_ZERO_CELCIUS;}
        return (min + max) / Constants.NUMBER_TWO;
    }
}