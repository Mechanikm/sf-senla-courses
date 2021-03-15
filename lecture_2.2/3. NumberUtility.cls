public class NumberUtility {
    public static List<Integer> primeNumbers (Integer n) {
        List<integer> pNumbers = new List<Integer>();
        Boolean check;
        Integer x; //for better optimization
        Integer x2 = 1; //for better optimization
        
        for (Integer i = 1; i <= n; i = i + x2) {
            if (i == 3 && N >= 5) {
                x2 = 2;//do not check all even numbers
            }
            x = math.round(math.sqrt(i));
            check = true;
            //Check no more than sqrt(n)
            for (Integer i2 = 2; i2 <= x; i2++) {
                if (math.mod(i, i2) == 0) {
                    check = false;
                    i2 = x;//for fast finish this cycle:)
                }
            }
            if (check) {
                pNumbers.add(i);
            }
        }
        //Answer
        return pNumbers;
    }
    
    public static List<Integer> FibonacciNumbers (Integer n) {
        Integer fib;
        Integer fibprev;
        Integer  temp;
        List <Integer> Fibonacci = new List <Integer>();
        
        fibprev = 0;
        fib = 1;
        while (fib <= n) {
            Fibonacci.add(fib);
            temp = fibprev + fib;
            fibprev = fib;
            fib = temp;
        }
        return(Fibonacci);
    }
    
    public static Boolean isPalindrom (Long n) {
        List <String> norm = new List <String>();
        List <String> back = new List <String>();
        
        //Transform Long to Array
        norm = (String.ValueOf(n).split(''));
        
        //Reverse Array
        for (Integer i = norm.size() - 1; i >= 0; i--) {
            back.add(norm[i]);
        }
        //old Palindromity checking
        return(norm == back);
    }
}