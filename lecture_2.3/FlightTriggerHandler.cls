public inherited sharing class FlightTriggerHandler {
    
    public static void checkFlightAge(Map<Id, Flight__c> newFlights) {
                
        List<Flight__c> listFlights = new List<Flight__c>();
        
        listFlights = [
            SELECT Id,
            Tourist__r.Id,
            Trip__r.Id
            FROM Flight__c
            WHERE Id in :newFlights.keyset()
        ];
        
        
 /*       for (Flight__c flight :newFlights) {
            if (flight.Trip__r.StartDate__c < Date.Today()) {
                flight.Trip__c.addError(Constants.FLIGHT_DEPART);
            }
            if (((flight.Trip__r.StartDate__c.daysBetween(flight.Tourist__r.Birthdate__c)) / 365.25) 
                < flight.Trip__r.MinimumAge__c) {
                    flight.Tourist__c.addError(Constants.YOUNG_AGE);
            }
        }*/
    }    
}