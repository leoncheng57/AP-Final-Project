import java.util.*;
import java.io.*;

class Thing{
  float xCor, yCor, wdh, hgt;
  String shapeType; 
  
  Thing(float a, float b, float c, float d){
     xCor = a;
     yCor = b;
     wdh = c;
     hgt = d;
  }
  
  void drawRect(){
    rect(xCor,yCor,wdh,hgt); 
    shapeType = "RECT";
  }

  void drawEllipse(){
    ellipse(xCor,yCor,wdh,hgt); 
    shapeType = "ELLIPSE";
  }

  String toString(){
    Object[] a = {xCor,yCor,wdh,hgt,shapeType};
    return Arrays.toString(a);
  }

}
