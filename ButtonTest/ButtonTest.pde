Button[][] Grid = new Button[10][10];

void setup() {
  size(500, 500); 
  drawGrid();
} 

//draws the rects in a grid
void drawGrid() {
  pushMatrix();
  for (Button[] r : Grid) {
    pushMatrix();
    for (Button c : r) {
      rect(0, 0, 50, 50);
      translate(50, 0);
    }
    popMatrix();
    translate(0, 50);
  } 
  popMatrix();
}

void draw() {
}


int newButtonX;
int newButtonY;

void mousePressed() {
  newButtonX = (mouseX/50)*50;
  newButtonY = (mouseY/50)*50;
  fill(#B7AFAF);
  rect(newButtonX,newButtonY,50,50);
}

void mouseReleased() {
  if ( newButtonX == (mouseX/50)*50 && newButtonY == (mouseY/50)*50 ) {
    fill(#7C7373);
    rect(newButtonX, newButtonY, 50, 50);
  }
  else{
    fill(255);
    rect(newButtonX,newButtonY,50,50); 
  }
}

