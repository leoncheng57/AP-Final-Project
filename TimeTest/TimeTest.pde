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

ArrayList<Time> times = new ArrayList<Time>();

void setup() {
  Time t = new Time(1000);
}

void draw() {
  for (Time t : times) {
    println(t.lateStart());
  }
}

class Time {

  float startTime, duration;

  Time(float duration) {
    startTime = millis();
    this.duration = duration;
  }

  boolean lateStart() {
    if (millis() - startTime >= duration) {
      return true;
    } else
      return false;
  }
}

