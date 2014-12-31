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
    xCor = 0;
    yCor = height/2;
    col = #B70F0F;
    type = "default";
  }
  
  void drawMe(){
    fill(col);
    rect(xCor,yCor,25,25);
  }
  
  void move(){ //IDEA: have a parameter to change speed 
    xCor += 1;
    drawMe();
  }
}


