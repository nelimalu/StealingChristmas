/* constants */
final int GRAVITY = 3;
final int BACKGROUND_SPEED = 3;
final int BACKGROUND_IMAGE_SPEED = 1;
final int PLATFORM_SPAWN_DIFFERENCE = 150;

/* global variables */
boolean[] moveKeys = new boolean[4];  // array to store all directions being pressed: 0 - UP, 1 - DOWN, 2 - LEFT, 3 - RIGHT
int groundY;
boolean lost = false;
int background_imageX = 0;
int score = 0;

/* graphics */
PImage[] tiles = new PImage[6];
PImage[] grinchSprite = new PImage[4];
PImage background;
PImage spike;
PImage present;
PImage snow;

void setup() {
  size(1000, 600);
  
  // variables that can only be defined after window size is set
  groundY = height - 30;
  grinchY = height - grinchHeight - (height - groundY);
  createPlatform(0, groundY, 1024, height - groundY, 0);  // starting platform
  
  // image loading
  for (int i = 0; i < 6; i++) {
    tiles[i] = loadImage("tile" + (i + 1) + ".png");
  }
  for (int i = 0; i < 4; i++) {
    grinchSprite[i] = loadImage("grinch" + (i + 1) + ".png");
  }
  background = loadImage("background.png");
  spike = loadImage("spike.png");
  present = loadImage("present.png");
  snow = loadImage("snow.png");
}


void drawBackground() {
  // cycle background image at a slower speed
  background_imageX -= BACKGROUND_IMAGE_SPEED;
  image(background, background_imageX, 0);
  image(background, background_imageX + width, 0);
  fill(255,255,255,200);
  rect(0, 0, width, height);
  
  if (background_imageX <= -width)
    background_imageX = 0;
    
  textSize(32);
  fill(0, 0, 0);
  text("Score: " + score, 10, 40); // draw score on top left of screen
}

void draw() {
  if (!lost) {
    
    drawBackground();
    updatePlatforms();
    updateObstacles();
    updateGrinch();
    updatePresents();
    
  } else {
    lose();
  }
}


void lose() {
  fill(255,0,0,1);
  rect(0, 0, width, height);  // red tint overlay
  
  // display game over message in middle of screen
  textSize(128);
  String loseMessage = "GAME OVER";
  float text_width = textWidth(loseMessage);
  float text_height = textAscent() - textDescent();
  fill(0, 0, 0);
  text(loseMessage, (width / 2) - (text_width / 2), (height / 2) + (text_height / 2));
  
}

// keep track of which buttons are pressed
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
