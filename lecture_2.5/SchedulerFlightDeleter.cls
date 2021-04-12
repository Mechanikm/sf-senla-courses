global class SchedulerFlightDeleter implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        FlightDeleterBatch flightDeleterBatch = new FlightDeleterBatch();
        database.executeBatch(flightDeleterBatch);
    }
}