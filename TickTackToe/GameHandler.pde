public class GameHandler {
  private int sizeField;
  private int counter = 0;
  private int[][] field = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
  private EventHandler event;
  private boolean gameOver = false;
  
  public GameHandler(int sizeField) {
    this.sizeField = sizeField;
    this.event = new EventHandler(this.sizeField);
  }
  
  public void update() {
    if (!gameOver) {
      int[] step = this.event.checkEvents();
      if (step[0] != -1) {
        if (this.field[step[0]][step[1]] == 0) {
          if (counter%2 == 0) {
            this.drawCircle(step);
            this.field[step[0]][step[1]] = 1;
            counter += 1;
          } else {
            this.drawCross(step);
            this.field[step[0]][step[1]] = 4;
            counter += 1;
          }
          System.out.println(checkWinner());
          switch (checkWinner()) {
            case 0:
              System.out.println("Circle Winns!");
              this.field = new int[][]{{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
              stroke(0);
              rect(0, 0, this.sizeField, this.sizeField);
              textSize(104);
              textAlign(CENTER);
              fill(255);
              text("Circle winns!", (float)(this.sizeField/2), (float)(this.sizeField/2));
              this.gameOver = true;
              break;
            case 1:
              System.out.println("Cross Winns!");
              this.field = new int[][]{{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
              stroke(0);
              rect(0, 0, this.sizeField, this.sizeField);
              textSize(104);
              textAlign(CENTER);
              fill(255);
              text("Cross winns!", (float)(this.sizeField/2), (float)(this.sizeField/2));
              this.gameOver = true;
              break;
          }
        }
      }
    }
  }
  
  private void drawCircle(int[] pos) {
    fill(0);
    circle(this.sizeField/6 + this.sizeField/3 * pos[0], this.sizeField/6 + this.sizeField/3 * pos[1], this.sizeField/4);
  }
  
  private void drawCross(int[] pos) {
    line(this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/12 + pos[1]*this.sizeField/3, this.sizeField/12 + pos[0]*this.sizeField/3, this.sizeField/24 + pos[1]*this.sizeField/3);
    line(this.sizeField/12 + pos[0]*this.sizeField/3, this.sizeField/24 + pos[1]*this.sizeField/3, this.sizeField/6 + pos[0]*this.sizeField/3, this.sizeField/8 + pos[1]*this.sizeField/3);
    line(this.sizeField/6 + pos[0]*this.sizeField/3, this.sizeField/8 + pos[1]*this.sizeField/3, this.sizeField/4 + pos[0]*this.sizeField/3, this.sizeField/24 + pos[1]*this.sizeField/3);
    line(this.sizeField/4 + pos[0]*this.sizeField/3, this.sizeField/24 + pos[1]*this.sizeField/3, 7*this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/12 + pos[1]*this.sizeField/3);
    line(7*this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/12 + pos[1]*this.sizeField/3, 5*this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/6 + pos[1]*this.sizeField/3);
    line(5*this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/6 + pos[1]*this.sizeField/3, 7*this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/4 + pos[1]*this.sizeField/3);
    line(7*this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/4 + pos[1]*this.sizeField/3, this.sizeField/4 + pos[0]*this.sizeField/3, 7*this.sizeField/24 + pos[1]*this.sizeField/3);
    line(this.sizeField/4 + pos[0]*this.sizeField/3, 7*this.sizeField/24 + pos[1]*this.sizeField/3, this.sizeField/6 + pos[0]*this.sizeField/3, 5*this.sizeField/24 + pos[1]*this.sizeField/3);
    line(this.sizeField/6 + pos[0]*this.sizeField/3, 5*this.sizeField/24 + pos[1]*this.sizeField/3, this.sizeField/12 + pos[0]*this.sizeField/3, 7*this.sizeField/24 + pos[1]*this.sizeField/3);
    line(this.sizeField/12 + pos[0]*this.sizeField/3, 7*this.sizeField/24 + pos[1]*this.sizeField/3, this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/4 + pos[1]*this.sizeField/3);
    line(this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/4 + pos[1]*this.sizeField/3, this.sizeField/8 + pos[0]*this.sizeField/3, this.sizeField/6 + pos[1]*this.sizeField/3);
    line(this.sizeField/8 + pos[0]*this.sizeField/3, this.sizeField/6 + pos[1]*this.sizeField/3, this.sizeField/24 + pos[0]*this.sizeField/3, this.sizeField/12 + pos[1]*this.sizeField/3);
    /*for(int i = 0; i < 4; i++) {
      triangle(25, 50, 37.5, 37.5, 
    }  */
  }
  
  private int checkWinner() {
    for (int i = 0; i < 3; i++) {
      switch (sumOfArray(this.field[i])) {
        case 12:
          return 1;
        case 3:
          return 0;
      }
      switch (sumOfArray(new int[] {this.field[0][i], this.field[1][i], this.field[2][i]})) {
        case 12:
          return 1;
        case 3:
          return 0;
       }
    }
    for (int i = 0; i < 2; i++) {
      switch (sumOfArray(new int[] {this.field[0][2*i], this.field[1][1], this.field[2][-2*i+2]})) {
        case 12:
          return 1;
        case 3:
          return 0;
      }
    }
    return -1;
  }
 
  private int sumOfArray(int[] test) {int sum = 0; for(int i: test) {sum += i;} return sum;}
}
