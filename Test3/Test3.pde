ArrayList<Mon> mons = new ArrayList<Mon>();

void setup() {
  size(500, 500);
  rectMode(CENTER);
  //frameRate(10);
  Mon m1 = new Mon();
  m1.drawMe();
  mons.add(m1);
}

void draw() {
  background(10);
  fill(255);
  rect(width/2,height/2,width,50);
  
  Thing two = new Thing(mouseX, mouseY, 20, 20);
  two.drawEllipse();

  for (int i = 0; i<mons.size();i++){
    mons.get(i).move();
  }
  
  printData();
}

void printData(){
  for (int i=0;i<mons.size();i++){
    println(mons.get(i)); 
  }
}
