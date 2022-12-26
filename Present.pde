ArrayList<int[]> presents = new ArrayList<int[]>();

void createPresent(int[] platform) {  // place an obstacle on the platform   
  int presentX = (int) random(platform[0], platform[0] + platform[2]);
  int presentY = platform[1] - (int) random(100, 150);
  
  presents.add(new int[] {presentX, presentY});
}

void drawPresent(int x, int y) {
  image(present, x, y);
}

void updatePresents() {
  for (int i = 0; i < presents.size(); i++) {
    presents.get(i)[0] -= BACKGROUND_SPEED;
    drawPresent(presents.get(i)[0], presents.get(i)[1]);
    
    if (presents.get(i)[0] - 32 < 0)
      presents.remove(i);    
    else if (rectCollision(grinchX, grinchY, grinchWidth, grinchHeight, presents.get(i)[0], presents.get(i)[1], 32, 32)) {
      score++;
      presents.remove(i);
    }
    
    
  }
}
