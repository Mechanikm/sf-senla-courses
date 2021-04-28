public class TouristRestManager {
    
    public static List<Tourist__c> getByAgeAndName(Integer age, String fuzzyname) {
        List<Tourist__c> result = new List<Tourist__c>();
        String name = '%' + fuzzyname + '%';     
        result  = [
            SELECT Id,
            Name,
            BirthDate__c
            FROM Tourist__c
            WHERE Age__c = :age AND Name LIKE :name
        ];
        return result;
    }
}