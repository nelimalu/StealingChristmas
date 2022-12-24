/* constants */
final int GRAVITY = 3;
final int BACKGROUND_SPEED = 3;
final int PLATFORM_SPAWN_DIFFERENCE = 150;

/* global variables */
boolean[] moveKeys = new boolean[4];  // array to store all directions being pressed: 0 - UP, 1 - DOWN, 2 - LEFT, 3 - RIGHT
int groundY;
boolean lost = false;

void setup() {
  size(1000, 600);
  
  // variables that can only be defined after window size is set
  groundY = height - 30;
  grinchY = height - grinchHeight - (height - groundY);
  createPlatform(0, groundY, width, height - groundY);
  //createPlatform(400, 500, 100, 100);
}

void draw() {
  if (!lost) {
    background(240, 252, 252);
    
    updateGrinch();
    updatePlatforms();
    updateObstacles();
    
  } else {
    lose();
  }
}


void lose() {
  fill(255,0,0,1);
  rect(0, 0, width, height);
  
  textSize(128);
  String loseMessage = "GAME OVER";
  float text_width = textWidth(loseMessage);
  float text_height = textAscent() - textDescent();
  fill(0, 0, 0);
  text("GAME OVER", (width / 2) - (text_width / 2), (height / 2) + (text_height / 2)); 
  
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
