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
  Button Line = new Button(100, 100, 100, 50, element, 10, "Line", 12, text, new Executable(){ public void execute() { functionLine(); }});
  Button parabola = new Button(100, 200, 100, 50, element, 10, "Parabola", 12, text, new Executable(){ public void execute() { functionParabola(); }});
  Button cubic = new Button(100, 300, 100, 50, element, 10, "Cubic", 12, text, new Executable(){ public void execute() { functionCubic(); }});
  Button root = new Button(100, 400, 100, 50, element, 10, "Root", 12, text, new Executable(){ public void execute() { functionRoot(); }});
  
  drawn.addDrawn(graph);
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
  }
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
  
  Function test = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setFunction(test);
}

//x^2
public void functionParabola()
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return (float) Math.pow(x, 2);
    }
  }
  );
  
  Function test = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setFunction(test);
}

//x^3
public void functionCubic()
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return (float) Math.pow(x, 3);
    }
  }
  );
  
  Function test = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setFunction(test);
}

//x^(1/2)
public void functionRoot()
{
  ArrayList<Calculable> terms = new ArrayList<Calculable>();
  
  terms.add(new Operation(null)
  {
    public float operation(float x, float current)
    {
      return (float) Math.pow(x, .5);
    }
  }
  );
  
  Function test = new Function(null, terms);
  
  ((Graph) drawn.getDrawn(0)).setFunction(test);
}
