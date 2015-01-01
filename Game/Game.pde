ArrayList<Mon> mons = new ArrayList<Mon>();
ArrayList<Tower> towers = new ArrayList<Tower>();

void setup() {
  size(500, 500);
  rectMode(CENTER);

  //create a sample monster
  Mon m1 = new Mon();
  m1.drawMe();
  mons.add(m1);
}

void draw() {
  background(10);

  //Setup Stage
  fill(#0E6414);
  rect(width/2, 50, width, 100);
  pushMatrix();
  for (int i=0; i<4; i++) {
    translate(0, 100);
    rect(width/2, 50, width, 100);
  }
  popMatrix();
  
  //create a sample ellipse that follows mouse
  Thing two = new Thing(mouseX, mouseY, 20, 20);
  two.drawEllipse();

  //have the monster move along the path
  for (int i = 0; i<mons.size (); i++) {
    mons.get(i).move();
  }

  //draw towers
  for (int i =0; i<towers.size (); i++) {
    towers.get(i).drawMe();
  }

  printData();
}

void printData() {
  if (frameCount % 60 == 0) {
    for (int i=0; i<mons.size (); i++) {
      println(mons.get(i));
    }
  }
}

void mousePressed() {
  Tower tmp = new Tower();
  towers.add(tmp);
}

