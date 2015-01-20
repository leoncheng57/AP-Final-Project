class Tower {
  float xCor, yCor;
  String type;
  color col;
  int cost;
  int upgradeCount; 

  String toString() {
    String[] a = {
      "x: "+xCor, "y: "+yCor, "type: "+type
    };
    return Arrays.toString(a);
  }

  /*------------------CONSTRUCTORS---------------*/
  Tower() { //create a default tower
    xCor = ((mouseX / cellSize) * cellSize) + (cellSize/2);
    yCor = ((mouseY / cellSize) * cellSize) + (cellSize/2);
    col = #31A512;
    type = "defaultTower";
    cost = 10;
  }


  void drawMe() {
    fill(col);
    rect(xCor, yCor, cellSize, cellSize);
  }

  Ammo createAmmo() { //specific to every tower type
    Ammo a = new Ammo(xCor, yCor); 
    a.upgradeMe();   
    return a;
  }
}

