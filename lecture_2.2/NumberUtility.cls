public class NumberUtility {
    
    public static List<Integer> getPrimeNumbers (Integer num) {
        List<Integer> pNumbers = new List<Integer>();
        Boolean check;
        Integer x;
        Integer x2 = 1;
        
        for (Integer i = 1; i <= num; i = i + x2) {
            if (i == 3 && num >= 5) {
                x2 = 2;
            }
            x = math.round(math.sqrt(i));
            check = true;
            
            for (Integer i2 = 2; i2 <= x; i2++) {
                if (math.mod(i, i2) == 0) {
                    check = false;
                    i2 = x;
                }
            }
            if (check) {
                pNumbers.add(i);
            }
        }
        return pNumbers;
    }
    
    public static List<Integer> getFibonacciNumbers (Integer num) {
        Integer fib;
        Integer fibprev;
        Integer temp;
        List <Integer> Fibonacci = new List <Integer>();
        
        fibprev = 0;
        fib = 1;
        while (fib <= num) {
            Fibonacci.add(fib);
            temp = fibprev + fib;
            fibprev = fib;
            fib = temp;
        }
        return(Fibonacci);
    }
    
    public static Boolean isPalindrom (Long num) {
        List <String> forward = new List <String>();
        List <String> backward = new List <String>();
        
        forward = (String.ValueOf(num).split(''));
        
        for (Integer i = forward.size() - 1; i >= 0; i--) {
            backward.add(forward[i]);
        }
        return(forward == backward);
    }
}