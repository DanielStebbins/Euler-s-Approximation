public class Button extends DrawnText
{
  private float w;
  private float h;
  private float curve;
  
  private String text;
  
  private Executable onClick;
  
  public Button(float x, float y, float w, float h, color c, float curve, String text, float textSize, color textColor, Executable onClick)
  {
    super(x, y, c, textSize, textColor);
    
    this.w = w;
    this.h = h;
    this.curve = curve;
    
    this.text = text;
    
    this.onClick = onClick;
  }
  
  public void update()
  {
    
  }
  
  public void display()
  {
    fill(getC());
    rect(getX(), getY(), w, h, curve);
    
    fill(getTextColor());
    textAlign(CENTER, CENTER);
    textSize(getTextSize());
    text(text, getX() + w/2, getY() + h/2);
  }
  
  public boolean clicked()
  {
    if(mouseX > getX() && mouseX < getX() + w && mouseY > getY() && mouseY < getY() + h)
    {
      onClick.execute();
      return true;
    }
    else
    {
      return false;
    }
  }
  
  public float getWidth() { return w; }
  public void setWidth(float w) { this.w = w; }
  
  public float getHeight() { return h; }
  public void setHeight(float h) { this.h = h; }
  
  public float getCurve() { return curve; }
  public void setCurve(float curve) { this.curve = curve; }
  
  public String getText() { return text; }
  public void setText(String text) { this.text = text; }
    
  public Executable getOnClick() { return onClick; }
  public void setOnClick(Executable onClick) { this.onClick = onClick; }
}
