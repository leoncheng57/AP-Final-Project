class Time {

  float startTime, duration;
  boolean isComplete;

  Time(float duration) {
    startTime = millis();
    this.duration = duration;
  }

  boolean canStart() {
    if (!isComplete && millis() - startTime >= duration) {
      isComplete = true;
      return true;
    } else
      return false;
  }

  boolean repeat() {
    if (millis() - startTime >= duration) {
      startTime = millis();
      return true;
    } else
      return false;
  }
}

