class Cell{
  int x;
  int y;
  //below 2 lines may be incorporated later
  //boolean isPath = false;
  //Tower occcupant = null;
  
  Cell(int a, int b){
    x = a;
    y = b; 
  }
  
  void outlineMe(){
    noFill();
    stroke(#00FF00);
    rect(x * cellSize, y * cellSize, cellSize, cellSize); 
    stroke(0);
  }
}
