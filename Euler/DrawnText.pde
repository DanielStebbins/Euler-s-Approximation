public abstract class DrawnText extends DrawnColor
{
  private float textSize;
  private color textColor;
  
  public DrawnText(float x, float y, color c, float textSize, color textColor)
  {
    super(x, y, c);
    
    this.textSize = textSize;
    this.textColor = textColor;
  }
  
  public float getTextSize() { return textSize; }
  public void setTextSize(float textSize) { this.textSize = textSize; }
  
  public color getTextColor() { return textColor; }
  public void setTextColor(color textColor) { this.textColor = textColor; }
}
