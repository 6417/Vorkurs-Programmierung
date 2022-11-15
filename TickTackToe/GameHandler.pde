public class GameHandler {
  private int sizeField;
  private int counter = 0;
  private int[][] field = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
  private EventHandler event;
  
  public GameHandler(int sizeField) {
    this.sizeField = sizeField;
    this.event = new EventHandler(this.sizeField);
  }
  
  public void update() {
    int[] step = this.event.checkEvents();
    if (step[0] != -1) {
      if (this.field[step[0]][step[1]] == 0) {
        if (counter%2 == 0) {
          this.drawCircle(step);
        } else {
          this.drawCross(step);
        }
      }
    }
  }
  
  private void drawCircle(int[] pos) {
    fill(0);
    circle(this.sizeField/6 + this.sizeField/3 * pos[0], this.sizeField/6 + this.sizeField/3 * pos[1], this.sizeField/4);
  }
  
  private void drawCross(int[] pos) {
    line(25, 50, 50, 25);
    line(50, 25, 100, 75);
    line(100, 75, 150, 25);
    line(150, 25, 175, 50);
    line(175, 50, 125, 100);
    line(125, 100, 175, 150);
    line(175, 150, 150, 175);
    line(150, 175, 100, 125);
    line(100, 125, 50, 175);
    line(50, 175, 25, 150);
    line(25, 150, 75, 100);
    line(75, 100, 25, 50);
    /*for(int i = 0; i < 4; i++) {
      triangle(25, 50, 37.5, 37.5, 
    }  */
  }
  
  private boolean checkWinner() {return true;}
}
