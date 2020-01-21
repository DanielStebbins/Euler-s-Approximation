public class Graph extends DrawnText
{
  private float w;
  private float h;
  
  private float xMin, xMax;
  private float yMin, yMax;
  
  private float xTick, yTick;
  private float sample;
  
  private float xScale;
  private float yScale;
  
  private float xAxis;
  private float yAxis;
  
  Function function;
  private ArrayList<float[]> curve;
  
  Function derivative;
  private ArrayList<float[]> dcurve;
  
  private ArrayList<float[]> tangents;
  
  //For float rounding.
  private float tollerance;
  
  private boolean showFunction;
  private boolean showDerivative;
  
  public Graph(float x, float y, float w, float h, color c, float textSize, color textColor)
  {
    super(x, y, c, textSize, textColor);
    this.w = w;
    this.h = h;
    
    xMin = -10;
    xMax = 10;
    
    yMin = -10;
    yMax = 10;
    
    xTick = 1;
    yTick = 1;
    
    sample = (xMax - xMin) / 50000;
    
    xScale = w / (xMax - xMin);
    yScale = -1 * h / (yMax - yMin);
    
    xAxis = yScale * -yMax;
    yAxis = xScale * -xMin;
    
    function = null;
    derivative = null;
    curve = null;
    
    tollerance = .01;
    
    showFunction = true;
    showDerivative = true;
  }
  
  public void update()
  {
    
  }
  
  //Draws the chart on which the running data is displayed.
  public void display()
  {
    stroke(getC());
    
    //Vertical lines on the chart, each corresponding to a year value displayed on the bottom.
    for(float i = xMin; i < xMax; i += xTick)
    {
      line(shiftX(i), shiftY(0) + 5, shiftX(i), shiftY(0) - 5);
    }
    
    //Horizontal lines on the chart, each corresponding to a time value displayed on the lefthand side.
    for(float i = yMin; i < yMax; i += yTick)
    {
      line(shiftX(0) + 5, shiftY(i), shiftX(0) - 5, shiftY(i));
    }
    
    //Y-Axis Line.
    line(shiftX(0), getY(), shiftX(0), h + getY());
    
    //X-Axis Line.
    line(getX(), shiftY(0), w + getX(), shiftY(0));
    
    //Vertical lines on the two sides of the chart.
    line(getX(), getY(), getX(), h + getY());
    line(w + getX(), getY(), w + getX(), h + getY());
    
    //Horizontal lines at the top and bottom of the chart.
    line(getX(), getY(), w + getX(), getY());
    line(getX(), h + getY(), w + getX(), h + getY());
    
    if(showFunction)
    {
      graph(function, curve, #ffffff);
    }
    
    if(showDerivative)
    {
      graph(derivative, dcurve, #ff0000);
    }
    
    if(tangents != null)
    {
      for(int i = 0; i < tangents.size(); i++)
      {
        stroke(#0000ff);
        strokeWeight(2);
        line(tangents.get(i)[0], tangents.get(i)[1], tangents.get(i)[2], tangents.get(i)[3]);
        strokeWeight(1);
        stroke(element);
      }
    }
  }
  
  public ArrayList<float[]> graph(Function f, ArrayList<float[]> cur, color c)
  {
    stroke(c);
    
    if(f != null && cur == null)
    {
      cur = new ArrayList<float[]>();
      
      float last = f.calculate(xMin, 0);
      float current = 0.0;
      for(float i = xMin + sample; i <= xMax; i += sample)
      {
        current = f.calculate(i, 0);
        
        if(last > yMin && last < yMax && current > yMin && current < yMax)
        {
          line(shiftX((i - sample)), shiftY(last), shiftX(i), shiftY(current));
          
          float[] temp = {shiftX((i - sample)), shiftY(last), shiftX(i), shiftY(current)};
          cur.add(temp);
        }
   
        last = current;
      }
      
      stroke(element);
      return cur;
    }
    else if(cur != null)
    {
      for(int i = 0; i < cur.size(); i++)
      {
        line(cur.get(i)[0], cur.get(i)[1], cur.get(i)[2], cur.get(i)[3]);
      }
    }
    
    stroke(element);
    return null;
  }
  
  public void euler(float start, float end, int steps)
  {
    stroke(#0000ff);
    
    float stepSize = (end - start) / steps;
    println(stepSize);
    
    tangents = new ArrayList<float[]>();
    float last = function.calculate(start, 0);
    float current = 0;
    for(float i = start + stepSize; i <= end + tollerance; i += stepSize)
    {
      println("x: " + i);
      current = last + derivative.calculate(i - stepSize, 0) * stepSize;
      line(shiftX(i - stepSize), shiftY(last), shiftX(i), shiftY(current));
      
      float[] temp = {shiftX(i - stepSize), shiftY(last), shiftX(i), shiftY(current)};
      tangents.add(temp);
      
      last = current;
    }
    
    stroke(element);
  }
  
  public void reset(float xMin, float xMax, float yMin, float yMax)
  {
    this.xMin = xMin;
    this.xMax = xMax;
    this.yMin = yMin;
    this.yMax = yMax;
    
    sample = (xMax - xMin) / 10000;
    
    xScale = w / (xMax - xMin);
    yScale = -1 * h / (yMax - yMin);
    
    xAxis = yScale * -yMax;
    yAxis = xScale * -xMin;
    
    curve = null;
    dcurve = null;

  }
  
  public float shiftX(float x)
  {

    x *= xScale;
  
    
    x += getX();
    x += yAxis; 
    return x;
  }
  
  public float shiftY(float y)
  {
    y *= yScale;

    
    y += getY();
    y += xAxis; 
    return y;
  }
  
  public Function getFunction() { return function; }
  public void setFunction(Function function)
  { 
    this.function = function;
    curve = null;
  }
  
  public Function getDerivative() { return derivative; }
  public void setDerivative(Function derivative)
  { 
    this.derivative = derivative;
    dcurve = null;
  }
  
  public float getXMin() { return xMin; }
  public void setXMin(float xMin) { this.xMin = xMin; } 
  
  public float getXMax() { return xMax; }
  public void setXMax(float xMax) { this.xMax = xMax; } 
  
  public float getYMin() { return yMin; }
  public void setYMin(float yMin) { this.yMin = yMin; } 
  
  public float getYMax() { return yMax; }
  public void setYMax(float yMax) { this.yMax = yMax; } 
  
  public ArrayList<float[]> getTangents() { return tangents; }
  public void setTangents(ArrayList<float[]> tangents) { this.tangents = tangents; }
  
  public boolean getShowFunction() { return showFunction; }
  public void setShowFunction(boolean showFunction) { this.showFunction = showFunction; }
  
  public boolean getShowDerivative() { return showDerivative; }
  public void setShowDerivative(boolean showDerivative) { this.showDerivative = showDerivative; }
}
