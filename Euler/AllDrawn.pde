//Contains all objects to be displayed on screen.
public class AllDrawn
{
  private ArrayList<Drawn> allDrawn;
  
  public AllDrawn()
  {
    allDrawn = new ArrayList<Drawn>();
  }
  
  public void update()
  {
    for(Drawn d : allDrawn)
    {
      d.update();
    }
  }
  
  public void display()
  {
    for(Drawn d : allDrawn)
    {
      d.display();
    }
  }
  
  public void addDrawn(Drawn d)
  {
    allDrawn.add(d);
  }
  
  public Drawn getDrawn(int index)
  {
    return allDrawn.get(index);
  }
  
  public ArrayList<Drawn> getAllDrawn() { return allDrawn; }
  public void setAllDrawn(ArrayList<Drawn> allDrawn) { this.allDrawn = allDrawn; }
}
