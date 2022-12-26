ArrayList<int[]> obstacles = new ArrayList<int[]>();

void drawObstacle(int x, int y, int w, int h) {
  for (int i = 0; i < w; i += 32) {
    image(spike, x + i, y);
  }
}

void updateObstacles() {
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i)[0] -= BACKGROUND_SPEED;
    drawObstacle(obstacles.get(i)[0], obstacles.get(i)[1], obstacles.get(i)[2], obstacles.get(i)[3]);
    
    if (rectCollision(grinchX, grinchY, grinchWidth, grinchHeight, obstacles.get(i)[0], obstacles.get(i)[1], obstacles.get(i)[2], obstacles.get(i)[3])) {
      lost = true;
    }
    
    //if (obstacles.get(i)[0] - obstacles.get(i)[2] < 0)
    //  obstacles.remove(i);
  }
}

void createObstacle(int[] platform) {  // place an obstacle on the platform
  if (platform[2] > 300) { // make sure the platform is long enough to support a obstacle without being impossible to play
    
    int obstacleWidth = (int) random32(50, 150);
    int obstacleX = (int) random(platform[0] + 60, platform[0] + platform[2] - 60 - obstacleWidth);  // get random location on the platform but not on the edge
    int obstacleHeight = 32;
    int obstacleY = platform[1] - obstacleHeight;
    
    
    obstacles.add(new int[] {obstacleX, obstacleY, obstacleWidth, obstacleHeight});
    
  }
}
