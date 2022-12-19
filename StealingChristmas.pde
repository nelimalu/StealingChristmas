/* constants */
final int GRAVITY = 3;

/* global variables */
boolean[] moveKeys = new boolean[4];  // array to store all directions being pressed: 0 - UP, 1 - DOWN, 2 - LEFT, 3 - RIGHT
int groundY;

void setup() {
  size(1000, 600);
  
  // variables that can only be defined after window size is set
  groundY = height - 30;
  grinchY = height - grinchHeight - (height - groundY);
  println(groundY);
}

void draw() {
  background(240, 252, 252);
  
  drawGround();
  updateGrinch();
}

void drawGround() {
  fill(32, 32, 32);
  rect(0, groundY, width, height - groundY);
}


void keyPressed() {
  if (key == 'w' || key == UP)
    moveKeys[0] = true;
  if (key == 's' || key == DOWN)
    moveKeys[1] = true;
  if (key == 'a' || key == LEFT)
    moveKeys[2] = true;
  if (key == 'd' || key == RIGHT)
    moveKeys[3] = true;
}

void keyReleased() {
  if (key == 'w' || key == UP)
    moveKeys[0] = false;
  if (key == 's' || key == DOWN)
    moveKeys[1] = false;
  if (key == 'a' || key == LEFT)
    moveKeys[2] = false;
  if (key == 'd' || key == RIGHT)
    moveKeys[3] = false;
}
