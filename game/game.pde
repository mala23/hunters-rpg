//Libraries
import ddf.minim.*;
import ptmx.*;

//Game Objects
int gameStatus = 0;
PImage startScreenImage;
PImage gameOverScreenImage;
PImage gameWonScreenImage;
PImage character;
PImage messageAngelsblade;
Minim minim;
AudioPlayer titletrack;
int characterWalkingFrameRight = 0;
PImage[] deanWalkingFramesRight = new PImage[9];
int characterWalkingFrameLeft = 0;
PImage[] deanWalkingFramesLeft = new PImage[9];

//Game Constants
final int startScreen = 0;
final int playingGame = 1;
final int gameOver = 2;
final int gameWon = 3;

//Playing Constants
PGraphics npcsam;
PGraphics npcdemon;
PGraphics collisions;
PGraphics grass;
PGraphics path;
PGraphics treetrunks;
PGraphics treetops;
Ptmx map;
int x, y;
int messageTime;
boolean left, right, up, down;
String weapon = "fist";

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
  menuControls();
}

void drawGameOverScreen() {
  imageMode(CORNER);
  image(gameOverScreenImage, 0, 0);
  menuControls();
}

void drawGameWonScreen() {
  imageMode(CORNER);
  image(gameWonScreenImage, 0, 0);
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

  if (right || up) {
    characterWalkingFrameRight += 1;
    characterWalkingFrameRight = (characterWalkingFrameRight % 36);
    image((deanWalkingFramesRight[characterWalkingFrameRight / 4]), width / 2, (height / 2 - 32));
  } else if (left || down) {
    characterWalkingFrameLeft += 1;
    characterWalkingFrameLeft = (characterWalkingFrameLeft % 36);
    image((deanWalkingFramesLeft[characterWalkingFrameLeft / 4]), width / 2, (height / 2 - 32));
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
  //  setupGameOver();
  //  gameStatus = gameOver;
  }

  map.draw(npcsam, 7, x, y);

  if (npcsam.get(0, 0) == color(0) ||
      npcsam.get(16, 0) == color(0) ||
      npcsam.get(32, 0) == color(0) ||
      npcsam.get(0, 32) == color(0)) {
    x = prevX;
    y = prevY;
    println("met sam");
    println(weapon);
    weapon = "angelsblade";
    // messageTime = millis();
    // for (millis() <= (messageTime + 600)) {
    //  imageMode(CORNER);
    //  image(messageAngelsblade, 0, 0);
    // }
    // imageMode(CORNER);
    // image(gameOverScreenImage, 0, 0);
    println("you received " + weapon);
  }

  map.draw(npcdemon, 6, x, y);

  if (npcdemon.get(0, 0) == color(0) ||
      npcdemon.get(16, 0) == color(0) ||
      npcdemon.get(32, 0) == color(0) ||
      npcdemon.get(0, 32) == color(0)) {
    println("met demon");
    println(weapon);
    x = prevX;
    y = prevY;
    if (weapon != "angelsblade") {
      setupGameOver();
      gameStatus = gameOver;
    } else {
      setupGameWon();
      gameStatus = gameWon;
    }
  }
}

void setupGame() {
  left = false;
  right = false;
  up = false;
  down = false;
  map = new Ptmx(this, "data/maps/crossroad.tmx");
  character = loadImage("data/dean_walking/dean_lo1.png");
  deanWalkingFramesRight[0] = loadImage("data/dean_walking/dean_lo2.png");
  deanWalkingFramesRight[1] = loadImage("data/dean_walking/dean_lo3.png");
  deanWalkingFramesRight[2] = loadImage("data/dean_walking/dean_lo4.png");
  deanWalkingFramesRight[3] = loadImage("data/dean_walking/dean_lo5.png");
  deanWalkingFramesRight[4] = loadImage("data/dean_walking/dean_lo6.png");
  deanWalkingFramesRight[5] = loadImage("data/dean_walking/dean_lo7.png");
  deanWalkingFramesRight[6] = loadImage("data/dean_walking/dean_lo8.png");
  deanWalkingFramesRight[7] = loadImage("data/dean_walking/dean_lo9.png");
  deanWalkingFramesRight[8] = loadImage("data/dean_walking/dean_lo10.png");
  deanWalkingFramesLeft[0] = loadImage("data/dean_walking/dean_lo11.png");
  deanWalkingFramesLeft[1] = loadImage("data/dean_walking/dean_lo12.png");
  deanWalkingFramesLeft[2] = loadImage("data/dean_walking/dean_lo13.png");
  deanWalkingFramesLeft[3] = loadImage("data/dean_walking/dean_lo14.png");
  deanWalkingFramesLeft[4] = loadImage("data/dean_walking/dean_lo15.png");
  deanWalkingFramesLeft[5] = loadImage("data/dean_walking/dean_lo16.png");
  deanWalkingFramesLeft[6] = loadImage("data/dean_walking/dean_lo17.png");
  deanWalkingFramesLeft[7] = loadImage("data/dean_walking/dean_lo18.png");
  deanWalkingFramesLeft[8] = loadImage("data/dean_walking/dean_lo19.png");
  messageAngelsblade = loadImage("data/messages/message_angelsblade.png");
  map.setDrawMode(CENTER);
  map.setPositionMode("CANVAS");
  npcsam = createGraphics(35, 35);
  npcdemon = createGraphics(35, 35);
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

void setupGameWon() {
  gameWonScreenImage = loadImage("data/screens/game_won_screen.png");
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
