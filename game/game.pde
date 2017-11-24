//Libraries
import ddf.minim.*;
import ptmx.*;

//Game Objects
int gameStatus = 0;
PImage startScreenImage;
Minim minim;
AudioPlayer titletrack;

//Game Constants
final int startScreen = 0;
final int playingGame = 1;
final int gameOver = 2;
final int gameWon = 3;

//Playing Constants
Ptmx map;
int x, y;
boolean left, right, up, down;

void setup() {
  size(800, 600);
  startScreenImage = loadImage("data/screens/start_screen.png");
  minim = new Minim(this);
  titletrack = minim.loadFile("data/audio/carryonmywaywardson.mp3");
  titletrack.play();
}

void draw() {
  switch(gameStatus) {
  case startScreen:
    drawStartScreen();
    break;
  case playingGame:
    drawGame();
    break;
  case gameOver:
    drawGameOverScreen();
    break;
  case gameWon:
    drawGameWonScreen();
    break;
  }
}

//*************
// Game Screens
//*************

void drawStartScreen() {
  image(startScreenImage, 0, 0);

  //Start Screen Control
  if ((key == ENTER) && (gameStatus != playingGame)) {
    setupGame();
    gameStatus = playingGame;
  }
}

void drawGameOverScreen() {
  background(51);
  textAlign(CENTER);
  textSize(40);
  fill(255);
  text("GAME OVER\nPRESS ENTER TO RESTART", width/2, height/2);
  println("game over screen drawn");
}

void drawGameWonScreen() {
  background(51);
  textAlign(CENTER);
  textSize(40);
  fill(255);
  text("YOU WON!\nPRESS ENTER TO RESTART", width/2, height/2);
  println("won screen drawn");
}

void drawGame() {
  background(map.getBackgroundColor());
  map.draw(x, y);

  if (left) x -= 3;
  if (right) x += 3;
  if (up) y -= 3;
  if (down) y += 3;
}

void setupGame() {
  map = new Ptmx(this, "data/maps/crossroad.tmx");
  map.setDrawMode(CENTER);
  map.setPositionMode("CANVAS");
  x = int(map.mapToCanvas(map.getMapSize()).x / 2);
  y = int(map.mapToCanvas(map.getMapSize()).y / 2);
  imageMode(CENTER);
}

void keyPressed() {
  if (gameStatus == playingGame) {
    if (keyCode == LEFT || keyCode == 65) left = true;
    if (keyCode == RIGHT || keyCode == 68) right = true;
    if (keyCode == UP || keyCode == 87) up = true;
    if (keyCode == DOWN || keyCode == 83) down = true;
  }
}
