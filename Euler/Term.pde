//Stores a list of factors, * and /, which make up a single term of a function.
public class Term extends Calculable
{
  private ArrayList<Calculable> factors;
  
  public Term(ArrayList<Calculable> factors)
  {
    this.factors = factors;
  }
  
  public float calculate(float x, float current)
  {
    float total = 1;
    
    for(int i = 0; i < factors.size(); i++)
    {
      total *= factors.get(i).calculate(x, current);
    }
    
    if(getNext() == null)
    {
      return total;
    }
    
    return getNext().calculate(x, total);
  }
}
