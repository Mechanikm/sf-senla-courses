@RestResource(urlMapping='/Tourist/*')
global class TouristRestService {
    
    @HttpGet
    global static List<Tourist__c> getTourists() {
        List<Tourist__c> result = new List<Tourist__c>();
        Integer age = Integer.ValueOf(RestContext.request.params.get('age'));
        String fuzzyname = RestContext.request.params.get('fuzzyname');
        result = TouristRestManager.getByAgeAndName(age, fuzzyname);
        return result;
    }
}