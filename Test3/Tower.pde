class Tower {
  float xCor, yCor;
  String type;
  color col;
  
  String toString(){
    String[] a = {"x: "+xCor, "y: "+yCor, "type: "+type};
    return Arrays.toString(a);
  }

  /*------------------CONSTRUCTORS---------------*/
  Tower(){ //create a default tower
    xCor = 0;
    yCor = height/2;
    col = #000EFF;
    type = "defaultTower";
  }
  
  void mousePressed(){
    fill(col);
    rect(xCor,yCor,25,25);
  }
  
}


