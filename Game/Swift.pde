class Swift extends Mon {

  Swift() { //create a default monster
    Random rnd = new Random();
    xCor = width;
    yCor = (rnd.nextInt(numCellsCol) * cellSize) + (cellSize / 2);
    col = #E7E83F;
    type = "Swift";
    alive = true;
    health = 10;
    speed = 2.5;    
  } 

}

