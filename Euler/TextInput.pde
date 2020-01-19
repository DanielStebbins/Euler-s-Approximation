public class TextInput extends DrawnText
{
  private float w;
  private float h;
  
  private boolean flag;
  private color selected;
  private color textSelected;
  private String text;
  
  public TextInput(float x, float y, float w, float h, color c, color selected, float textSize, color textColor, color textSelected, String text)
  {
    super(x, y, c, textSize, textColor);
    
    this.w = w;
    this.h = h;
    
    flag = false;
    this.selected = selected;
    this.textSelected = textSelected;
    this.text = text;
  }
  
  public void update()
  {
    
  }
  
  public void display()
  {
    if(flag)
    {
      fill(selected);
    }
    else
    {
      fill(getC());
    }
    rect(getX(), getY(), w, h);
    
    if(flag)
    {
      fill(textSelected);
    }
    else
    {
      fill(getTextColor());
    }
    
    textSize(getTextSize());
    textAlign(LEFT, CENTER);
    text(text, getX() + 10, getY() + h/2);
  }
  
  public void type()
  {
    if(key == BACKSPACE)
    {
      text = text.substring(0, text.length() - 1);
    }
    else if(key == ENTER)
    {
      flag = false;
    }
    else
    {
      text = text + key;
    }
  }
  
  public boolean clicked()
  {
    if(mouseX > getX() && mouseX < getX() + w && mouseY > getY() && mouseY < getY() + h)
    {
      flag = true;
      return true;
    }
    else
    {
      flag = false;
      return false;
    }
  }
  
  public boolean getFlag() { return flag; }
  public void setFlag(boolean flag) { this.flag = flag; }
  
  public String getText() { return text; }
}
