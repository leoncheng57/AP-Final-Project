import java.util.*;
import java.io.*;

int setWidth = 800; 
int setHeight = 600;
int numCellsCol = 5; 
int numCellsRow = 6;
int cellSize = 100;
PFont f;
int initFrameRate = (int)frameRate; //ISSUE: this doesn't represent one second for some reason

Cell[][] Grid = new Cell[numCellsRow][numCellsCol];
ArrayList<Mon> mons = new ArrayList<Mon>();
ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Ammo> ammos = new ArrayList<Ammo>();
String msg = "";

void setup() {
  size(setWidth, setHeight);
  rectMode(CENTER);
  makeFont();
  makeGrid();
}

void makeFont() {
  f = createFont("Arial", 16);
  //  see the fonts already installed onto the system
  //  String[] fontList = PFont.list();
  //  println(fontList);
}

void makeGrid() {
  for (int col = 0; col<Grid.length; col++) {
    for (int row = 0; row<Grid[0].length; row++) {
      Grid[col][row] = new Cell(col, row);
    }
  }
}


void draw() {
  background(#012489);
  drawOutline();
  drawTowers();
  makeAmmo();
  shootAmmo();
  //printData();
  moveMons();
  hitMon();
  graveDigger();
  drawMsgBox();
  drawText();
  loseGame();
}


void drawText() {
  textFont(f, 16);
  fill(255);
  text(msg, 0, cellSize*numCellsCol + 16);
  println(msg);
}

void drawMsgBox() {
  rectMode(CORNER);
  fill(0);
  rect(0, cellSize*numCellsCol, width, height-cellSize*numCellsCol);
  rectMode(CENTER);
}

void drawOutline() {
  if (mouseX >0 && mouseY > 0 && mouseX < cellSize*Grid.length && mouseY < cellSize*Grid[0].length) {
    int x = mouseX / cellSize;
    int y = mouseY / cellSize;
    Grid[x][y].outlineMe();
  }
}

//ISSUE: this method doesn't have a great purpose
void printData() {
  if (frameCount % 60 == 0) {
    for (int i=0; i<mons.size (); i++) {
      println(mons.get(i));
    }
  }
}

void drawTowers() {
  for (int i =0; i<towers.size (); i++) {
    towers.get(i).drawMe();
  }
}

//create ammo every 60 frames
void makeAmmo() {
  for (int i =0; i<towers.size (); i++) {
    if (frameCount % 60 == 0) {
      Tower t = towers.get(i);
      ammos.add(t.createAmmo());
    }
  }
}

void shootAmmo() {
  for (int i =0; i<ammos.size (); i++) {
    ammos.get(i).shoot();
  }
}

//removes dead mons from the arraylist mons
void graveDigger() {
  for (int i = 0; i < mons.size (); i++) {
    if (mons.get(i).alive == false) {
      println("monster removed!");
      msg = "monster removed!";
      mons.remove(i);
      i--;
    }
  }
}

void moveMons() {
  for (int i = 0; i<mons.size (); i++) {
    mons.get(i).move();
  }
}

//ISSUE: needs improving
//IDEA: make an lose screen that stays there instead of exiting right away
void loseGame() { 
  for (Mon m : mons) {
    if (m.xCor<0) {
      background(0);
      println("YOU LOSE THE GAME!");
      noLoop();
    }
  }
}

//sees if the ammo hit the Mon, and remoevs the Ammo from arraylist ammos
void hitMon() {
  float range = 10; //this will be the range of the ammo (how far from mon to be accepted as a hit)
  for (Mon m : mons) {
    for (int i = 0; i<ammos.size (); i++) {
      Ammo a = ammos.get(i); 
      if (abs(a.xCor - m.xCor) < range  && abs(a.yCor - m.yCor) < range) {
        println("HIT!!");
        fill(#E31010zz);
        ellipse(a.xCor,a.yCor,50,50); //explosion animation
        //rect(a.xCor, a.yCor, range*2, range*2); //allows developers to see the range of the ammo
        m.hit(a.atk);
        ammos.remove(i);
      }
    }
  }
}


//creates specfic towers
//press a key to specify the type
void mousePressed() {
  //add a tower at the position where the mouse is pressed
  if (mouseX < cellSize*Grid.length && mouseY < cellSize*Grid[0].length) {
    if (key == '1') {
      Tower tmp = new Tower() ;
      towers.add(tmp);
    }
    if (key == '2') {
      Cannon tmp = new Cannon();
      towers.add(tmp);
    }
  }
}



/*-----------------------MONSTER PACKS-----------------------------*/
void monsPack1() { 
  if (2*initFrameRate == frameCount) { //ISSUE: good idea to use initFrameRate?
    Mon m1 = new Mon();
    m1.drawMe();
    mons.add(m1);
  }
}


//ISSUE: needs fixing
void monsPack2() {
  float delay =  0.5;
  float releaseTime = 1;
  if (3*initFrameRate == frameCount) {
    Mon m1 = new Mon();
    m1.drawMe();
    mons.add(m1);
  } 
  if (5*initFrameRate == frameCount) {
    Mon m1 = new Mon();
    m1.drawMe();
    mons.add(m1);
  } 
  if (8*initFrameRate == frameCount) {
    Mon m1 = new Mon();
    m1.drawMe();
    mons.add(m1);
  } 



  /*  
   for (int i=0; i<5; i++) {
   if (releaseTime == frameCount) {
   Mon m = new Mon();
   m.drawMe();
   mons.add(m);
   println(releaseTime);
   }
   releaseTime+=delay;
   //    println("frameC: "+frameCount);      
   }
   println(frameCount);
   */

  //Began working on a way to prevent overlapping of mons
  //  for(Mon m : mons) {
  //   if (m.yCo 
  //  }
}

void monsPack3() {
  if (2*initFrameRate == frameCount) {
    Tank tk = new Tank();
    tk.drawMe();
    mons.add(tk);
  }
}


void keyPressed() {
  if (key=='z') {
    monsPack4();
  }  
  if (key=='x') {
    monsPack5();
  }
}


void monsPack4() {
  Mon m = new Mon();
  m.drawMe();
  mons.add(m);
}

void monsPack5() { 
  Tank tk = new Tank();
  tk.drawMe();
  mons.add(tk);
}

