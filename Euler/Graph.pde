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
  
  Function function;
  
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
    
    sample = .001;
    
    xScale = w / (xMax - xMin);
    yScale = -1 * h / (yMax - yMin);
    
    function = null;
  }
  
  public void update()
  {
    
  }
  
  //Draws the chart on which the running data is displayed.
  public void display()
  {
    stroke(getC());
    textAlign(CENTER, TOP);
    textSize(getTextSize());
    
    //Vertical lines on the chart, each corresponding to a year value displayed on the bottom.
    float offset = w / (xMax - xMin + 2);
    for(int i = 0; i <= xMax - xMin; i += xTick)
    {
      line(getX() + offset * (i + 1), getY() + h/2 + 5, getX() + offset * (i + 1), getY() + h/2 - 5);
      //text(xMin + i, getX() + offset * (i + 1), h + getY()); 
    }
    
    //Horizontal lines on the chart, each corresponding to a time value displayed on the lefthand side.
    offset = h / (yMax - yMin);
    for(int i = 0; i <= yMax - yMin; i += yTick)
    {
      
      line(getX() + w/2 + 5, getY() + offset * i, getX() + w/2 - 5, getY() + offset * i);
      //textAlign(RIGHT);
      //text(yMin + i, getX() - 10, getY() + offset * i + getTextSize() * .5); 
    }
    
    //Y-Axis Line.
    line(getX() + w/2, getY(), getX() + w/2, h + getY());
    
    //X-Axis Line.
    line(getX(), getY() + h/2, w + getX(), getY() + h/2);
    
    //Vertical lines on the two sides of the chart.
    line(getX(), getY(), getX(), h + getY());
    line(w + getX(), getY(), w + getX(), h + getY());
    
    //Horizontal lines at the top and bottom of the chart.
    line(getX(), getY(), w + getX(), getY());
    line(getX(), h + getY(), w + getX(), h + getY());
    
    if(function != null)
    {
      float last = function.calculate(xMin, 0);
      float current = 0.0;
      for(float i = xMin + sample; i <= xMax; i += sample)
      {
        current = function.calculate(i, 0);
        
        if(current > yMin && current < yMax)
        {
          line(shiftX((i - sample)), shiftY(last), shiftX(i), shiftY(current));
        }
        
        last = current;
      }
    }
  }
  
  public float shiftX(float x)
  {
    x *= xScale;
    x += getX();
    x += w/2; 
    return x;
  }
  
  public float shiftY(float y)
  {
    y *= yScale;
    y += getY();
    y += h/2; 
    return y;
  }
  
  public Function getFunction() { return function; }
  public void setFunction(Function function) { this.function = function; }
}
