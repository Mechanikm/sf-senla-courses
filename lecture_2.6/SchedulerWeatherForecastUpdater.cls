global class SchedulerWeatherForecastUpdater implements Schedulable{
       
    global void execute(SchedulableContext sc) {
        WeatherForecastUpdater.updateForecasts();
    }
}