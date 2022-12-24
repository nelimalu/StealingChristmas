int grinchWidth = 50;
int grinchHeight = 100;
int grinchX = 10;
int grinchY;
int grinchVel = 4;
int grinchJumpHeight = 400;
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

void physicsGrinch(ArrayList<String> collision, String collisionTypes) {
  if (grinchJumping)
    grinchY += GRAVITY * (0.1 * (1 + grinchJumpingFrame));  // move grinch down with gravity
  else
    grinchY += GRAVITY * 1.5;
  
  if (collisionTypes.contains("top")) {  // make sure he cant fall through the floor
    for (int i = 0; i < collision.size(); i++) {
      String[] thisCollision = collision.get(i).split(";");
      if (thisCollision[0].equals("top")) {
        grinchY = int(thisCollision[1]) - grinchHeight;
        
        if (grinchJumping && grinchJumpingFrame >= 1) {  // make sure he gets a chance to actually jump
          resetJump();
        }
      }
    }
  }
  
  if (collisionTypes.contains("left")) {  // make sure he doesn't move into walls
    for (int i = 0; i < collision.size(); i++) {
      String[] thisCollision = collision.get(i).split(";");
      if (thisCollision[0].equals("left")) {
        grinchX = int(thisCollision[3]) - grinchWidth - BACKGROUND_SPEED - 1;  // ISSUE glitches into wall
      }
    }
  }
        
  
    
  if (grinchJumping) {
    grinchJumpingFrame++;
    grinchY -= (grinchJumpHeight / (25 + grinchJumpingFrame));  // 300 / (25 + grinchJumpingFrame);
    
    /*
    if (collisionTypes.contains("bottom")) {
      for (int i = 0; i < collision.size(); i++) {
        String[] thisCollision = collision.get(i).split(";");
        if (thisCollision[0].equals("bottom")) {
          grinchJumpingFrame = 20;
          grinchY = int(thisCollision[1]) + int(thisCollision[2]) + 1;
          // moveY += (300 / (25 + grinchJumpingFrame));
        }
      }
    }
    */
  }
}

String getCollisionTypes(ArrayList<String> collisions) {
  String types = "";
  
  for (int i = 0; i < collisions.size(); i++) {
    types += collisions.get(i).split(";")[0];
  }
  
  return types;
}

void moveGrinch() {
  ArrayList<String> collisions = platformCollide(grinchX, grinchY, grinchWidth, grinchHeight);
  String collisionTypes = getCollisionTypes(collisions);
  
  println(collisionTypes);
  
  if (moveKeys[0] && !collisionTypes.contains("bottom"))// && !grinchJumping) // UP
    grinchJumping = true;
    //grinchY -= grinchVel;
  //if (moveKeys[1] && !collision[0].equals("top"))// && !grinchJumping)
  //  grinchY += grinchVel;
  if (moveKeys[2] && !collisionTypes.contains("right"))// LEFT
    grinchX -= grinchVel;
  if (moveKeys[3] && !collisionTypes.contains("left"))  // RIGHT
    grinchX += grinchVel;
    
  physicsGrinch(collisions, collisionTypes);
}
