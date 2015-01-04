class Cell{
  int col, row;
  //below 2 lines may be incorporated later
  //boolean isPath = false;
  //Tower occcupant = null;
  
  Cell(int a, int b){
    col = a;
    row = b; 
  }
  
  void outlineMe(){
    noFill();
    stroke(#00FF00);
    rectMode(CORNER);
    rect(col * cellSize, row * cellSize, cellSize, cellSize); 
    rectMode(CENTER);
    stroke(0);
  }
}
