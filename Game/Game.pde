import java.util.*;
import java.io.*;

Cell[][] Grid = new Cell[20][13];
int setWidth = 800; //manually set here
int setHeight = 500;
int cellSize = setHeight / 5;
ArrayList<Mon> mons = new ArrayList<Mon>();
ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Ammo> ammos = new ArrayList<Ammo>();

void setup() {
  size(setWidth, setHeight);
  rectMode(CENTER);
  makeGrid();
  monsPack1();
}

void makeGrid() {
  for (int col = 0; col<Grid.length; col++) {
    for (int row = 0; row<Grid[0].length; row++) {
      Grid[col][row] = new Cell(col, row);
    }
  }
}

void monsPack1() {
  Mon m1 = new Mon();
  m1.drawMe();
  mons.add(m1);
}

void draw() {
  background(#C9C3C3);
  drawOutline();
  moveMons();
  drawTowers();
  makeAmmo();
  shootAmmo();
  printData();
  hitMon();
}

void drawOutline() {
  if (mouseX >0 && mouseY > 0 && mouseX < width && mouseY <height) {
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

void moveMons() {
  for (int i = 0; i<mons.size (); i++) {
    mons.get(i).move();
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
  Tower tmp = new Tower();
  towers.add(tmp);
}

