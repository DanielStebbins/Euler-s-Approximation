//Contains exponent operations.
public class Factor extends Calculable
{
  private ArrayList<Calculable> exponents;
  
  public Factor(ArrayList<Calculable> exponentials)
  {
    this.exponents = exponentials;
  }
  
  public float calculate(float x, float current)
  {
    float total = exponents.get(0).calculate(x, current);
    
    for(int i = 1; i < exponents.size(); i++)
    {
      total = pow(exponents.get(i).calculate(x, current), total);
    }
    
    return total;
  }
}
