class Button {
  
  int x,y,w,h,radius,mode;
  color borderC,fillC;
  String text;
  boolean active = false;
  
   Button(int x, int y, int w, int h, int radius, color borderC, color fillC, String text, int mode) {
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     this.radius = radius;
     this.borderC = borderC;
     this.fillC = fillC;
     this.text = text;
     this.mode = mode;
   }
   
   void draw() {
    push();
    translate(this.x,this.y);
    fill(this.fillC);
    stroke(this.borderC);
    if (this.active) {
      fill(this.borderC);
      stroke(this.fillC);
    }
    rect(0,0,this.w,this.h,this.radius);
    textSize(32);
    textAlign(CENTER, CENTER);
    textFont(kaiZenFont);
    fill(this.borderC);
    if (this.active) {
     fill(this.fillC); 
    }
    text(text,this.w/2,this.h/2 - 5);
    pop();
   }
   
   boolean onClick(int x, int y) {
     println("Button: " + this.text);
     println("With:");
     println("X1: "+ this.x+ " X2: "+ (this.x+this.w));
     println("Y1: "+ this.y+ " Y2: "+ (this.y+this.h));
     if (!this.active && (x >= this.x && x <= this.x+this.w) && (y >= this.y && y <= this.y+this.h)) {
       println("pressed: True");
       selectSketch(this.mode);
       return true;
     }
     println("pressed: False");
     return false;
   }
}
