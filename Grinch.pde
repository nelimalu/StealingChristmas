int grinchX = 10;
int grinchY = 10;
int grinchVel = 4;
int grinchWidth = 50;
int grinchHeight = 100;

void updateGrinch() {
  moveGrinch();
  drawGrinch();
}

void drawGrinch() {
  noStroke();
  fill(36, 191, 96);
  rect(grinchX, grinchY, grinchWidth, grinchHeight);
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
