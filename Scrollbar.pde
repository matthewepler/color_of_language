class Scrollbar{
  
  int x,y;
  float sw,sh;
  float pos;
  float posMin, posMax;
  boolean rollover;
  boolean locked;
  float minVal, maxVal;
  
  Scrollbar (int xp, int yp, int w, int h, float miv, float mav) {
    x = xp;
    y = yp;
    sw = w;
    sh = h;
    minVal = miv;
    maxVal = mav;
    pos = x + sw/2 - sh/2;
    posMin = x;
    posMax = x + sw - sh;
  }
  
  void update(int mx, int my){ 
    if(over(mx,my) == true) {
      rollover = true;
    } else {
      rollover = false;
    }
    if (locked == true) {
      pos = constrain(mx-sh/2, posMin, posMax);
    }
  }
  
  void press(int mx, int my) {
    if (rollover == true) {
      locked = true;
    } else {
      locked = false;
    }
  }
  
  void release() {
    locked = false;
  }
  
  boolean over(int mx, int my) {
    if((mx > x) && (mx < x+sw) && (my > y) && (my < y+sh)){
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    fill(255);
    rect(x,y,sw,sh);
    if ((rollover == true) || (locked == true)){
      fill(0);
    } else {
      fill(102);
    }
    rect(pos, y, sh, sh);
  }
  
  float getPos() {
    float scalar = sw/(sw-sh);
    float ration = (pos - x) + scalar;
    float offset = minVal + (ration/sw * (maxVal-minVal));
    return offset;
  }
}
