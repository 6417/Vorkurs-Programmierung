public class GameHandler {
  //Spiel-Variabeln
  private int sizeField;
  private int counter = 0;
  private int[][] field;
  private EventHandler event;
  private boolean gameOver = false;
  
  //Weiterspielen Variabeln
  private float[] sizesOfReplay; //Standort und Dimensionen des Knopfes "Replay"
  private float replaySize; //Grösse der Schrift "Replay"
  
  //Spielerlebniss verbesserer Variabeln
  private boolean waitForPlay = false;
  private int waitCounter = 0;
  
  public GameHandler(int sizeField) {
    this.sizeField = sizeField;
    this.initialField();
    this.replaySize = 11*this.sizeField/120;
    this.sizesOfReplay = new float[] {this.sizeField/2 - 24*this.replaySize/11, 3*this.sizeField/4 - 8*this.replaySize/11 - this.sizeField/120, 48*this.replaySize/11, this.replaySize + this.sizeField/60};
    this.event = new EventHandler(this.sizeField, this.sizesOfReplay);
  }
  
  public void update() {
    if (waitForPlay) {
      if (waitCounter > 30) {
        waitForPlay = false;
        waitCounter = 0;
      } else {
        waitCounter += 1;
      }
    } else if (!gameOver) {
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
          
          int solution = checkWinner();

          if (solution == 0) {
            this.finishGame("Circle winns!");
            this.waitForPlay = true;
          } else if (solution == 1) {
            this.finishGame("Cross winns!");
            this.waitForPlay = true;
          } else if (solution == 2) {
            this.finishGame("Draw!");
            this.waitForPlay = true;
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
  
  private void drawCircle(int[] pos) {
    fill(255);
    circle(this.sizeField/6 + this.sizeField/3 * pos[0], this.sizeField/6 + this.sizeField/3 * pos[1], this.sizeField/4);
  }
  
  private void drawCross(int[] pos) {
    strokeWeight(sqrt(2) * this.sizeField/24);
    strokeCap(ROUND);
    line(this.sizeField/16 + pos[0]*this.sizeField/3, this.sizeField/16 + pos[1]*this.sizeField/3, 13*this.sizeField/48 + pos[0]*this.sizeField/3, 13*this.sizeField/48 + pos[1]*this.sizeField/3);
    line(this.sizeField/16 + pos[0]*this.sizeField/3, 13*this.sizeField/48 + pos[1]*this.sizeField/3, 13*this.sizeField/48 + pos[0]*this.sizeField/3, this.sizeField/16 + pos[1]*this.sizeField/3);
    strokeWeight(1);
    strokeCap(SQUARE);
  }
  
  private int checkWinner() {
    int arraySum;

    for (int i = 0; i < 3; i++) {
      arraySum = sumOfArray(this.field[i]);
      if (arraySum == 12) {
          return 1;
      } else if (arraySum == 3) {
        return 0;
      }
      arraySum = sumOfArray(new int[] {this.field[0][i], this.field[1][i], this.field[2][i]});
      if (arraySum == 12) {
        return 1;
      } else if (arraySum == 3) {
        return 0;
      }
    }

    for (int i = 0; i < 2; i++) {
      arraySum = sumOfArray(new int[] {this.field[0][2*i], this.field[1][1], this.field[2][-2*i+2]});
      if (arraySum == 12) {
        return 1;
      } else if (arraySum == 3) {
        return 0;
      }
    }

    if (this.counter >= 9) {
      return 2;
    }

    return -1;
  }
  
  private void finishGame(String message) {
   stroke(0);
   fill(0);
   rect(0, 0, this.sizeField, this.sizeField);
   stroke(255);
   rect(this.sizesOfReplay[0], this.sizesOfReplay[1], this.sizesOfReplay[2], this.sizesOfReplay[3], this.sizeField/120, this.sizeField/120, this.sizeField/120, this.sizeField/120);
   textAlign(CENTER);
   textSize(this.replaySize * 2);
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
      line(0, sizeField/3 * i, sizeField, sizeField/3 * i);
    }
  }
 
  private int sumOfArray(int[] test) {
    int sum = 0; 
    for(int i: test) {
      sum += i;
    } 
    return sum;
  }
}
