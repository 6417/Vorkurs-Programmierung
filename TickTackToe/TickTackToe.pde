import java.util.Arrays;

int sizeField = 600;
GameHandler Game = new GameHandler(sizeField);

void settings() {
  size(sizeField, sizeField);
}

void setup() {
  background(0);
  stroke(255);
  for(int i = 1; i < 3; i++) {
    line(sizeField/3 * i, 0, sizeField/3 * i, sizeField);
  }
  for(int i = 1; i < 3; i++) {
    line(0, sizeField/3 * i, sizeField, sizeField/3 * i);
  }
}

void draw() {
  Game.update();
}
