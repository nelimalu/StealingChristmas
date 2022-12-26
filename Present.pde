ArrayList<int[]> presents = new ArrayList<int[]>();

void createPresent(int[] platform) {  //place a present on the platform   
  int presentX = (int) random(platform[0], platform[0] + platform[2]);
  int presentY = platform[1] - (int) random(100, 150);  // make present float above platform
  
  presents.add(new int[] {presentX, presentY});
}

void drawPresent(int x, int y) {
  image(present, x, y);
}

void updatePresents() {
  for (int i = 0; i < presents.size(); i++) {
    presents.get(i)[0] -= BACKGROUND_SPEED;
    drawPresent(presents.get(i)[0], presents.get(i)[1]);
    
    if (presents.get(i)[0] < -30)  // if present is off the screen, delete it
      presents.remove(i);    
    else if (rectCollision(grinchX, grinchY, grinchWidth, grinchHeight, presents.get(i)[0], presents.get(i)[1], 32, 32)) {  // if grinch collects present
      score++;  // increase score
      presents.remove(i);  // delete present
    }
    
    
  }
}
