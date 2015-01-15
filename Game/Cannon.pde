class Cannon extends Tower {

  /*------------------CONSTRUCTORS---------------*/
  Cannon() { //create a default tower
    xCor = ((mouseX / cellSize) * cellSize) + (cellSize/2);
    yCor = ((mouseY / cellSize) * cellSize) + (cellSize/2);
    col = #31A512;
    type = "Cannon";
    cost = 20;
  }


  CannonAmmo createAmmo() { //specific to every tower type
    CannonAmmo a = new CannonAmmo(xCor, yCor); 
    return a;
  }
}

