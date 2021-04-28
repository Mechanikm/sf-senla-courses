@RestResource(urlMapping='/Tourist/*')
global class TouristRestService {
    
    @HttpGet
    global static List<Tourist__c> getTourists() {
        List<Tourist__c> result = new List<Tourist__c>();
        Map<String, String> data = RestContext.request.params;
        Integer age = Integer.valueOf(data.get('age'));
        String fuzzyname = data.get('fuzzyname');
        result = TouristRestManager.getByAgeAndName(age, fuzzyname);
        return result;
    }
}