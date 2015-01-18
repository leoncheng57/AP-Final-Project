Time timeMonsters = new Time(1000); //delay of 1 second

void setup() {
  timeMonsters=new Time(1000);
}

void draw() {
  if (timeMonsters.canStart()) {
    println("hello");
  }

  if (timeMonsters.repeat()) {
    println("hel");
  }
}


/*
int time;
 int wait = 1000;
 
 void setup() {
 time = millis();//store the current time
 }
 void draw() {
 //check the difference between now and the previously stored time is greater than the wait interval
 if (millis() - time >= wait) {
 println("tick");//if it is, dor something
 time = millis();//also update the stored time
 println(millis());
 }
 }
 */

/*
int startTime = millis();
 int duration = 1000;
 
 void draw() {
 if (millis() - startTime >= duration) {
 println(millis());
 //startTime = millis();
 }
 }
 */


/*
int startTime = 1000;
 int duration = 1000;
 boolean isComplete;
 
 void draw() {
 if (!isComplete) {
 if (millis()-startTime>=duration) {
 println("tick");
 isComplete = true;
 }
 }
 }
 */
