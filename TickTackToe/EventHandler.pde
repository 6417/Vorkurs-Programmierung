public class EventHandler {
  int sizeField;
  float[] sizesOfReplay;
  
  public EventHandler(int sizeField, float[] sizesOfReplay) {
    this.sizeField = sizeField;
    this.sizesOfReplay = sizesOfReplay;
  }
  
  public int[] checkGameEvents() {
    int[] returnList;
    
    if (mousePressed) {
      returnList = new int[]{(int)Math.floor(mouseX/(this.sizeField/3)), (int)Math.floor(mouseY/(this.sizeField/3))};
      return returnList;
    } else {
      returnList = new int[]{-1, -1};
      return returnList;
    }
  }
  
  public boolean checkFinishEvents() {
    if (mousePressed) {
      if (mouseX > this.sizesOfReplay[0] && mouseX < this.sizesOfReplay[0] + this.sizesOfReplay[2] && mouseY > this.sizesOfReplay[1] && mouseY < this.sizesOfReplay[1] + this.sizesOfReplay[3]) {
        return true;
      }
    }
    return false;
  }
}
