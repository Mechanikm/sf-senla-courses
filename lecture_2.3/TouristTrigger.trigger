trigger TouristTrigger on Tourist__c (before insert, after update) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            TouristService.onBeforeInsert(trigger.new);
        }    

        when AFTER_UPDATE {
            if (!TouristTriggerHandler.wasExecuted) {
                TouristTriggerHandler.wasExecuted = true;
            TouristTriggerHandler.onAfterUpdate(trigger.newMap);
            }
        } 
    }
}