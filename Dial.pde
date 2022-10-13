class Dial implements GUIObject {
  float x, y, rv, r, ir;
  float th, tw, tn, mxs, mys, mx, my;
  boolean touched;
  int tid;

  Dial (float xin, float yin, float irin, 
    float thin, float twin, float tnin) {
    x = xin;
    y = yin;
    ir = irin;
    th = thin;
    tw = twin;
    tn = tnin;
    rv = 0;
  }

  void draw () {
    pushMatrix();
    translate(x, y);
    rotate(r);
    float angle = atan2(-ir, 0)-atan2(-ir, tw); 
    beginShape(QUAD_STRIP); 
    for (float a = 0; a < tn; a ++) { 
      float sx = cos(angle*a) * ir; 
      float sy = sin(angle*a) * ir; 
      vertex(sx, sy);
      sx = cos(angle*a) * (ir+th); 
      sy = sin(angle*a) * (ir+th); 
      vertex(sx, sy);
    }
    endShape(CLOSE);
    popMatrix();
  }

  void update () {
    /*if (rv <= radians(5) && rv >= radians(-5)) {
     rv = 0;
     } else {
     r += rv;
     rv *= 0.9;
     }*/
    r += abs(rv)<PI/490?0:rv*PI*PI;
    if (!touched) {
      /*if (abs(rv) <= PI/500) {
        float angle = atan2(-ir, 0)-atan2(-ir, tw);
        r=round(r/angle)*angle;
        //rv*=0.5;
      } else */{
        rv*=0.97;
      }
    } else {
      rv = atan2(my-y, mx-x) - atan2(mys-y, mxs-x);
      if (abs(rv) <= PI/1000) {
        float angle = atan2(-ir, 0)-atan2(-ir, tw);
        r=round(r/angle)*angle;
        //rv*=0.9;
      }
    }
  }

  void touchStart () {
    float tx = touches[touches.length-1].x;
    float ty = touches[touches.length-1].y;
    float d = dist(x, y, tx, ty);
    if (!touched) {
      if (d < ir + tw && d >= ir) {
        touched = true;
        mx = tx;
        my = ty;
        tid = touches[touches.length-1].id;
        mxs = mx;
        mys = my;
      }
    }
  }

  void touchMove () {
    if (touched) {
      for (TouchEvent.Pointer t : touches) {
        if (t.id == tid) {
          //println("match");
          mxs=mx;
          mys=my;
          mx=t.x;
          my=t.y;
          break;
        }
      }
    }
  }

  void touchEnd () {
    /*if (touched) {
     int idx=-1;
     for (int i=0; i<touches.length; i++ ) {
     if (touches[i].id==tid) {
     idx=i;
     break;
     }
     }
     if (idx==-1) {
     touched=false;
     mx=0;
     my=0;
     mxs=0;
     mys=0;
     tid=0;
     update();
     return;
     }
     }*/
    touched=false;
  }
}
