class Button {
  int xCor, yCor;
  color col;


  Button (int a, int b) {
    xCor = a;
    yCor = b;
    col = 255;
    fill(col);
    rect(a, b, 50, 50);
  }

  String toString() {
    String ret = "";
    ret+= xCor + "," + yCor + "," + col; 
    return ret;
  }
}

