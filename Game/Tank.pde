class Tank extends Mon {

  Tank() {
    Random rnd = new Random();
    xCor = width;
    yCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
    col = #146721;
    type = "Tank";
    alive = true;
    health = 80;
    speed = 1.2;    
  } 

}

