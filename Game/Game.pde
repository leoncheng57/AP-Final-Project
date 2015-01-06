import java.util.*;
import java.io.*;

int setWidth = 850; 
int setHeight = 550;
int numCellsCol = 5; 
int numCellsRow = 6;
int cellSize = 100;

Cell[][] Grid = new Cell[numCellsRow][numCellsCol];
ArrayList<Mon> mons = new ArrayList<Mon>();
ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Ammo> ammos = new ArrayList<Ammo>();

void setup() {
  size(setWidth, setHeight);
  rectMode(CENTER);
  makeGrid();
  monsPack2();
}

void makeGrid() {
  for (int col = 0; col<Grid.length; col++) {
    for (int row = 0; row<Grid[0].length; row++) {
      Grid[col][row] = new Cell(col, row);
    }
  }
}


//ISSUE: Mons packs should probably be in the draw fxn and activated by a "timer"
void monsPack1() {
  Mon m1 = new Mon();
  m1.drawMe();
  mons.add(m1);
}

void monsPack2() {
  for (int i=0; i<5; i++) {
    Mon m = new Mon();
    m.drawMe();
    mons.add(m);
  }
  //  for(Mon m : mons) {
  //   if (m.yCo 
  //  }
}

void draw() {
  background(#012489);
  drawOutline();
  drawTowers();
  makeAmmo();
  shootAmmo();
  printData();
  moveMons();
  hitMon();
  graveDigger();
  loseGame();
}

void drawOutline() {
  if (mouseX >0 && mouseY > 0 && mouseX < cellSize*Grid.length && mouseY < cellSize*Grid[0].length) {
    int x = mouseX / cellSize;
    int y = mouseY / cellSize;
    Grid[x][y].outlineMe();
  }
}

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
      Ammo a = new Ammo(t.xCor, t.yCor); //make get functions the x and y coors
      ammos.add(a);
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
      mons.remove(i);
      println("monster removed");
    }
  }
}

void moveMons() {
  for (int i = 0; i<mons.size (); i++) {
    mons.get(i).move();
  }
}

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

//sees if the ammo hit the Mon
void hitMon() {
  float range = 10; //this will be the range of the ammo (how far from mon to be accepted as a hit)
  for (Ammo a : ammos) {
    for (Mon m : mons) {
      if (abs(a.xCor - m.xCor) < range  && abs(a.yCor - m.yCor) < range) {
        println("HIT!!");
        fill(#D809D5);
        rect(a.xCor, a.yCor, range*2, range*2); //allows developers to see the range of the ammo
        m.die();
      }
    }
  }
}

void mousePressed() {
  //add a tower at the position where the mouse is pressed
  if (mouseX < cellSize*Grid.length && mouseY < cellSize*Grid[0].length) {
    Tower tmp = new Tower();
    towers.add(tmp);
  }
}

