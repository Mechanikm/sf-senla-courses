@RestResource(urlMapping='/Tourist/*')
global class TouristRestService {
    @HttpGet
    global static List<Tourist__c> getTourists() {
        List<Tourist__c> result = new List<Tourist__c>();
        RestRequest request = RestContext.request;
        String caseForName = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        String partialName = '%' + caseForName + '%';
        result =  [
            SELECT Id, Name, Birthdate__c
            FROM Tourist__c
            WHERE Name LIKE :partialName
        ];
        return result;
    }
}