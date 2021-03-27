public inherited sharing class TripManager {
    
public static List<Trip__c> getFilterById (Set<Id> idTrips) {
        List<Trip__c> matchTrips = new List<Trip__c>();
        matchTrips = [
            SELECT StartDate__c,
            MinimumAge__c
            FROM Trip__c
            WHERE Id IN :idTrips
        ];
        return matchTrips;
    }
}