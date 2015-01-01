class Mon {
  float xCor, yCor;
  String type;
  color col;
  
  String toString(){
    String[] a = {"x: "+xCor, "y: "+yCor, "type: "+type};
    return Arrays.toString(a);
  }

  /*------------------CONSTRUCTORS---------------*/
  Mon(){ //create a default monster
    xCor = width;
    yCor = height/2;
    col = #B70F0F;
    type = "defaultMon";
  }
  
  void drawMe(){
    fill(col);
    ellipse(xCor,yCor,25,25);
  }
  
  void move(){ 
    xCor -= 1;
    drawMe();
  }
}


