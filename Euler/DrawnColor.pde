public abstract class DrawnColor extends Drawn
{
    private color c;
    
    public DrawnColor(float x, float y, color c)
    {
      super(x, y);
      this.c = c;
    }
    
    public color getC() { return c; }
    public void setC(color c) { this.c = c; }
}
