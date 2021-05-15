@IsTest
class TouristServiceTest {
    
    @TestSetup
    static void setupTouristsBase() {
        List<Tourist__c> touristsWithEvenIndexes = new List<Tourist__c>();
        for (Integer i = 1; i <= 10; i++) {
            Tourist__c anotherMember = new Tourist__c (
                Name = ('Jack ' + i*2 ), 
                Birthdate__c = Date.Today().addYears(-20),
                Tourists_email__c = (i*2 + '-email@mail.com'),
                isDuplicate__c = false);
            touristsWithEvenIndexes.add(anotherMember);
        } 
        insert touristsWithEvenIndexes;
    }    
    
    @IsTest static void testMarkDuplicates() {
        List<Tourist__c> touristsWithTwoDuplicates = new List<Tourist__c>();
        
        for (Integer i = 1; i <= 5; i++) {
            Tourist__c anotherMember = new Tourist__c (
                Name = ('Jack ' + i),
                Birthdate__c = Date.Today().addYears(-20),
                Tourists_email__c = (i + '-email@mail.com'),
                isDuplicate__c = false);
            touristsWithTwoDuplicates.add(anotherMember);
        }
        Test.startTest();
        TouristService.markDuplicates(touristsWithTwoDuplicates);
        Test.stopTest();
        List<Tourist__c> duplicates = [
            SELECT Id
            FROM Tourist__c
            WHERE Tourist__c.IsDuplicate__c = true
        ];
        
        System.assertEquals(2, duplicates.size());
    }
    
    @IsTest
    static void testMarkDuplicateWithEmptyInput() {
        TouristService.markDuplicates(null);
        List<Tourist__c> duplicates = [
            SELECT Id
            FROM Tourist__c
            WHERE Tourist__c.IsDuplicate__c = true
        ];
        
        System.assertEquals(0, duplicates.size());
    }
    
    @IsTest static void testMarkDuplicateWithEmptyDuplicates() {
        List<Tourist__c> touristsWithoutDuplicates = new List<Tourist__c>();
        
        for (Integer i = 1; i <= 5; i++) {
            Tourist__c anotherMember = new Tourist__c (
                Name = ('Jack ' + (i*2-1)),
                Birthdate__c = Date.Today().addYears(-20),
                Tourists_email__c = ((i*2-1) + '-email@mail.com'),
                isDuplicate__c = false);
            touristsWithoutDuplicates.add(anotherMember);
        }
        Test.startTest();
        TouristService.markDuplicates(touristsWithoutDuplicates);
        Test.stopTest();
        List<Tourist__c> duplicates = [
            SELECT Id
            FROM Tourist__c
            WHERE Tourist__c.IsDuplicate__c = true
        ];
        
        System.assertEquals(0, duplicates.size());
    }
}