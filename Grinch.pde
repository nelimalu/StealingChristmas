int grinchWidth = 50;
int grinchHeight = 100;
int grinchX = 10;
int grinchY;
int grinchVel = 4;
boolean grinchJumping = false;
int grinchJumpingFrame = 0;


void updateGrinch() {
  moveGrinch();
  physicsGrinch();
  drawGrinch();
}

void drawGrinch() {
  noStroke();
  fill(36, 191, 96);
  rect(grinchX, grinchY, grinchWidth, grinchHeight);  // draw the grinch
}

void physicsGrinch() {
  grinchY += GRAVITY * (0.1 * (1 + grinchJumpingFrame));  // move grinch down with gravity
  
  if (grinchY + grinchHeight > groundY) {  // make sure he cant fall through the floor
    grinchY = groundY - grinchHeight;
    
    if (grinchJumping && grinchJumpingFrame >= 1) {  // make sure he gets a chance to actually jump
      grinchJumping = false;  // if he hits the ground that means he's not jumping anymore
      grinchJumpingFrame = 0;
    }
  }
    
  if (grinchJumping) {
    grinchJumpingFrame++;
    grinchY -= 300 / (25 + grinchJumpingFrame);
  }
    
}

void moveGrinch() {
  
  if (moveKeys[0] && !grinchJumping) // UP
    grinchJumping = true;
  if (moveKeys[2]) // LEFT
    grinchX -= grinchVel;
  if (moveKeys[3])  // RIGHT
    grinchX += grinchVel;
}
