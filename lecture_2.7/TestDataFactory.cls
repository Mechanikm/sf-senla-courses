@IsTest
public class TestDataFactory {
    
    public static void createFlightsWithTourists() {
        List<Tourist__c> tourists = new List<Tourist__c>();
        List<Flight__c> flights = new List<Flight__c>();
        Boolean isActive;
            for (Integer i = 1; i <= 20; i++) {
                
                tourists.add(new Tourist__c(
                    Name = ('Tourist #' + i), 
                    Birthdate__c = System.today().addYears(-30), 
                    Tourists_email__c = (i + '-email@mail.com'),
                    Active__c = true)
                            );
            }
        insert tourists;
        
        Trip__c oneTrip = new Trip__c(Name = 'Test Trip', MinimumAge__c = 18, StartDate__c = System.today().addYears(1));
        insert oneTrip;
        
        for (Integer i = 1; i <= 10; i++) {
            Flight__c flight = new Flight__c();
            flight.Trip__c = oneTrip.Id;
            for (Integer j = 0; j < i; j++) {
                flight.Tourist__c = tourists[j].Id;
            }
            flights.add(flight);
        }
        insert flights;
    }
}