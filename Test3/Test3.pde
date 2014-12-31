ArrayList<Thing> stills = new ArrayList<Thing>();

void setup() {
  size(500, 500);
  rectMode(CENTER);
  ellipseMode(CENTER);
  //frameRate(10);
  for (int i = 0; i<10; i++) {
    Thing tmp = new Thing(random(width), random(height), 50, 50);
    stills.add(tmp);
  }
}

void draw() {
  background(10);

  Thing one = new Thing(width/2, height/2, 20, 20);
  stills.add(one);

  Thing two = new Thing(mouseX, mouseY, 20, 20);
  two.drawEllipse();

  for (int i = 0; i<stills.size(); i++) {
    stills.get(i).drawRect();
  }

  /*
  if (frameCount / 10 == 10) {
   println(stills);
   exit();
   }
   */
}

