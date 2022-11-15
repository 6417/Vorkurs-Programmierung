public class EventHandler {
  int sizeField;
  
  public EventHandler(int sizeField) {
    this.sizeField = sizeField;
  }
  
  public int[] checkEvents() {
    int[] returnList;
    
    if (mousePressed) {
      returnList = new int[]{(int)Math.floor(mouseX/(this.sizeField/3)), (int)Math.floor(mouseY/(this.sizeField/3))};
      return returnList;
    } else {
      returnList = new int[]{-1, -1};
      return returnList;
    }
  }
}
