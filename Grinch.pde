int grinchWidth = 50;
int grinchHeight = 100;
int grinchX = 10;
int grinchY;
int grinchVel = 4;


void updateGrinch() {
  moveGrinch();
  physicsGrinch();
  drawGrinch();
}

void drawGrinch() {
  noStroke();
  fill(36, 191, 96);
  rect(grinchX, grinchY, grinchWidth, grinchHeight);
}

void physicsGrinch() {
  grinchY += GRAVITY;
  if (grinchY + grinchHeight > groundY)
    grinchY = groundY - grinchHeight;
    
}

void moveGrinch() {
  
  if (moveKeys[0]) // UP
    grinchY -= grinchVel;
  if (moveKeys[1]) // DOWN
    grinchY += grinchVel;
  
  if (moveKeys[2]) // LEFT
    grinchX -= grinchVel;
  if (moveKeys[3])  // RIGHT
    grinchX += grinchVel;
}
