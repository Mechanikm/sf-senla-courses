public inherited sharing class FlightDeleterBatch implements Database.Batchable<SObject>, Database.Stateful, Database.RaisesPlatformEvents {
    private final String query = 'SELECT Id, StatusT__c, CreatedDate  FROM FLIGHT__C WHERE StatusT__C = ' + 
        Constants.FLIGHT_STATUS_DECLINED + ' OR CreatedDate < LAST_N_DAYS:30';
    private Map<Id, Integer> countTourists = new Map<Id, Integer>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Flight__c> flights) {
        //Объявляем классы
        Set<Id> touristIds = new Set<Id>();
        Set<Id> idFlightsToDelete = new Set<Id>();
        List<Id> listIdFlightsToDelete = new List<Id>();

        //Достаю из отфильтрованных полетов Id туристов и самих полетов
        for (Flight__c flight :flights) {
            touristIds.add(flight.tourist__r.Id);
            idFlightsToDelete.add(flight.Id);
        }
        //Из Id туристов делаю самих туристов (ТуристМенеджер любит этим заниматься :)        
        List<Tourist__c> touristsForCount = TouristManager.getFilterById(touristIds);
        
        //Сейчас пойдет страшноватая логика. 
        //Изменил прежнюю ради того, чтоб использовать Database.DeleteResult.
        //Смысл в том, чтоб создавать временную мапу countTouristsJunc, потом проверять на удаляемость рейсы и если рейсы успешно удалились,
        //то закинуть результаты из временной мапы в отчетную.
        
        //Беру первый рейс
        for (Flight__c flight :flights) {
            //Создаю временную мапу или обнуляю ее после очередной итерации (возможно, нужно специальная команда для обнуления)
            Map<Id, Integer> countTouristsJunc = new Map<Id, Integer>();
                       
            //Беру список туристов, замешанных с удаляемыми рейсами, выбираю относящихся именно к этому рейсу и заношу во временную мапу
            for (Tourist__c tourist :touristsForCount) {
                if (tourist.Id == flight.Tourist__r.Id) {
                    Integer previous = countTouristsJunc.get(tourist.Id);
                    //Как оказалось, сложение плохо работает с null, поэтому, если турист попадает в мапу впервые, то нужно сделать null нулем
                    If (previous == null) {
                        previous = 0;         
                    }
                    countTouristsJunc.put(tourist.Id, previous++); 
                }
            }
            //Тут может быть я неправильно понял работу DeleteResult. 
            //Смысл-то понятен: результат true или false можно использовать в коде. Например, для корректировки программы после неуспешного удаления.
            List<Flight__c> forDeleteResult = new List<Flight__c>();
            forDeleteResult.add(flight);
            Database.DeleteResult[] resultDeletionList = Database.delete(forDeleteResult, false);
            //Вот эта проверка. Делается для конкретного рейса, по которому сейчас и выполняется логика. И для которого создана временная мапа.
            //Если его просто удалить (вместе с пачкой других), то я не понимаю как тогда можно будет достать информацию о туристах на этих рейсах.
            //При подтверждении удаления рейса туристы из временной мапы перемещаются в отчетную.
            If (resultDeletionList[0].isSuccess()) {
                Set<Id> valuesForAdding = countTouristsJunc.keySet();
                
                for (Id ids :valuesForAdding) {
                    Integer previous = countTourists.get(ids);
                    If (previous == null) {
                        previous = 0;
                    }
                    countTourists.put(ids, previous + countTouristsJunc.get(ids));
                }
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        String emailForReport = [
        SELECT EmailForMessages__c 
        FROM Admin_Setting__mdt
        ][0].EmailForMessages__c;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {emailForReport};
        mail.setToAddresses(toAddresses);
        mail.setSubject(Constants.FLIGHT_REPORT);
        mail.setPlainTextBody(Constants.EMAIL_MESSAGE_DEL_FLIGHTS + countTourists);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}