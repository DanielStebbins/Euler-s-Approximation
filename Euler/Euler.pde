void setup()
{
  size(1000, 600);
  background(100);
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

void draw()
{
  
}

public Function parseFunction(String input)
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  while(input.contains("("))
  {
    parseFunction(input.substring(input.indexOf("("), input.indexOf(")")));
  }
  
  
}
