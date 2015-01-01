class Ammo {
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
  Ammo(float a, float b) { //create a default ammo with (a,b)=(towerXCor,towerYCor)
    xCor = a;
    yCor = b;
    col = #FA0B03;
    type = "defaultAmmo";
  }

 void drawMe(){
   fill(col);
   ellipse(xCor,yCor,20,10); 
 }
 
 void shoot(){
   xCor += 1;
   drawMe();
 }

}
