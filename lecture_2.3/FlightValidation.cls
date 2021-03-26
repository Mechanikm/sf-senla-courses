public inherited sharing class FlightValidation {
    
    public static void checkFlightAge(List<Flight__c> newFlights) {
        
        for (Flight__c flight :newFlights) {
            if (flight.Trip__r.StartDate__c < Date.Today()) {
                flight.Trip__c.addError(Constants.FLIGHT_DEPART);
            }
            if (((flight.Trip__r.StartDate__c.daysBetween(flight.Tourist__r.Birthdate__c)) / 365.25) 
                < flight.Trip__r.MinimumAge__c) {
                    flight.Tourist__c.addError(Constants.YOUNG_AGE);
            }
        }
    }    
}