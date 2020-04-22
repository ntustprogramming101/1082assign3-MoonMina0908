final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

float groundhogX, groundhogY, groundhogMoveX = 80, groundhogMoveY = 80;
int lifeX=10, lifeY=10, lifeGap=70;

int block =80;
int firstStone=8, secondStone=16, thirdStone=24, stone1X, stone1Y, stone2X, stone2Y;
float bgMove;

float newTime;
float lastTime;
boolean right =false, left =false, down =false, up =false;


PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;
PImage groundhogIdleImg, groundhogDownImg, groundhogLeftImg, groundhogRightImg;
PImage lifeImg, soldierImg, cabbageImg;
PImage soil0Img, soil1Img, soil2Img, soil3Img, soil4Img, soil5Img, stone1Img, stone2Img;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  soil8x24 = loadImage("img/soil8x24.png");

  groundhogIdleImg =loadImage("img/groundhogIdle.png");
  groundhogDownImg =loadImage("img/groundhogDown.png");
  groundhogLeftImg =loadImage("img/groundhogLeft.png");
  groundhogRightImg =loadImage("img/groundhogRight.png");
  lifeImg =loadImage("img/life.png");
  soldierImg =loadImage("img/soldier.png");
  cabbageImg =loadImage("img/cabbage.png");

  soil0Img =loadImage("img/soil0.png");
  soil1Img =loadImage("img/soil1.png");
  soil2Img =loadImage("img/soil2.png");
  soil3Img =loadImage("img/soil3.png");
  soil4Img =loadImage("img/soil4.png");
  soil5Img =loadImage("img/soil5.png");
  stone1Img =loadImage("img/stone1.png");
  stone2Img =loadImage("img/stone2.png");

  playerHealth=2;
  groundhogX = block*4;
  groundhogY = block;

  lastTime=millis();
  frameRate(60);
  bgMove=0;
}

void draw() {
  /* ------ Debug Function ------ 
   
   Please DO NOT edit the code here.
   It's for reviewing other requirements when you fail to complete the camera moving requirement.
   
   */
  if (debugMode) {
    pushMatrix();
    translate(0, cameraOffsetY);
  }
  /* ------ End of Debug Function ------ */


  switch (gameState) {

  case GAME_START: // Start Screen
    image(title, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
      }
    } else {

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;

  case GAME_RUN: // In-Game

    // Background
    image(bg, 0, 0);



    // Sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(590, 50, 120, 120);
    
    
    pushMatrix ( );
    translate ( 0, -bgMove);
    
    pushMatrix ( );
    translate ( 0, block*2-GRASS_HEIGHT);
    // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 0, width, GRASS_HEIGHT);
    popMatrix();

    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    pushMatrix ( );
    translate ( 0, block*2);
    //Soil
    for (int i=0; i<block*8; i+=80) {
      for (int j=0; j<block*4; j+=80) {
        image(soil0Img, i, j);
      }
      for (int j=block*4; j<block*8; j+=80) {
        image(soil1Img, i, j);
      }
      for (int j=block*8; j<block*12; j+=80) {
        image(soil2Img, i, j);
      }
      for (int j=block*12; j<block*16; j+=80) {
        image(soil3Img, i, j);
      }
      for (int j=block*16; j<block*20; j+=80) {
        image(soil4Img, i, j);
      }
      for (int j=block*20; j<block*24; j+=80) {
        image(soil5Img, i, j);
      }
    }

    popMatrix ( );

    //Stone1
    pushMatrix ( );
    translate ( 0, block*2);
    stone1X = 0;
    stone1Y = 0;
    for (int i=0; i<block*8; i++) {
      stone1X = i*block;
      image(stone1Img, stone1X, stone1Y);
      stone1Y+=block;
    } 
    popMatrix ( );

    //Stone2
    pushMatrix ( );
    translate ( 0, block*10);
    for (int i=-block; i<block*8; i+=block*4) {
      for (int j=80; j<block*3; j+=80) {
        image(stone1Img, i, j);
        image(stone1Img, i+block, j);
        image(stone1Img, i, j+block*4);
        image(stone1Img, i+block, j+block*4);
      }
    }
    for (int i=block; i<block*8; i+=block*4) {
      for (int j=0; j<block; j+=80) {
        image(stone1Img, i, j);
        image(stone1Img, i+block, j);
        image(stone1Img, i, j+block*3);
        image(stone1Img, i+block, j+block*3);
        image(stone1Img, i, j+block*4);
        image(stone1Img, i+block, j+block*4);
        image(stone1Img, i, j+block*7);
        image(stone1Img, i+block, j+block*7);
      }
    }
    popMatrix ( );

    //Stone3
    pushMatrix ( );
    translate ( 0, block*18);
    for (int i=block; i<block*8; i+=block*3) {
      for (int j=0; j<block*8; j+=block*3) {
        image(stone1Img, i, j);
        image(stone1Img, i+block, j);
        image(stone2Img, i+block, j);
      }
    }
    for (int i=0; i<block*8; i+=block*3) {
      for (int j=block; j<block*8; j+=block*3) {
        image(stone1Img, i, j);
        image(stone1Img, i+block, j);
        image(stone2Img, i+block, j);
      }
    }
    for (int i=-block; i<block*8; i+=block*3) {
      for (int j=block*2; j<block*8; j+=block*3) {
        image(stone1Img, i, j);
        image(stone1Img, i+block, j);
        image(stone2Img, i+block, j);
      }
    }
    popMatrix ( );
    
    // Player
    if (left) {
      if ( groundhogMoveX>=groundhogX ) {
        image( groundhogLeftImg, groundhogMoveX, groundhogY );
        groundhogMoveX -= (block/15);
      } else {
        left = false;
      }
    } else if ( right ) {
      if ( groundhogMoveX<=groundhogX ) {
        image( groundhogRightImg, groundhogMoveX, groundhogY );
        groundhogMoveX += (block/15);
      } else {
        right = false;
      }
    } else if (down) {
      if ( groundhogMoveY<=groundhogY ) {
        image( groundhogDownImg, groundhogX, groundhogMoveY );
        groundhogMoveY += (block/15);
        //bgMove-=5/15;
        bgMove += (block/15);
        if(bgMove>=block*20){
          bgMove=block*20;
        }
      } else {
        down = false;
      }
    } else {
      image( groundhogIdleImg, groundhogX, groundhogY );
    }
    popMatrix ( );
    //boundary check
    if (groundhogX>width- groundhogIdleImg.width) {
      groundhogX=width- groundhogIdleImg.width;
    } else if (groundhogX<0) {
      groundhogX = 0;
    } 
    else if (groundhogY > block*26-groundhogIdleImg.height) {
      groundhogY = block*26- groundhogIdleImg.height;
    }
    
    // Health UI
    for (int i=10; i<10+lifeGap*playerHealth; i+=lifeGap) {
      image(lifeImg, i, lifeY);
    }
    break;

  case GAME_OVER: // Gameover Screen
    image(gameover, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
        // Remember to initialize the game here!
      }
    } else {

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;
  }

  // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
  if (debugMode) {
    popMatrix();
  }
}

void keyPressed() {
  // Add your moving input code here
  float newTime = millis();
  if (key==CODED) {
    switch( keyCode ) {
    case LEFT:
      if (newTime - lastTime> 250) {
        groundhogMoveX = groundhogX;
        left = true;
        groundhogX -= block;
        lastTime=newTime;
      }
      break;

    case RIGHT:
      if (newTime - lastTime> 250) {
        groundhogMoveX = groundhogX;
        right = true;
        groundhogX += block;
        lastTime=newTime;
      }
      break;

    case DOWN:
      if (newTime - lastTime> 250) {
        groundhogMoveY = groundhogY;
        down = true;
        groundhogY += block;
        //if(bgMove>0 && bgMove<1600){bgMove-=5;}
        println(bgMove);
        lastTime=newTime;
      }
      break;
      //case UP:groundhogY -=block; bgMove -=block;break;
    }
  }
  
  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
  switch(key) {
  case 'w':
    debugMode = true;
    cameraOffsetY += 25;
    break;

  case 's':
    debugMode = true;
    cameraOffsetY -= 25;
    break;

  case 'a':
    if (playerHealth > 0) playerHealth --;
    break;

  case 'd':
    if (playerHealth < 5) playerHealth ++;
    break;
  }
}

void keyReleased() {
}
