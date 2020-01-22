/*
Daniel Stebbins, Period 5, 1/20/20
This is my own work, D.S.
This project is a graphing calculator which parses basic functions and graphically displays Euler's Method approximations of those functions.
*/

//Text font sizes.
int label = 14;
int title = 20;

//Color constants.
color background = #202020;
color element = #8f8f8f;
color text = #cccccc;

AllDrawn drawn = new AllDrawn();

void setup()
{
  size(1000, 600);
  background(background);
  
  //surface.setResizable(true);
  
  Graph graph = new Graph(400, 50, 500, 500, element, label, text);
  
  //Graph input.
  TextInput xMin = new TextInput(50, 50, 100, 25, element, #ffffff, label, text, #000000, "-10");
  TextInput xMax = new TextInput(50, 90, 100, 25, element, #ffffff, label, text, #000000, "10");
  TextInput yMin = new TextInput(50, 130, 100, 25, element, #ffffff, label, text, #000000, "-10");
  TextInput yMax = new TextInput(50, 170, 100, 25, element, #ffffff, label, text, #000000, "10");
  Button submit = new Button(50, 210, 100, 50, element, 10, "Submit", label, text, new Executable(){ public void execute() { submit(); }});
  
  //Euler's input.
  TextInput start = new TextInput(125, 350, 100, 25, element, #ffffff, label, text, #000000, "0");
  TextInput end = new TextInput(125, 390, 100, 25, element, #ffffff, label, text, #000000, "10");
  TextInput steps = new TextInput(125, 430, 100, 25, element, #ffffff, label, text, #000000, "1");
  Button euler = new Button(125, 470, 100, 50, element, 10, "Approximate", label, text, new Executable(){ public void execute() { euler(); }});
  
  
  /*
  EXAMPLE FUNCTIONS
  Button Line = new Button(250, 100, 100, 50, element, 10, "Line", label, text, new Executable(){ public void execute() { functionLine(); }});
  Button parabola = new Button(250, 200, 100, 50, element, 10, "Parabola", label, text, new Executable(){ public void execute() { functionParabola(); }});
  Button cubic = new Button(250, 300, 100, 50, element, 10, "Cubic", label, text, new Executable(){ public void execute() { functionCubic(); }});
  Button root = new Button(250, 400, 100, 50, element, 10, "Root", label, text, new Executable(){ public void execute() { functionRoot(); }});
  */
  
  //Function input.
  TextInput function = new TextInput(200, 50, 100, 25, element, #ffffff, label, text, #000000, "x^2");
  Button functionToggle = new Button(200, 80, 100, 25, element, 0, "Toggle", label, text, new Executable(){ public void execute() { toggleFunction(); }});
  TextInput derivative = new TextInput(200, 140, 100, 25, element, #ffffff, label, text, #000000, "2*x");
  Button derivativeToggle = new Button(200, 170, 100, 25, element, 0, "Toggle", label, text, new Executable(){ public void execute() { toggleDerivative(); }});
  Button submitFunction = new Button(200, 210, 100, 50, element, 10, "Graph!", label, text, new Executable(){ public void execute() { submitFunctions(); }});

  
  //Adding objects to screen.
  drawn.addDrawn(graph);
  
  drawn.addDrawn(xMin);
  drawn.addDrawn(xMax);
  drawn.addDrawn(yMin);
  drawn.addDrawn(yMax);
  drawn.addDrawn(submit);
  
  drawn.addDrawn(start);
  drawn.addDrawn(end);
  drawn.addDrawn(steps);
  drawn.addDrawn(euler);
  
  drawn.addDrawn(function);
  drawn.addDrawn(functionToggle);
  drawn.addDrawn(derivative);
  drawn.addDrawn(derivativeToggle);
  drawn.addDrawn(submitFunction);
  
  /*
  drawn.addDrawn(Line);
  drawn.addDrawn(parabola);
  drawn.addDrawn(cubic);
  drawn.addDrawn(root);
  */
  
  submitFunctions();
}

void draw()
{
  background(background);
  drawn.display();
  
  //Titles.
  textSize(title);
  text("Window:", 100, 25);
  text("Euler's Method:", 175, 325);
  text("Function:", 250, 25);
  text("Derivative:", 250, 125);
}

//When mouse is pressed, check for text boxes and buttons.
void mousePressed()
{
  for(Drawn d: drawn.getAllDrawn())
  {  
    if(d instanceof Button)
    {
      ((Button) d).clicked();

    }
    if(d instanceof TextInput)
    {
      ((TextInput) d).clicked();
    }
  }
}

//If key is pressed and a text box is hightlighted, type the key to the text box.
void keyPressed()
{
  for(Drawn d: drawn.getAllDrawn())
  { 
    if(d instanceof TextInput)
    {
      if(((TextInput) d).getFlag())
      {
        ((TextInput) d).type();
        break;
      }
    }
  }
}

//Set the current window inputs to the graph's window inputs.
public void submit()
{
  float[] temp = new float[4];
  for(int i = 1; i < 5; i++)
  {
    temp[i - 1] = Float.parseFloat(((TextInput) drawn.getDrawn(i)).getText());
  }
  
  ((Graph) drawn.getDrawn(0)).reset(temp[0], temp[1], temp[2], temp[3]);
  
  if(((Graph) drawn.getDrawn(0)).getTangents() != null)
  {
    euler();
  }
}

//Run an Euler's approximation with the data in the text boxes.
public void euler()
{
  float[] temp = new float[3];
  for(int i = 6; i < 9; i++)
  {
    temp[i - 6] = Float.parseFloat(((TextInput) drawn.getDrawn(i)).getText());
  }
  
  ((Graph) drawn.getDrawn(0)).euler(temp[0], temp[1], (int) temp[2]);
}

//Turns off the graph of the function.
public void toggleFunction()
{
  ((Graph) drawn.getDrawn(0)).setShowFunction(!((Graph) drawn.getDrawn(0)).getShowFunction());
}

//Turns off the graph of the derivative.
public void toggleDerivative()
{
  ((Graph) drawn.getDrawn(0)).setShowDerivative(!((Graph) drawn.getDrawn(0)).getShowDerivative());
}

//Applies the current functions in the text boxes to the graph.
public void submitFunctions()
{
  Function function = parseFunction(((TextInput) drawn.getDrawn(10)).getText());
  ((Graph) drawn.getDrawn(0)).setFunction(function);
  
  Function derivative = parseFunction(((TextInput) drawn.getDrawn(12)).getText());
  ((Graph) drawn.getDrawn(0)).setDerivative(derivative);
}




//Massive chain of function parsing logic starts here, basically breaks function by "+/-" then by "*//" then by "^" and recursivly puts the small parts together using the classes Function, Term, Factor, and Operation.
public Function parseFunction(String input)
{
  input = input.replaceAll("\\s", "");
  
  ArrayList<Calculable> terms = parseTerms(splitTerms(input));
  
  return new Function(null, terms);
}


public ArrayList<String> splitTerms(String input)
{
  ArrayList<String> terms = new ArrayList<String>();
  int paren = 0;
  int last = 0;
  String prefix = "";
  
  for(int i = 0; i < input.length(); i++)
  {    
    if(input.charAt(i) == '(')
    {
      paren++;
    }
    else if(input.charAt(i) == ')')
    {
      paren--;
    }
    else if(paren == 0)
    {
      if(input.charAt(i) == '+')
      {
        terms.add(prefix + input.substring(last, i));
        prefix = "";
        last = i + 1;
      }
      else if(input.charAt(i) == '-')
      {
        terms.add(prefix + input.substring(last, i));
        prefix = "-1*";
        last = i + 1;
      }
     }
   }
  
  if(last < input.length())
  {
    terms.add(prefix + input.substring(last, input.length()));
  }
  
  return terms;
}


public ArrayList<Calculable> parseTerms(ArrayList<String> stringTerms)
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  for(int i = 0; i < stringTerms.size(); i++)
  {
    if(stringTerms.get(i).charAt(0) == '(' && stringTerms.get(i).charAt(stringTerms.get(i).length() - 1) == ')' && splitFactors(stringTerms.get(i)).size() == 1)
    {
      terms.add(parseFunction(stringTerms.get(i).substring(1, stringTerms.get(i).length() - 1)));
    }
    else
    {
      terms.add(new Term(parseFactors(splitFactors(stringTerms.get(i)))));
    }
  }
  
  return terms;
}


public ArrayList<String> splitFactors(String stringTerm)
{
  ArrayList<String> factors = new ArrayList<String>();
  int paren = 0;
  int last = 0;
  String suffix = "";
  
  for(int i = 0; i < stringTerm.length(); i++)
  {    
    if(stringTerm.charAt(i) == '(')
    {
      paren++;
    }
    else if(stringTerm.charAt(i) == ')')
    {
      paren--;
    }
    else if(paren == 0)
    {
      if(stringTerm.charAt(i) == '*')
      {
        factors.add(stringTerm.substring(last, i) + suffix);
        suffix = "";
        last = i + 1;
      }
      else if(stringTerm.charAt(i) == '/')
      {
        factors.add(stringTerm.substring(last, i) + suffix);
        suffix = "^-1";
        last = i + 1;
      }
     }
   }
  if(last < stringTerm.length())
  {
    factors.add(stringTerm.substring(last, stringTerm.length()) + suffix);
  }
  
  return factors;
}

public ArrayList<Calculable> parseFactors(ArrayList<String> stringFactors)
{
  ArrayList<Calculable> factors = new ArrayList<Calculable>();
  
  for(int i = 0; i < stringFactors.size(); i++)
  {
    if(stringFactors.get(i).charAt(0) == '(' && stringFactors.get(i).charAt(stringFactors.get(i).length() - 1) == ')' && splitExponents(stringFactors.get(i)).size() == 1)
    {
      factors.add(parseFunction(stringFactors.get(i).substring(1, stringFactors.get(i).length() - 1)));
    }
    else
    {
      factors.add(new Factor(parseExponents(splitExponents(stringFactors.get(i)))));
    }
  }
  
  return factors;
}


public ArrayList<String> splitExponents(String stringFactor)
{
  ArrayList<String> exponentials = new ArrayList<String>();
  int paren = 0;
  int last = 0;
  
  for(int i = 0; i < stringFactor.length(); i++)
  {    
    if(stringFactor.charAt(i) == '(')
    {
      paren++;
    }
    else if(stringFactor.charAt(i) == ')')
    {
      paren--;
    }
    else if(paren == 0 && stringFactor.charAt(i) == '^')
    {
      exponentials.add(stringFactor.substring(last, i));
      last = i + 1;
    }
  }
  if(last < stringFactor.length())
  {
    exponentials.add(stringFactor.substring(last, stringFactor.length()));
  }
  
  return exponentials;
}

public ArrayList<Calculable> parseExponents(ArrayList<String> stringExponents)
{
  ArrayList<Calculable> exponents = new ArrayList<Calculable>();
  
  for(int i = stringExponents.size() - 1; i >= 0; i--)
  {
    if(stringExponents.get(i).charAt(0) == '(' && stringExponents.get(i).charAt(stringExponents.get(i).length() - 1) == ')')
    {
      exponents.add(parseFunction(stringExponents.get(i).substring(1, stringExponents.get(i).length() - 1)));
    }
    else
    {
      if(stringExponents.get(i).equals("x"))
      {
        exponents.add(new Operation(null)
        {
          public float calculate(float x, float current)
          {
            return x;
          }
        });
      }
      else
      {
        final float temp = Float.parseFloat(stringExponents.get(i));
        exponents.add(new Operation(null)
        {
          public float calculate(float x, float current)
          {
            return temp;
          }
        });
      }
    }
  }
  
  return exponents;
}
//Function parsing ends here.


//EXAMPLE FUNCTIONS, NOT NEEDED IN CURRENT BUILD.
/*
//x
public void functionLine()
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return x;
    }
  }
  );
  
  Function f = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setFunction(f);

  terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return 1;
    }
  }
  );
  
  Function d = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setDerivative(d);
  ((Graph) drawn.getDrawn(0)).setTangents(null);
}

//x^2
public void functionParabola()
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return pow(x, 2);
    }
  }
  );
  
  Function f = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setFunction(f);
  
  
  
  terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return 2 * x;
    }
  }
  );
  
  Function d = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setDerivative(d);
  ((Graph) drawn.getDrawn(0)).setTangents(null);
}

//x^3
public void functionCubic()
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return pow(x, 3);
    }
  }
  );
  
  Function f = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setFunction(f);
  
  
  
  terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return 3 * pow(x, 2);
    }
  }
  );
  
  Function d = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setDerivative(d);
  ((Graph) drawn.getDrawn(0)).setTangents(null);
}

//x^(1/2)
public void functionRoot()
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return pow(x, .5);
    }
  }
  );
  
  Function f = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setFunction(f);
  
  
  
  
  
  terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return 1 / (2 * pow(x, .5));
    }
  }
  );
  
  Function d = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setDerivative(d);
  ((Graph) drawn.getDrawn(0)).setTangents(null);
}
*/
