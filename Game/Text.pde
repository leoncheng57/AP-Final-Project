class Text {
  int fontSize;
  String msg;
  color col;
  float xCor, yCor;

  //ISSUE: need a better way to handle the positions of texts
  Text(String s, float x, float y) {
    msg = s;
    fontSize = 16;
    xCor = x;
    yCor = y;
    col = 255;
  }

  void drawMe() {
    textFont(f, fontSize);
    fill(col);
    text(msg, xCor, yCor);
  }
}

