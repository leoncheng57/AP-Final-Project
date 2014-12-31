class Ammo extends Tower {

  String toString() {
    String[] a = {
      "x: "+xCor, "y: "+yCor, "type: "+type
    };
    return Arrays.toString(a);
  }

  Ammo() { //create a default ammo
    col = #FFF300;
    type = "defaultAmmo";
  }

  void drawMe() {
    fill(col);
    ellipse(xCor, yCor, 25, 25);
  }

  void shoot() {
    xCor--;
    drawMe();
  }
}

