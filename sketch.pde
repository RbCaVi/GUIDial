Dial d;

void setup () {
  size (800, 800);
  d = new Dial (width/2, height/2, width*1/4, 80, 
   80, 10);
}

void draw () {
  background(0);
  d.update();
  d.draw();
  for (TouchEvent.Pointer t: touches) {
    ellipse(t.x,t.y,40,40);
  }
}

void touchStarted () {
  d.touchStart();
}

void touchMoved () {
  d.touchMove();
}

void touchEnded () {
  d.touchEnd();
}
