class Delay {

  float startTime, duration;
  boolean isDone;
  int count;

  Delay(float duration) {
    startTime = millis();
    this.duration = duration;
  }
  
  
  Delay(float duration, int count) {
    this.startTime = millis();
    this.duration = duration;
    this.count = count;
  }

  boolean begin() {
    if (!isDone && millis()-startTime>=duration) {
      isDone = true;
      return true;
    } else {
      return false;
    }
  }

  boolean repeat() {
    if (millis()-startTime>=duration) {
      startTime = millis(); //reset the startTime to the current time
      return true;
    } else {
      return false;
    }
  }

  boolean repeat (int countLimit) {
    if (this.count<countLimit && millis()-startTime>=duration) {
      startTime = millis(); //reset the startTime to the current time
      countLimit++;
      return true;
    } else {
      return false;
    }
  }
}

