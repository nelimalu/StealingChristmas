int grinchWidth = 50;
int grinchHeight = 100;
int grinchX = 300;
int grinchY;
int grinchVel = 4;
int grinchJumpHeight = 400;
boolean grinchJumping = false;
int grinchJumpingFrame = 0;


void updateGrinch() {
  moveGrinch();
  drawGrinch();
  
  if (grinchY >= height || grinchX - grinchWidth <= 0)  // if the grinch leaves screen, you lose
    lost = true;
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
    grinchY += GRAVITY * 1.5;  // if hes not jumping, that means he fell off a platform, so make him fall a bit faster
  
  if (collisionTypes.contains("top")) {  // make sure he cant fall through the floor
    for (int i = 0; i < collision.size(); i++) {  // you can collide with multiple platforms; loop through each
      String[] thisCollision = collision.get(i).split(";");
      if (thisCollision[0].equals("top")) {  // if hit the top of platform
        grinchY = int(thisCollision[1]) - grinchHeight;  // set the grinch y value to the top of the platform (can't move into platform)
        
        if (grinchJumping && grinchJumpingFrame >= 1) {  // make sure he gets a chance to actually jump
          resetJump();
        }
      }
    }
  }
  
  if (collisionTypes.contains("left")) {  // make sure he doesn't move into walls
    for (int i = 0; i < collision.size(); i++) {  // can collide with multiple platforms, so loop through each
      String[] thisCollision = collision.get(i).split(";");
      if (thisCollision[0].equals("left")) {
        grinchX = int(thisCollision[3]) - grinchWidth - BACKGROUND_SPEED - 1; // if they hit the side of a platform, move them next to it (prevents clipping)
      }
    }
  }
        
  
    
  if (grinchJumping) {
    grinchJumpingFrame++;
    grinchY -= (grinchJumpHeight / (25 + grinchJumpingFrame));  // if grinch jumping, move him up in a somewhat parabolic way
  }
}

String getCollisionTypes(ArrayList<String> collisions) {  // get all the sides of the collisions made
  String types = "";
  
  for (int i = 0; i < collisions.size(); i++) {
    types += collisions.get(i).split(";")[0];
  }
  
  return types;
}

void moveGrinch() {
  ArrayList<String> collisions = platformCollide(grinchX, grinchY, grinchWidth, grinchHeight);
  String collisionTypes = getCollisionTypes(collisions);
  
  if (moveKeys[0] && !collisionTypes.contains("bottom"))  // UP
    grinchJumping = true;
  if (moveKeys[2] && !collisionTypes.contains("right"))  // LEFT
    grinchX -= grinchVel;
  if (moveKeys[3] && !collisionTypes.contains("left"))  // RIGHT
    grinchX += grinchVel;
    
  physicsGrinch(collisions, collisionTypes);  // apply physics and collision
}
