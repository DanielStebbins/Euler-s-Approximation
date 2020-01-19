public abstract class Drawn
{
  private float x;
  private float y;
  
  public Drawn(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  public abstract void update();
  public abstract void display();
  
  public float getX() { return x; }
  public void setX(float x) { this.x = x; }
  
  public float getY() { return y; }
  public void setY(float y) { this.y = y; }
}
