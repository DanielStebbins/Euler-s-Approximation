//Parent class of anything which runs mathematical functions.
abstract class Calculable
{
  private Calculable next;
  
  public abstract float calculate(float x, float current);
  
  public Calculable getNext() { return next; }
  public void setNext(Calculable next) { this.next = next; }
}
