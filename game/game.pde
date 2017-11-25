//Libraries
import ddf.minim.*;
import ptmx.*;

//Game Objects
int gameStatus = 0;
PImage startScreenImage;
PImage gameOverScreenImage;
PImage character;
Minim minim;
AudioPlayer titletrack;
int characterWalkingFrame = 0;
PImage[] deanWalkingFrames = new PImage[9];

//Game Constants
final int startScreen = 0;
final int playingGame = 1;
final int gameOver = 2;
final int gameWon = 3;

//Playing Constants
PGraphics collisions;
PGraphics grass;
PGraphics path;
PGraphics treetrunks;
PGraphics treetops;
Ptmx map;
int x, y;
boolean left, right, up, down;

void setup() {
  size(800, 600);
  startScreenImage = loadImage("data/screens/start_screen.png");
//  minim = new Minim(this);
//  titletrack = minim.loadFile("data/audio/carryonmywaywardson.mp3");
//  titletrack.play();
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
  menuControls();
}

void drawGameOverScreen() {
  imageMode(CORNER);
  image(gameOverScreenImage, 0, 0);
  menuControls();
}

void drawGameWonScreen() {
  background(0);
  textAlign(CENTER);
  textSize(40);
  fill(255);
  text("You won. Press ENTER to restart.", width/2, height/2);
  menuControls();
}

void drawGame() {
  background(map.getBackgroundColor());

  image(grass, width / 2, height / 2);
  map.draw(grass, 1, x, y);

  image(path, width / 2, height / 2);
  map.draw(path, 2, x, y);

  image(treetrunks, width / 2, height / 2);
  map.draw(treetrunks, 3, x, y);

  if (left || right || up || down) {
    characterWalkingFrame += 1;
    characterWalkingFrame = (characterWalkingFrame % 36);
    image((deanWalkingFrames[characterWalkingFrame / 4]), width / 2, (height / 2 - 32));
  } else {
    image(character, width / 2, (height / 2 - 32));
  }

  image(treetops, width / 2, height / 2);
  map.draw(treetops, 4, x, y);

  int prevX = x;
  int prevY = y;

  if (left) x -= 3;
  if (right) x += 3;
  if (up) y -= 3;
  if (down) y += 3;

  map.draw(collisions, 5, x, y);

  if (collisions.get(0, 0) == color(0) ||
      collisions.get(16, 0) == color(0) ||
      collisions.get(32, 0) == color(0) ||
      collisions.get(0, 32) == color(0)) {
    x = prevX;
    y = prevY;
    setupGameOver();
  //  gameStatus = gameOver;
  }
}

void setupGame() {
  left = false;
  right = false;
  up = false;
  down = false;
  map = new Ptmx(this, "data/maps/crossroad.tmx");
  character = loadImage("data/dean_walking/dean_lo1.png");
  deanWalkingFrames[0] = loadImage("data/dean_walking/dean_lo2.png");
  deanWalkingFrames[1] = loadImage("data/dean_walking/dean_lo3.png");
  deanWalkingFrames[2] = loadImage("data/dean_walking/dean_lo4.png");
  deanWalkingFrames[3] = loadImage("data/dean_walking/dean_lo5.png");
  deanWalkingFrames[4] = loadImage("data/dean_walking/dean_lo6.png");
  deanWalkingFrames[5] = loadImage("data/dean_walking/dean_lo7.png");
  deanWalkingFrames[6] = loadImage("data/dean_walking/dean_lo8.png");
  deanWalkingFrames[7] = loadImage("data/dean_walking/dean_lo9.png");
  deanWalkingFrames[8] = loadImage("data/dean_walking/dean_lo10.png");
  map.setDrawMode(CENTER);
  map.setPositionMode("CANVAS");
  collisions = createGraphics(32, 32);
  grass = createGraphics(width, height);
  path = createGraphics(width, height);
  treetops = createGraphics(width, height);
  treetrunks = createGraphics(width, height);
  x = int(map.mapToCanvas(map.getMapSize()).x / 2) + 300;
  y = int(map.mapToCanvas(map.getMapSize()).y / 2) + 400;
  imageMode(CENTER);
}

void setupGameOver() {
  gameOverScreenImage = loadImage("data/screens/game_over_screen.png");
}

void menuControls() {
  if ((key == ENTER) && (gameStatus != playingGame)) {
    setupGame();
    gameStatus = playingGame;
  }
}

void keyPressed() {
 if (gameStatus == playingGame) {
   if (keyCode == LEFT /* || keyCode == 65 */) left = true;
   if (keyCode == RIGHT /* || keyCode == 68 */) right = true;
   if (keyCode == UP /* || keyCode == 87 */) up = true;
   if (keyCode == DOWN /* || keyCode == 83 */) down = true;
 } else if ((gameStatus == playingGame) && (key == ALT) && (key == CONTROL)) {
     gameStatus = gameWon;
   }
}

void keyReleased() {
  if (gameStatus == playingGame) {
    if (keyCode == LEFT || keyCode == 65) left = false;
    if (keyCode == RIGHT || keyCode == 68) right = false;
    if (keyCode == UP || keyCode == 87) up = false;
    if (keyCode == DOWN || keyCode == 83) down = false;
  }
}
