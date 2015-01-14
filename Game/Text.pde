class Text {
  int fontSize;
  String msg;
  color col;
  float xCor, yCor;

  Text(String s, int line) { //the text type will correspond to its index in the array texts, and the line in the textBox that it will be shown in
    msg = s;
    fontSize = 16;
    xCor = 0;
    yCor = cellSize*numCellsCol + 16 + (16*line);
    col = 255;
  }

  Text(String s, float x, float y) {
    msg = s;
    fontSize = 16;
    xCor = x;
    yCor = y;
    col = 255;
  }
  
  String toString() {
    String[] a = {
      "x: "+xCor, "y: "+yCor, "msg: "+msg
    };
    return Arrays.toString(a);
  }

  void drawMe() {
    textFont(font, fontSize);
    fill(col);
    text(msg, xCor, yCor);
  }
}

