public class NumberUtility3 {
    public static List<Integer> primeNumbers (Integer n) {
        List<integer> pNumbers = new List<Integer>();
        //old Integer i, i2;
        Boolean check;
        Double x; //for better method optimization
        
        //Check all even numbers (2 - will adding later)
        for (Integer i = 1; i <= n; i = i + 2) {
            x = math.sqrt(i); //old my mistake in past. There must be i, not n!
            check = true;
            //Check for sqrt(n) only
            for (Integer i2 = 2; i2 < x; i2++) {
                if (math.mod(i, i2) == 0) {
                    check = false;
                    break;
                }
            }
    if (check) {
        pNumbers.add(i);
        if (i == 1 && n >= 2) { //Add 2 if needed
            pNumbers.add(2);
        }
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