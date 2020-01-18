class Function extends Calculable
{
  private ArrayList<Calculable> terms;
  
  public Function(Calculable next, ArrayList<Calculable> terms)
  {
    setNext(next);
    this.terms = terms;
  }
  
  public float calculate(float x, float current)
  {
    float total = 0.0;
    
    for(int i = 0; i < terms.size(); i++)
    {
      total += terms.get(i).calculate(x, current);
    }
    
    if(getNext() == null)
    {
      return total;
    }
    
    return getNext().calculate(x, total);
  }
  
  public ArrayList<Calculable> getTerms() { return terms; }
  public void setTerms(ArrayList<Calculable> terms) { this.terms = terms; }
}
