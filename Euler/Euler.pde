void setup()
{
  size(1000, 600);
  background(100);
  String test = "3 * x + (2 * x + 5 * ( x - 3 )) * (x + 5)";
  parseFunction(test);
}

void draw()
{
  
}

public void parseFunction(String input)
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  ArrayList<String> subfunctions = new ArrayList<String>();
  
  char counter = 'A';
  while(input.contains("("))
  {
    int begin = input.indexOf("(");
    int end = 0;
    
    int parenCount = 1;
    for(int i = begin + 1; i < input.length(); i++)
    {
      if(input.charAt(i) == '(')
      {
        parenCount++;
      }
      else if(input.charAt(i) == ')')
      {
        parenCount--;
      }
      
      if(parenCount == 0)
      {
        end = i;
        break;
      }
    }
    
    subfunctions. add(input.substring(begin + 1, end));
    input = input.substring(0, begin) + counter + input.substring(end + 1);
    counter++;
  }
  
  println(input);
  
  for(int i = 0; i < subfunctions.size(); i++)
  {
    println(subfunctions.get(i));
  }
}

public void testFunction()
{
    ArrayList<Calculable> terms = new ArrayList<Calculable>();
  terms.add(new Operation(null)
  { 
    public float operation(float x,float current)
    { 
      return x; 
    }
  });
  
  terms.get(0).setNext(new Operation(null)
  { 
    public float operation(float x,float current)
    { 
      return 2 * current; 
    }
  });
  
  terms.add(new Operation(null)
  {
    public float operation(float x,float current)
    { 
      return 3; 
    }
  });
  
  terms.get(1).setNext(new Operation(null)
  { 
    public float operation(float x,float current)
    { 
      return (float) Math.pow(current, x); 
    }
  });
  
  Function test = new Function(null, terms);
  
  
  test.setNext(new Operation(null)
  {
    public float operation(float x,float current)
    { 
      return 2 * current; 
    }
  });
  println(test.calculate(2, 0));
}
