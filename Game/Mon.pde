class Mon {
 
  float xCor, yCor;
  String type;
  color col;
  boolean alive;

  String toString() {
    String[] a = {
      "x: "+xCor, "y: "+yCor, "type: "+type
    };
    return Arrays.toString(a);
  }

  /*------------------CONSTRUCTORS---------------*/
  Mon() { //create a default monster
   Random rnd = new Random();
    xCor = width;
    yCor = (rnd.nextInt(numCellsHeight) * cellSize) + (cellSize / 2);
    col = #B70F0F;
    type = "defaultMon";
    alive = true;
  } 

  void drawMe() {
    fill(col);
    ellipse(xCor, yCor, 25, 25);
  }

  void move() { 
    if (alive) {
      xCor -= 2;
      drawMe();
    }
  }

  void die(){
    alive = false; 
    fill(#A2A2A7);
    rect(xCor,yCor,25,25);
    //ISSUE: this seems like  a crude/bad way to remove/kill the mon/object
    
  }

}
