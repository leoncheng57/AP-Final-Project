/*
  setup - grid of squares
 press mouse - color changes to gray
 release mouse over same square - color changes to blue
 mouse mouse and release over another sqaure - color changes back to white
 GLITCH = a button can be returned to its original color 
 ISSUE = buttons arent being stored in the array
 */

import java.util.*;
import java.io.*;

Button[][] grid = new Button[10][10];

void setup() {
  size(500, 500); 
  drawGrid();
} 

//draws the rects in a grid
void drawGrid() {
  pushMatrix();
  for (Button[] r : grid) {
    pushMatrix();
    for (Button c : r) {
      Button b = new Button(0, 0);
      translate(50, 0);
    }
    popMatrix();
    translate(0, 50);
  } 
  popMatrix();
}

void draw() {
  printData();
}

void printData(){
  for (Button[] a : grid){
     println(Arrays.toString(a));
  }
}

int newButtonX;
int newButtonY;

void mousePressed() {
  newButtonX = (mouseX/50)*50;
  newButtonY = (mouseY/50)*50;
  fill(#B7AFAF);
  rect(newButtonX, newButtonY, 50, 50);
}

void mouseReleased() {
  if ( newButtonX == (mouseX/50)*50 && newButtonY == (mouseY/50)*50 ) {
    fill(#1A18C9);
    rect(newButtonX, newButtonY, 50, 50);
  } else {
    fill(255);
    rect(newButtonX, newButtonY, 50, 50);
  }
}

