public inherited sharing class ExceptionsPlayground {
    
    public virtual class BaseException extends Exception {}
    public class CustomException extends BaseException {}
    
    public static void generateCustomException() {
        throw new CustomException(Constants.FIRST_CUSTOM_EXCEPTION);
    } 
    
    public static void generateRegularException() {
        Integer i = 1/0;
    }
    
    public static void handleExceptions() {
        try {generateCustomException();
             generateRegularException();
            } catch (BaseException e) {
            } catch (Exception e) {
            } finally {
                System.debug(Constants.FINALLY_OK_CUSTOM_EXCEPTION);
            } 
    }
}