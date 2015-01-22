import java.util.*;
import java.io.*;

int setWidth = 800; 
int setHeight = 600;
int numCellsCol = 5; 
int numCellsRow = 6;
int cellSize = 100;
PFont font;
int initFrameRate = (int)frameRate; //ISSUE: this doesn't represent one second for some reason
char currentTowerType = '1';
int score =0;
int money= 50;
int towerCost = 10;//for defaultMon
int lives = 3;
int level = 1;//to be used to generate monsters propotional to your progress //ISSUE: may not be neccesary
int killCount = 0;
Random rnd = new Random();//to be used when generating monsters //ISSUE: this may be unnecessary
//Delay delayMonsPacks=new Delay(1000);


Cell[][] grid = new Cell[numCellsRow][numCellsCol];
Text[] texts = new Text[6];
ArrayList<Mon> mons = new ArrayList<Mon>();
ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Ammo> ammos = new ArrayList<Ammo>();

void setup() {
  size(setWidth, setHeight);
  rectMode(CENTER);
  makeFont();
  makeGrid();
  setupMessages();
}

void makeFont() {
  font = createFont("Arial", 16);
  //  see the fonts already installed onto the system
  //  String[] fontList = PFont.list();
  //  println(fontList);
}

void makeGrid() {
  for (int col = 0; col<grid.length; col++) {
    for (int row = 0; row<grid[0].length; row++) {
      grid[col][row] = new Cell(col, row);
    }
  }
}

void setupMessages() {
  changeText("Your level: "+level, 0);
  changeText("Your score: "+score, 1);
  changeText("Money left: "+money, 2);
  changeText("Lives left: "+lives, 4);
  changeText("Monsters Killed: "+killCount, 5);
}

void draw() {
  background(#012489);
  drawOutline();
  drawTowers();
  makeAmmo();
  moveAmmo();
  moveMons();
  hitMon();
  graveDigger();
  loseLife();
  loseGame();
  drawTextBox();
  drawText();
  monsPacks() ;///ISSUE ... needs control
  //printData();
  //  if (delayMonsPacks.repeat(2)) {
  //    println("YAY");
  //  }
}

void drawTextBox() {
  rectMode(CORNER);
  fill(0);
  rect(0, cellSize*numCellsCol, width, height-cellSize*numCellsCol);
  rectMode(CENTER);
}

void drawText() {
  textFont(font, 16);
  fill(255);
  for (Text tx : texts) {
    if (tx != null) {
      tx.drawMe();
    }
  }
}

void changeText(String s, int line) {
  texts[line] = new Text(s, line);
}

void drawOutline() {
  if (mouseX >0 && mouseY > 0 && mouseX < cellSize*grid.length && mouseY < cellSize*grid[0].length) {
    int x = mouseX / cellSize;
    int y = mouseY / cellSize;
    grid[x][y].outlineMe();
  }
}

//ISSUE: this method doesn't have a great purpose
void printData() {
  if (frameCount % 60 == 0) {
    for (int i=0; i<mons.size (); i++) {
      println(mons.get(i));
    }
  }
}

void loseLife() {
  int passedMons=0;
  for (Mon m : mons) {
    if (m.xCor<0) {
      passedMons++;
    }
  }
  lives = 3-passedMons; //3 is the initial num of lives
  changeText("Lives left: "+lives, 4);
}

void loseGame() {
  if (lives <=0) {
    noLoop();  //ISSUE: losing screen to be put here later on
    //losing screen
    background(0);//sets everyting to black
    changeText("YOU LOST !!!!!!!!", 4);
  }
}

/*--------------------------------------------------------------*/
/*------------------------TOWERS--------------------------------*/
/*--------------------------------------------------------------*/

//makes a specfic tower, press a key to specify the type
void mousePressed() {
  if (canDrawTower()) {
    if (currentTowerType == '1') {
      Tower tmp = new Tower() ;
      checkUpgrade(tmp);
      towerCost = tmp.cost;
      towers.add(tmp);
    }
    if (currentTowerType == '2') {
      Cannon tmp = new Cannon();
      checkUpgrade(tmp);
      towerCost = tmp.cost;
      towers.add(tmp);
    }
    money = money - towerCost;
    changeText("Money left: "+money, 2);
  }
}

void drawTowers() {
  for (int i =0; i<towers.size (); i++) {
    towers.get(i).drawMe();
  }
}

void checkUpgrade(Tower newT) {
  for (Tower oldT : towers) {
    if (newT.xCor == oldT.xCor && newT.yCor == oldT.yCor) {
      changeText("You just upgraded a tower at "+int(newT.xCor/cellSize + .5)+","+int(newT.yCor/cellSize + .5) +"!!", 3);
    }
  }
}

boolean canDrawTower() {
  //x and y coors of the corner of a Cell box
  float xCor = ((mouseX / cellSize) * cellSize) + (cellSize/2);
  float yCor = ((mouseY / cellSize) * cellSize) + (cellSize/2);
  //to make sure it is inside the user window size
  if (mouseX < cellSize*grid.length && mouseY < cellSize*grid[0].length) {
    //to make sure user has enough money
    if (money>=towerCost) { //money gets subtracted in mousePressed()   
      return true;
    }
  }  
  return false;
}

/*--------------------------------------------------------------*/
/*------------------------AMMO--------------------------------*/
/*--------------------------------------------------------------*/

//create ammo every 60 frames
void makeAmmo() {
  for (int i =0; i<towers.size (); i++) {
    if (frameCount % 60 == 0) {
      Tower t = towers.get(i);
      ammos.add(t.createAmmo());
    }
  }
}

void moveAmmo() {
  for (int i =0; i<ammos.size (); i++) {
    ammos.get(i).move();
  }
}


/*--------------------------------------------------------------*/
/*------------------------MONSTERS------------------------------*/
/*--------------------------------------------------------------*/


//sees if the ammo hit the Mon, and remoevs the Ammo from arraylist ammos
void hitMon() {
  float range = 10; //this will be the range of the ammo (how far from mon to be accepted as a hit)
  for (Mon m : mons) {
    for (int i = 0; i<ammos.size (); i++) {
      Ammo a = ammos.get(i); 
      if (abs(a.xCor - m.xCor) < range  && abs(a.yCor - m.yCor) < range) {
        fill(#E31010);
        ellipse(a.xCor, a.yCor, 50, 50); //explosion animation
        //rect(a.xCor, a.yCor, range*2, range*2); //allows developers to see the range of the ammo
        m.hit(a.atk);
        ammos.remove(i);
      }
    }
  }
}


//removes dead mons from the arraylist mons
void graveDigger() {
  for (int i = 0; i < mons.size (); i++) {
    if (mons.get(i).alive == false) {
      changeText(mons.get(i).type+" killed!", 0);
      killCount++;
      changeText("Monsters killed: "+killCount, 5);
      mons.remove(i);
      i--;
      score += 100;
      money += 5;
      changeText("Your score: "+score, 1);
      changeText("Money left: "+money, 2);
    }
  }
}

void moveMons() {
  for (int i = 0; i<mons.size (); i++) {
    mons.get(i).move();
  }
}


/*--------------------------------------------------------------*/
/*------------------------MONSTER PACKS-------------------------*/
/*--------------------------------------------------------------*/

void keyPressed() {
  if (key=='z') {
    monsPack4();
  }  
  if (key=='x') {
    monsPack5();
  }
  if (key=='c') {
    monsPack6();
  }
  if (key =='1' || key == '2') {
    currentTowerType = key;
  }
}

void monsPack1() { 
  if (2*initFrameRate == frameCount) { //ISSUE: good idea to use initFrameRate?
    Mon m1 = new Mon();
    m1.drawMe();
    mons.add(m1);
  }
}


//ISSUE: needs fixing
void monsPack2() {
  float delay =  0.5;
  float releaseTime = 1;
  if (3*initFrameRate == frameCount) {
    Mon m1 = new Mon();
    m1.drawMe();
    mons.add(m1);
  } 
  if (5*initFrameRate == frameCount) {
    Mon m1 = new Mon();
    m1.drawMe();
    mons.add(m1);
  } 
  if (8*initFrameRate == frameCount) {
    Mon m1 = new Mon();
    m1.drawMe();
    mons.add(m1);
  } 



  /*  
   for (int i=0; i<5; i++) {
   if (releaseTime == frameCount) {
   Mon m = new Mon();
   m.drawMe();
   mons.add(m);
   println(releaseTime);
   }
   releaseTime+=delay;
   //    println("frameC: "+frameCount);      
   }
   println(frameCount);
   */

  //Began working on a way to prevent overlapping of mons
  //  for(Mon m : mons) {
  //   if (m.yCo 
  //  }
}

void monsPack3() {
  if (2*initFrameRate == frameCount) {
    Tank tk = new Tank();
    tk.drawMe();
    mons.add(tk);
  }
}

void monsPack4() {
  Mon m = new Mon();
  m.drawMe();
  mons.add(m);
}

void monsPack5() { 
  Tank tk = new Tank();
  tk.drawMe();
  mons.add(tk);
}
 
void monsPack6() {
   Swift sw = new Swift();
   sw.drawMe();
   mons.add(sw); 
}
void monsPacks() {
  int tries = 0;
  if (rnd.nextInt(500) <= level) {//this could keep changing, since level changes
    if (rnd.nextInt(2) ==0) {
      monsPack5();
    } else {
      monsPack4() ;
      monsPack6();
    }
    tries ++;
  }
  level = int(score / 1000)+1;//make a game both hard and doable, and infinite
  changeText("Your level: "+level, 0);
}

