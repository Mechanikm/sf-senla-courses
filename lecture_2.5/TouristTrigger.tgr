Trigger TouristTrigger on Tourist__c (after insert) {
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            if (!TouristTriggerHandler.wasExecuted) {
                TouristTriggerHandler.wasExecuted = true;
                TouristTriggerHandler.markDuplicates(Trigger.newMap.keyset());
            }
        } 
    }
}