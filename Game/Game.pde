import java.util.*;
import java.io.*;

int setWidth = 800; 
int setHeight = 600;
int numCellsCol = 5; 
int numCellsRow = 6;
int cellSize = 100;
PFont font;
char currentTowerType = 'z'; //start with default tower
int score =0;
int money= 50;
int towerCost = 10;
int initialNumOfLives=3;
int lives = initialNumOfLives;
int level = 1;//to be used to generate monsters propotional to your progress
int killCount = 0;
Random rnd = new Random();//to be used when generating monsters
String didCheat = "";//changes only when sandbox features are used


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
  upgradeTowers();
  makeAmmo();
  moveAmmo();
  moveMons();
  hitMon();
  graveDigger();
  loseLife();
  loseGame();
  drawTextBox();
  drawText();
  monsPacks() ;
  printData();
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

void printData() {
  if (frameCount % 60 == 0) {
    for (Mon m : mons) {
      print(m);
    }
    println();
    for (Tower t : towers) {
      print(t);
    }
    println();
  }
}

void loseLife() {
  int passedMons=0;
  for (Mon m : mons) {
    if (m.xCor<0) {
      passedMons++;
    }
  }
  lives = initialNumOfLives-passedMons; 
  changeText("Lives left: "+lives, 4);
}

void loseGame() {
  if (lives <=0) {
    noLoop();
    background(0);//sets everyting to black
    textAlign(CENTER, CENTER);
    float midX = width / 2;
    float midY = height/2;
    float deltaY = texts[0].fontSize;
    text("You reached level "+level, midX, midY-(2*deltaY));
    text("You had a score of "+score, midX, midY-(1*deltaY));
    text("Money left: "+money, midX, midY-(0*deltaY));
    text("You killed "+killCount+" monsters", midX, midY-(-1*deltaY)); 
    text(didCheat, midX, midY-(-2*deltaY));
    textAlign(LEFT);
  }
}


/*--------------------------------------------------------------*/
/*------------------------TOWERS--------------------------------*/
/*--------------------------------------------------------------*/

//makes a specfic tower, press a key to specify the type
void mousePressed() {
  if (canDrawTower()) {
    if (currentTowerType == 'z') {
      Tower tmp = new Tower() ;
      checkUpgrade(tmp);
      towerCost = tmp.cost;
      towers.add(tmp);
    }
    if (currentTowerType == 'x') {
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

void upgradeTowers() {
  for (Tower thisTower : towers) {
    int count = 0;
    for (Tower otherTower : towers) {
      if (thisTower.xCor==otherTower.xCor && thisTower.yCor==otherTower.yCor) {
        count++;
      }
    }
    thisTower.upgradeCount=count;
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
/*--------------MONSTER PACKS and SANDBOX-----------------------*/
/*--------------------------------------------------------------*/

void keyPressed() {
  if (key=='1') {
    monsPack1();
  }  
  if (key=='2') {
    monsPack2();
  }
  if (key=='3') {
    monsPack3();
  }
  if (key =='z' || key == 'x') {
    currentTowerType = key;
  }
  if (key=='b') {
    score = score+100;
    changeText("Your score: "+score, 1);
    didCheat = "...but YOU are a CHEATER";
  }
  if (key =='m') {
    money = money + 10;
    changeText("Money left: "+money, 2);
    didCheat = "...but YOU are a CHEATER";
  }
  if (key == 'n') {
    initialNumOfLives= initialNumOfLives + 1 ;
    changeText("Lives left: "+lives, 4);
    didCheat = "...but YOU are a CHEATER";
  }
}

void monsPack1() {
  Mon m = new Mon();
  m.drawMe();
  mons.add(m);
}

void monsPack2() { 
  Tank tk = new Tank();
  tk.drawMe();
  mons.add(tk);
}

void monsPack3() {
  Swift sw = new Swift();
  sw.drawMe();
  mons.add(sw);
}

void monsPacks() {
  int tries = 0;
  if (rnd.nextInt(500) <= level) {//as level increases, the chances of releasing a mon increase
    if (rnd.nextInt(2) ==0) {
      monsPack2();
    } else {
      monsPack1(); 
      monsPack3();
    }
    tries ++;
  }
  level = int(score / 1000)+1; 
  changeText("Your level: "+level, 0);
}

