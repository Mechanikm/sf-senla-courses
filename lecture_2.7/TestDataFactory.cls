@IsTest
public class TestDataFactory {
    
    public static List<Tourist__c> createTourists(Integer numTourists) {
        List<Tourist__c> tourists = new List<Tourist__c>();
        
        for (Integer i = 1; i <= numTourists; i++) {
            tourists.add(new Tourist__c(
                Name = ('Tourist #' + i), 
                Birthdate__c = System.today().addYears(-30), 
                Tourists_email__c = (i + '-email@mail.com'),
                Active__c = true)
                        );
        }
        insert tourists;
        return tourists;
    }
    
    public static List<Trip__c> createTrips(Integer numTrips, List<Integer> deviationTripDates) {
        if (numTrips > deviationTripDates.size()) {numTrips = deviationTripDates.size();}
        List<Trip__c> trips = new List<Trip__c>();
        
        for (Integer i = 1; i <= numTrips; i++) {
            trips.add(new Trip__c(Name = ('Test Trip ' + i), MinimumAge__c = (17 + i), StartDate__c = System.today().addDays(deviationTripDates[i-1])));
        }
        insert trips;
        return trips;
    }
    
    public static List<Flight__c> createFlights(Integer numFlights, List<Tourist__c> tourists, List<Trip__c> trips) {
        if (numFlights > tourists.size()) {
            numFlights = tourists.size();
        }
        if (numFlights > trips.size()) {
            numFlights = trips.size();
        }
        List<Flight__c> flights = new List<Flight__c>();
        
        for (Integer i = 1; i <= numFlights; i++) {
            Flight__c flight = new Flight__c();
            flight.Trip__c = trips[i-1].Id;
            
            for (Integer j = 0; j < i; j++) {
                flight.Tourist__c = tourists[j].Id;
            }
            flights.add(flight);
        }
        return flights;
    }
}