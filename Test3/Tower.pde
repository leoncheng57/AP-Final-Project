class Tower {
  float xCor, yCor;
  String type;
  color col;

  String toString() {
    String[] a = {
      "x: "+xCor, "y: "+yCor, "type: "+type
    };
    return Arrays.toString(a);
  }

  /*------------------CONSTRUCTORS---------------*/
  Tower() { //create a default tower
    xCor = mouseX;
    yCor = mouseY;
    col = #000EFF;
    type = "defaultTower";
  }
  
  void drawMe(){
    fill(col);
    rect(xCor,yCor,25,25); 
  }
  
  void shoot(){
     Ammo a = new Ammo();
     a.shoot();
  }
  
}

