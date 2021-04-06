global class SchedulerFlightDeleter implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        FlightDeleterBatch fdb = new FlightDeleterBatch();
        Database.executeBatch(fdb);
        //
    }
}