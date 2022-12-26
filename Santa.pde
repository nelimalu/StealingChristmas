int santaX = 10;
int santaWidth = 50;
int santaHeight = 100;
int santaY;
boolean santaJumping = false;
int santaJumpDistance = 0;
int santaJumpTravelled = 0;

int vertexX;
int vertexY;
double inclineSlope;
double declineSlope;
int[] point1;
int[] point2;


void drawSanta() {
  fill(255, 120, 105);
  rect(santaX, santaY, santaWidth, santaHeight);
}


void updateSanta() {
  int[] first_platform = platforms.get(0);
  
  if (!santaJumping) {
    // santaY = first_platform[1] - santaHeight;
    
    if (first_platform[0] + first_platform[2] < santaX + santaWidth) {
      int[] second_platform = platforms.get(1);
      
      santaJumping = true;
      
      
      point1 = new int[] { first_platform[0] + first_platform[2], first_platform[1] };
      point2 = new int[] { second_platform[0], second_platform[1] };
      
      santaJumpDistance = point2[0] - point1[0];
      
      vertexX = (santaJumpDistance / 2) + point1[0];
      vertexY = min(point1[1], point2[1]) - 100;
      
      inclineSlope = (point1[1] - vertexY) / (santaJumpDistance / -2.0);
      declineSlope = (point2[1] - vertexY) / (santaJumpDistance / 2.0);
    }
  } else {    
    santaJumpTravelled += BACKGROUND_SPEED;
    
    ellipse(vertexX, vertexY, 25, 25);
    ellipse(point1[0], point1[1], 25, 25);
    ellipse(point2[0], point2[1], 25, 25);
    
    println(inclineSlope + " " + declineSlope + " " + santaY);
    
    if (santaJumpTravelled < vertexX) {
      santaY = (int) ((santaJumpTravelled) * inclineSlope + (groundY - santaHeight));
    } if (santaJumpTravelled > vertexX) {
      santaY = (int) ((santaJumpTravelled) * declineSlope) ;
      //santaY = vertexY;
    }
    
    if (santaJumpTravelled >= santaJumpDistance + santaWidth) {
      santaJumping = false;
      santaJumpDistance = 0;
      santaJumpTravelled = 0;
    }
  }
  
  //santaY = platforms.get(1)[1] - santaHeight;
  
  drawSanta();
  
}
