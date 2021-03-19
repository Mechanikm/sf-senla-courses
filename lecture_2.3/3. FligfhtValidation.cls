public inherited sharing class FligfhtValidation {
   
    public static void checkFlightAge(List<Flight__c> newFlight) {
        
        for (Flight__c fl :newFlight) {
            if (fl.Trip__r.StartDate__c < Date.Today()) {
                fl.Trip__c.addError('The flight departed');
            }
            if (((fl.Trip__r.StartDate__c.daysBetween(fl.Tourist__r.Birthdate__c)) / 365.25) 
                < fl.Trip__r.MinimumAge__c) {
                fl.Tourist__c.addError('The tourist is so young');
            }
        }
    }    
    
    public static void checkFlight(List<Flight__c> newFlight) {
        
        for (Flight__c fl :newFlight) {
            if (fl.Trip__r.StartDate__c < Date.Today()) {
                fl.Trip__c.addError('The flight departed');
            } 
        }
    }    
    
    public static void checkAge(List<Flight__c> newFlight) {
        for (Flight__c fl :newFlight) {
            if (((fl.Trip__r.StartDate__c.daysBetween(fl.Tourist__r.Birthdate__c)) / 365.25) 
                < fl.Trip__r.MinimumAge__c) {
                fl.Tourist__c.addError('The tourist is so young');
            }
        } 
    }
}