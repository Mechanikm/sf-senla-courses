public inherited sharing class ExceptionsPlayground {
    
    public virtual class BaseException extends Exception {}
    public class CustomException extends BaseException {}
    
    public static void generateCustomException() {
        try {
            throw new CustomException(Constants.FIRST_CUSTOM_EXCEPTION);
        } catch (BaseException e) {
            System.debug(e.getMessage());
        }
    } 
    
    public static void generateRegularException() {
        try {
            Integer i = 1/0;
        } catch (Exception e) {
            System.debug(e.getMessage());
        } 
    }
    
    public static void handleExceptions() {
        try {
            throw new CustomException(Constants.FIRST_CUSTOM_EXCEPTION);
        } catch (BaseException e) {
            System.debug(e.getMessage());
        }
        try {
            Integer i = 1/0;
        } catch (Exception e) {
            System.debug(e.getMessage());
        } 
    }
    
    public static void stopExceptions() {
        try {
            Integer i = 1/0;
        } catch (Exception e) {

        } finally {
            System.debug(Constants.FINALLY_OK_CUSTOM_EXCEPTION);
        } 
    }
}