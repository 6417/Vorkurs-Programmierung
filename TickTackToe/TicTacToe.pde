int sizeField = 600;
GameHandler Game;

void settings() {
  size(sizeField, sizeField);
}

void setup() {
  Game = new GameHandler(sizeField);
}

void draw() {
  Game.update();
}