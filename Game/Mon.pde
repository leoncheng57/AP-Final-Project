class Mon {

  float xCor, yCor, health;
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
    yCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
    col = #B70F0F;
    type = "defaultMon";
    alive = true;
    health = 20;
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

  void hit(float atk) {
    
    health = health - atk;

    if (health <= 0 ) { 
      alive = false; 

    }
  }
}

