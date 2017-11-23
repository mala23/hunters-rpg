//Game Objects
int gameStatus = 0;

//Game Constants
final int startScreen = 0;
final int playingGame = 1;
final int gameOver = 2;
final int gameWon = 3;

void setup() {
  size(800, 600);
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
  background(51);
  textAlign(CENTER);
  textSize(40);
  fill(255);
  text("Press ENTER to start\nNavigate using WASD or the arrow keys", width/2, height/2);

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
  background(0);
  //WASD Key Control
  if (keyCode == 87) {
    println("w for up"); 
  } else if (keyCode == 65) {
    println("a for left"); 
  } else if (keyCode == 83) {
    println("s for down"); 
  } else if (keyCode == 68) {
    println("d for right"); 
  }
  //Arrow Key Control
  if (keyCode == UP) {
    println("upkey for up"); 
  } else if (keyCode == LEFT) {
    println("leftkey for left"); 
  } else if (keyCode == DOWN) {
    println("downkey for down"); 
  } else if (keyCode == RIGHT) {
    println("rightkey for right"); 
  }
}

void setupGame() {
}
