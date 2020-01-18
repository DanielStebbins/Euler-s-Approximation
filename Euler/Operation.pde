class Operation extends Calculable
{
  private float constant;
  
  public Operation(Calculable next)
  {
    setNext(next);
    constant = 0.0;
  }
  
  public float calculate(float x, float current)
  {
    current = operation(x, current);
    
    if(getNext() == null)
    {
      return current;
    }
    
    return getNext().calculate(x, current);
  }
  
  //To be overridden with mathematical operation when initialized.
  public float operation(float x, float current)
  {
    return constant;
  }
}
