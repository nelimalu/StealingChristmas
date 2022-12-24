ArrayList<int[]> obstacles = new ArrayList<int[]>();
/*
OBSTACLE:
x, y, width, height
*/

void updateObstacles() {
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i)[0] -= BACKGROUND_SPEED;
    fill(255,0,0);
    rect(obstacles.get(i)[0], obstacles.get(i)[1], obstacles.get(i)[2], obstacles.get(i)[3]);
    
    if (rectCollision(grinchX, grinchY, grinchWidth, grinchHeight, obstacles.get(i)[0], obstacles.get(i)[1], obstacles.get(i)[2], obstacles.get(i)[3])) {
      lost = true;
    }
  }
}

void createObstacle(int[] platform) {  // place an obstacle on the platform
  if (platform[2] > 300) { // make sure the platform is long enough to support a obstacle without being impossible to play
    
    int obstacleWidth = (int) random(50, 150);
    int obstacleX = (int) random(platform[0] + 60, platform[0] + platform[2] - 60 - obstacleWidth);  // get random location on the platform but not on the edge
    int obstacleHeight = 30;
    int obstacleY = platform[1] - obstacleHeight;
    
    
    obstacles.add(new int[] {obstacleX, obstacleY, obstacleWidth, obstacleHeight});
    
  }
}
