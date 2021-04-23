@RestResource(urlMapping='/Tourist/*')
global class TouristRestService {
    
    @HttpGet
    global static List<Tourist__c> getTourists() {
        List<Tourist__c> result = new List<Tourist__c>();
        Map<String,String> data = RestContext.request.params;
        Integer age = Integer.valueOf(data.get('age'));
        String name = '%' + data.get('fuzzyname') + '%';
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