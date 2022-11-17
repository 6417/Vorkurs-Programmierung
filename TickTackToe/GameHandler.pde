public class GameHandler {
  private int sizeField;
  private int counter = 0;
  private int[][] field;
  private EventHandler event;
  private boolean gameOver = false;
  
  private float[] sizesOfReplay;
  private float replaySize;
  
  private boolean waitForPlay = false;
  private int waitCounter = 0;
  
  public GameHandler(int sizeField) {
    this.sizeField = sizeField;
    this.replaySize = 11*this.sizeField/120;
    this.sizesOfReplay = new float[] {this.sizeField/2 - 24*this.replaySize/11, 3*this.sizeField/4 - 8*this.replaySize/11 - this.sizeField/120, 48*this.replaySize/11, this.replaySize + this.sizeField/60};
    this.event = new EventHandler(this.sizeField, this.sizesOfReplay);
  }
  
  public void update() {
    if (waitForPlay) {
      if (waitCounter > 15) {
        waitForPlay = false;
        waitCounter = 0;
      } else {
        waitCounter += 1;
      }
    } else {
      if (!gameOver) {
        int[] step = this.event.checkGameEvents();
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
            switch (checkWinner()) {
              case 0:
                this.finishGame("Circle winns!");
                break;
              case 1:
                this.finishGame("Cross winns!");
                break;
              case 2:
                this.finishGame("Draw!");
                break;
            }
          }
        }
      } else {
        boolean playFurther = this.event.checkFinishEvents();
        if (playFurther) {
          this.initialField();
          this.counter = 0;
          this.gameOver = false;
          this.waitForPlay = true;
        }
      }
    }
  }
  
  private void drawCircle(int[] pos) {
    stroke(255);
    fill(0);
    circle(this.sizeField/6 + this.sizeField/3 * pos[0], this.sizeField/6 + this.sizeField/3 * pos[1], this.sizeField/4);
  }
  
  private void drawCross(int[] pos) {
    stroke(255);
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
    if (this.counter >= 9) {return 2;}
    return -1;
  }
  
  private void finishGame(String message) {
   stroke(0);
   rect(0, 0, this.sizeField, this.sizeField);
   stroke(255);
   rect(this.sizesOfReplay[0], this.sizesOfReplay[1], this.sizesOfReplay[2], this.sizesOfReplay[3], this.sizeField/120, this.sizeField/120, this.sizeField/120, this.sizeField/120);
   textSize(this.replaySize * 2);
   textAlign(CENTER);
   fill(255);
   text(message, (float)(this.sizeField/2), (float)(this.sizeField/2));
   textSize(this.replaySize);
   text("Play again", (float)(this.sizeField/2), (float)(3*this.sizeField/4));
   this.gameOver = true;
  }
  
  public void initialField() {
    this.field = new int[][]{{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
    fill(0);
    stroke(0);
    rect(0, 0, this.sizeField, this.sizeField);
    stroke(255);
    for(int i = 1; i < 3; i++) {
      line(sizeField/3 * i, 0, sizeField/3 * i, sizeField);
    }
    for(int i = 1; i < 3; i++) {
      line(0, sizeField/3 * i, sizeField, sizeField/3 * i);
    }
  }
 
  private int sumOfArray(int[] test) {int sum = 0; for(int i: test) {sum += i;} return sum;}
}
