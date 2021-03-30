public inherited sharing class FlightTriggerHandler {
    
    public static void onBeforeInsert(List<Flight__c> newFlights) {
        Set<Id> touristIds = new Set<Id>();
        Set<Id> tripIds = new Set<Id>();
        
        for (Flight__c flight :newFlights) {
            touristIds.add(flight.tourist__c);
            tripIds.add(flight.trip__c);
        }
        List<Tourist__c> listTourists = TouristManager.getFilterById(touristIds);
        Map<Id, Tourist__c> touristMap = new Map<Id, Tourist__c>(listTourists);
        List<Trip__c> listTrips = TripManager.getFilterById(tripIds);
        Map<Id, Trip__c> tripMap = new Map<Id, Trip__c>(listTrips);
        List<Flight__c> forUpdate = new List<Flight__c>();
        
        for (Flight__c flight :newFlights) {
            Tourist__c tourist = touristMap.get(flight.Tourist__c);
            Trip__c trip = tripMap.get(flight.Tourist__c);
            if (trip.StartDate__c < Date.Today()) {
                flight.trip__c.addError(Constants.FLIGHT_DEPART);
                if (((trip.StartDate__c.daysBetween(tourist.Birthdate__c)) / 365.25) 
                    < trip.MinimumAge__c) {
                        flight.Tourist__c.addError(Constants.YOUNG_AGE);
                    }
                forUpdate.add(flight);
            }
        }
        update forUpdate;        
    }    
}