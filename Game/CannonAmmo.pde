class CannonAmmo extends Ammo {

  /*------------------CONSTRUCTORS---------------*/
  CannonAmmo(float a, float b) { //create a default ammo with (a,b)=(towerXCor,towerYCor)
    super(a,b);
    atk = 20;
    col = #1B3904;
  }

  void drawMe() {
    fill(col);
    ellipse(xCor, yCor, 20, 10); //shape of ammo
  }

  void shoot() {
    xCor += 0.5;//speed
    drawMe();
  }
}





