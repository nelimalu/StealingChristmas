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

void physicsGrinch(String collision) {
  grinchY += GRAVITY * (0.1 * (1 + grinchJumpingFrame));  // move grinch down with gravity
  if (GRAVITY * (0.1 * (1 + grinchJumpingFrame)) > 300 / (25 + grinchJumpingFrame))
    println(grinchJumpingFrame);
  
  if (collision.equals("top")) {  // make sure he cant fall through the floor
    grinchY = groundY - grinchHeight;
    
    if (grinchJumping && grinchJumpingFrame >= 1) {  // make sure he gets a chance to actually jump
      resetJump();
    }
  }
  
    
  if (grinchJumping) {
    grinchJumpingFrame++;
    int moveY = grinchY - (300 / (25 + grinchJumpingFrame));  // 300 / (25 + grinchJumpingFrame);
    
    if (platformCollide(grinchX, moveY, grinchWidth, grinchHeight).equals("bottom")) {
      
      grinchJumpingFrame = 20;
      moveY += 3;
      // moveY += (300 / (25 + grinchJumpingFrame));
    }
    
    grinchY = moveY;
  }
}

void moveGrinch() {
  String collision = platformCollide(grinchX, grinchY, grinchWidth, grinchHeight);
  
  if (moveKeys[0] && !collision.equals("bottom"))// && !grinchJumping) // UP
    grinchJumping = true;
    //grinchY -= grinchVel;
  //if (moveKeys[1] && !collision.equals("top"))// && !grinchJumping)
  //  grinchY += grinchVel;
  if (moveKeys[2] && !collision.equals("right")) // LEFT
    grinchX -= grinchVel;
  if (moveKeys[3] && !collision.equals("left"))  // RIGHT
    grinchX += grinchVel;
    
  physicsGrinch(collision);
}
