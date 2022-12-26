ArrayList<int[]> platforms = new ArrayList<int[]>();

boolean rectCollision(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {  // checks if two rectangles collide
  return x1 < x2 + w2 && x1 + w1 > x2 && y1 < y2 + h2 && h1 + y1 > y2;
}

String collide(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {  // check if two rectangles collide and which side they collide on
    double dx = (x1 + w1 / 2) - (x2 + w2 / 2);
    double dy = (y1 + h1 / 2) - (y2 + h2 / 2);
    double w = (w1 + w2) / 2;
    double h = (h1 + h2) / 2;
    double crossWidth = w * dy;
    double crossHeight = h * dx;
    String collision = "none";

    if (Math.abs(dx) <= w && Math.abs(dy) <= h) {
        if (crossWidth > crossHeight) 
            collision = crossWidth > -crossHeight ? "bottom" : "left";
        else
            collision = crossWidth > -crossHeight ? "right" : "top";
    }
    return collision;
}

// loops through all platforms and checks if grinch collides with any, and on which side they collide
ArrayList<String> platformCollide(int x, int y, int w, int h) { // takes grinch location as parameters
  ArrayList<String> collisions = new ArrayList<String>();

  for (int i = 0; i < platforms.size(); i++) {
    String collision = collide(x, y, w, h, platforms.get(i)[0], platforms.get(i)[1], platforms.get(i)[2], platforms.get(i)[3]);
    if (!collision.equals("none")) {
      collisions.add(collision + ";" + platforms.get(i)[1] + ";" + platforms.get(i)[3] + ";" + platforms.get(i)[0] + ";" + platforms.get(i)[2]);
    }

  }
  
  return collisions;
}

// gets a random number from min to max, but is a multiple of 32 (to fit 32x32 sprites)
int random32(int min, int max) {
  int range = max - min;
  int amount = range / 32;
  int[] numbers = new int[amount];
  
  int counter = 0;
  for (int i = min; i < max; i++) {
    if (i % 32 == 0) {
      numbers[counter] = i;
      counter++;
    }
  }
  
  return numbers[(int) random(0, amount)];
}

// adds a platform to the arraylist
void createPlatform(int x, int y, int w, int h, int tile) {
  platforms.add(new int[] {x, y, w, h, tile});
}

// fills a platform with tiles
void drawPlatforms() {
  for (int i = 0; i < platforms.size(); i++) {
    int x = platforms.get(i)[0];
    int y = platforms.get(i)[1];
    int w = platforms.get(i)[2];
    int h = platforms.get(i)[3];
    
    // draw all tiles
    for (int a = 0; a < w; a += 32) {
      for (int b = 0; b < h; b += 32) {
        image(tiles[platforms.get(i)[4]], x + (a), y + (b));
      }
    }
    
    // draw snow on first layer
    for (int a = 0; a < w; a += 32) {
      image(snow, x + (a), y);
    }
  }
}

void movePlatforms() {
  for (int i = 0; i < platforms.size(); i++) {
    platforms.get(i)[0] -= BACKGROUND_SPEED;  // move platforms along with background
    
    if (platforms.get(i)[0] + platforms.get(i)[2] < 0) {  // if platform is off the screen, delete it
      platforms.remove(i);
    }
  }
}

void updatePlatforms() {
  drawPlatforms();
  movePlatforms();
  
  int[] last_platform = platforms.get(platforms.size() - 1);
  int last_platform_end = last_platform[0] + last_platform[2];
  
  if (last_platform_end <= width) {  // if the last platform is visible on the screen, make a new platform
    int gap = (int) random(150, 300);  // how big is the gap between platforms
    int size = (int) random32(200, 500);  // how long is the new platform
    
    // figure out how tall the platform should be, while not being impossible to jump to
    int maximum_height_range = max(grinchHeight, last_platform[1] - PLATFORM_SPAWN_DIFFERENCE);
    int minimum_height_range = min(groundY, last_platform[1] + PLATFORM_SPAWN_DIFFERENCE);
    int y = (int) random(maximum_height_range, minimum_height_range);
    
    createPlatform(last_platform_end + gap, y, size, height - y, (int) random(0, 6));
    
    if ((int) random(1, 2) == 1) {  // 50% chance to create an obstacle on the platform
      createObstacle(platforms.get(platforms.size() - 1));
    }
    
    // spawn a present on the platform
    createPresent(platforms.get(platforms.size() - 1));
  }
}
