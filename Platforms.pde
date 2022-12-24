ArrayList<int[]> platforms = new ArrayList<int[]>();
int collisionMargin = 1;

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

    if (Math.abs(dx) <= w && Math.abs(dy) <= h){
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

void createPlatform(int x, int y, int w, int h) {
  platforms.add(new int[] {x, y, w, h});
}

void drawPlatforms() {
  for (int i = 0; i < platforms.size(); i++) {
    fill(0,0,0);
    rect(platforms.get(i)[0], platforms.get(i)[1], platforms.get(i)[2], platforms.get(i)[3]);
  }
}

void generatePlatform() {
  createPlatform(width, (int) random(height), 200, 10);
}

void updatePlatforms() {
  drawPlatforms();
  
  for (int i = 0; i < platforms.size(); i++) {
    platforms.get(i)[0] -= BACKGROUND_SPEED;
    
    if (platforms.get(i)[0] + platforms.get(i)[2] < 0) {
      platforms.remove(i);
    }
  }
  
  if ((int) random(50) == 1)
    generatePlatform();
}
