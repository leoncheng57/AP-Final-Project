class Tank extends Mon {

  Tank() { //create a default monster
    Random rnd = new Random();
    xCor = width;
    yCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
    col = #146721;
    type = "Tank";
    alive = true;
    health = 80;
    
  } 

  void move() { 
    if (alive) {
      xCor -= 1.2;
      drawMe();
    }
  }
}

