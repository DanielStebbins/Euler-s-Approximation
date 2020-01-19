//Text font sizes.
int label = 14;
int title = 32;

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
  
  TextInput xMin = new TextInput(50, 50, 100, 25, element, #ffffff, label, text, #000000, "-10");
  TextInput xMax = new TextInput(50, 90, 100, 25, element, #ffffff, label, text, #000000, "10");
  TextInput yMin = new TextInput(50, 130, 100, 25, element, #ffffff, label, text, #000000, "-10");
  TextInput yMax = new TextInput(50, 170, 100, 25, element, #ffffff, label, text, #000000, "10");
  Button submit = new Button(50, 210, 100, 50, element, 10, "Submit", label, text, new Executable(){ public void execute() { submit(); }});
  
  
  TextInput start = new TextInput(50, 300, 100, 25, element, #ffffff, label, text, #000000, "4");
  TextInput end = new TextInput(50, 340, 100, 25, element, #ffffff, label, text, #000000, "1");
  TextInput steps = new TextInput(50, 380, 100, 25, element, #ffffff, label, text, #000000, "0");
  Button euler = new Button(50, 420, 100, 50, element, 10, "Approximate", label, text, new Executable(){ public void execute() { euler(); }});
  
  
  Button Line = new Button(250, 100, 100, 50, element, 10, "Line", label, text, new Executable(){ public void execute() { functionLine(); }});
  Button parabola = new Button(250, 200, 100, 50, element, 10, "Parabola", label, text, new Executable(){ public void execute() { functionParabola(); }});
  Button cubic = new Button(250, 300, 100, 50, element, 10, "Cubic", label, text, new Executable(){ public void execute() { functionCubic(); }});
  Button root = new Button(250, 400, 100, 50, element, 10, "Root", label, text, new Executable(){ public void execute() { functionRoot(); }});
  
  
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
  
  drawn.addDrawn(Line);
  drawn.addDrawn(parabola);
  drawn.addDrawn(cubic);
  drawn.addDrawn(root);
  
  
  
  
  
  //String test = "3 * x + (2 * x + 5 * ( x - 3 )) * (x + 5)";
  //parseFunction(test);
}

void draw()
{
  background(background);
  drawn.display();
}

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

public void submit()
{
  float[] temp = new float[4];
  for(int i = 1; i < 5; i++)
  {
    temp[i - 1] = Float.parseFloat(((TextInput) drawn.getDrawn(i)).getText());
  }
  
  ((Graph) drawn.getDrawn(0)).reset(temp[0], temp[1], temp[2], temp[3]);
}

public void euler()
{
  float[] temp = new float[3];
  for(int i = 6; i < 9; i++)
  {
    temp[i - 6] = Float.parseFloat(((TextInput) drawn.getDrawn(i)).getText());
  }
  
  ((Graph) drawn.getDrawn(0)).euler(temp[0], temp[1], (int) temp[2]);
}

/*
public void parseFunction(String input)
{
  ArrayList<String> subfunctions = new ArrayList<String>();

  input = input.replaceAll("\\s", "");
  Function function = new Function(null, new ArrayList<Calculable>());

  char counter = 'A';
  while (input.contains("("))
  {
    int begin = input.indexOf("(");
    int end = 0;

    int parenCount = 1;
    for (int i = begin + 1; i < input.length(); i++)
    {
      if (input.charAt(i) == '(')
      {
        parenCount++;
      } else if (input.charAt(i) == ')')
      {
        parenCount--;
      }

      if (parenCount == 0)
      {
        end = i;
        break;
      }
    }

    subfunctions.add(input.substring(begin + 1, end));
    input = input.substring(0, begin) + counter + input.substring(end + 1);
    counter++;
  }

  String split[] = input.split("[+-]+");

  println(input);

  for (int i = 0; i < split.length; i++)
  {
    ArrayList<Calculable> operations = new ArrayList<Calculable>();

    while (split[i].contains("^"))
    {
      int index = split[i].indexOf("^");

      operation.add(parseOperation(split[i], index));
    }
  }
}
*/

/*
public Operation parseOperation(String term, int index)
{
  int start = 0;
  int end = term.length() - 1;

  for(int j = index; j >= 0; j--)
  {
    if(term.charAt(index) == '*' || term.charAt(index) == '/');
    {
      start = j;
      break;
    }
  }

  for(int j = index; j < term.length(); j++)
  {
    if(term.charAt(index) == '*' || term.charAt(index) == '/');
    {
      end = j;
      break;
    }
  }

  String first = term.substring(start, index);
  String second = term.substring(index, end);

  if(term.charAt(index))
  {

  }
}
*/



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
}
