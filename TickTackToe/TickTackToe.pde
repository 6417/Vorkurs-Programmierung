import java.util.Arrays;

int sizeField = 600;
GameHandler Game;

void settings() {
  size(sizeField, sizeField);
}

void setup() {
  background(0);
  Game = new GameHandler(sizeField);
  //Game.initialField();
}

void draw() {
  Game.update();
}
