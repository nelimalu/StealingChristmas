int grinchWidth = 50;
int grinchHeight = 100;
int grinchX = 10;
int grinchY;
int grinchVel = 4;
boolean grinchJumping = false;
int grinchJumpingFrame = 0;


void updateGrinch() {
  moveGrinch();
  drawGrinch();
}

void drawGrinch() {
  noStroke();
  fill(36, 191, 96);
  rect(grinchX, grinchY, grinchWidth, grinchHeight);  // draw the grinch
}

void resetJump() {
  grinchJumping = false;  // if he hits the ground that means he's not jumping anymore
  grinchJumpingFrame = 0;
}

void physicsGrinch(String[] collision) {
  if (grinchJumping)
    grinchY += GRAVITY * (0.1 * (1 + grinchJumpingFrame));  // move grinch down with gravity
  else
    grinchY += GRAVITY * 1.5;
  
  if (collision[0].equals("top")) {  // make sure he cant fall through the floor
    grinchY = int(collision[1]) - grinchHeight;
    
    if (grinchJumping && grinchJumpingFrame >= 1) {  // make sure he gets a chance to actually jump
      resetJump();
    }
  }
  
    
  if (grinchJumping) {
    grinchJumpingFrame++;
    grinchY -= (300 / (25 + grinchJumpingFrame));  // 300 / (25 + grinchJumpingFrame);
    
    if (collision[0].equals("bottom")) {
      grinchJumpingFrame = 20;
      grinchY = int(collision[1]) + int(collision[2]) + 1;
      // moveY += (300 / (25 + grinchJumpingFrame));
    }
  }
}

void moveGrinch() {
  String[] collision = platformCollide(grinchX, grinchY, grinchWidth, grinchHeight).split(";");
  println(collision);
  
  if (moveKeys[0] && !collision[0].equals("bottom"))// && !grinchJumping) // UP
    grinchJumping = true;
    //grinchY -= grinchVel;
  //if (moveKeys[1] && !collision[0].equals("top"))// && !grinchJumping)
  //  grinchY += grinchVel;
  if (moveKeys[2] && !collision[0].equals("right")) // LEFT
    grinchX -= grinchVel;
  if (moveKeys[3] && !collision[0].equals("left"))  // RIGHT
    grinchX += grinchVel;
    
  physicsGrinch(collision);
}
