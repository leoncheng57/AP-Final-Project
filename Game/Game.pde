import java.util.*;
import java.io.*;

ArrayList<Mon> mons = new ArrayList<Mon>();
ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Ammo> ammos = new ArrayList<Ammo>();

void setup() {
  size(1000, 500);
  rectMode(CENTER);
  monsPack1();
}

void monsPack1() {
  Mon m1 = new Mon();
  m1.drawMe();
  mons.add(m1);
}

void draw() {
  makeStage();
  moveMons();
  drawTowers();
  makeAmmo();
  shootAmmo();
  printData();
  hitMon();
}

void makeStage() {
  fill(#0E6414);
  rect(width/2, 50, width, 100); //IDEA: get a pic of a strip of grass to insert instead of green rects
  pushMatrix();
  for (int i=0; i<4; i++) {
    translate(0, 100);
    rect(width/2, 50, width, 100);
  }
  popMatrix();
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
        rect(a.xCor,a.yCor,range*2,range*2); //allows develops to see the range of the ammo
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

