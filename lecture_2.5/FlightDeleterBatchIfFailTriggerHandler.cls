public class FlightDeleterBatchIfFailTriggerHandler {
    
    public static void onAfterInsert(List<BatchApexErrorEvent> apexErrorEvents) {
        Set<Id> asyncApexJobIds = new Set<Id>();
        
        for(BatchApexErrorEvent evt : apexErrorEvents){
            asyncApexJobIds.add(evt.AsyncApexJobId);
        }   
        Map<Id, AsyncApexJob> jobs = new Map<Id, AsyncApexJob> ([
            SELECT id, 
            ApexClass.Name 
            FROM AsyncApexJob 
            WHERE Id IN :asyncApexJobIds
        ]);
        List<Error_Log__c> recordsLog = new List<Error_Log__c>();
        
        for(BatchApexErrorEvent evt : apexErrorEvents){ 
            if(jobs.get(evt.AsyncApexJobId).ApexClass.Name == FlightDeleterBatch.class.getName()){
                
                for (String item : evt.JobScope.split(',')) {
                    Error_Log__c record = new Error_Log__c(
                        Error__c = (Id)item,
                        Records__c = evt.ExceptionType,
                        JobId__c = evt.AsyncApexJobId
                    );
                    recordsLog.add(record);
                }
            }
        }
        insert recordsLog;
    }
}