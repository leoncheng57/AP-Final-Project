class Cannon extends Tower {
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
    xCor = ((mouseX / cellSize) * cellSize) + (cellSize/2);
    yCor = ((mouseY / cellSize) * cellSize) + (cellSize/2);
    col = #31A512;
    type = "Cannon";
  }
  
  
  void drawMe(){
    fill(col);
    rect(xCor,yCor,cellSize,cellSize); 
  }
  

  
}
 
 
