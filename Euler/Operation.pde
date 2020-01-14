class Operation extends Calculable
{
  public Operation(Calculable next)
  {
    setNext(next);
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
    return 0.0;
  }
}
