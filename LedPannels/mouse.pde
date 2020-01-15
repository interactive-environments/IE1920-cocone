void mousePressed(){
  
  println("MOUSE: ");
  println("X: " + mouseX, " Y: " + mouseY);
  for (Button b : buttons) {
     if (b.onClick(mouseX,mouseY)) {
       for (Button but : buttons) {
          but.active = false; 
       }
       b.active = true;
       break;
     }
  }
  
  
  mouseX = mouseX-ledX;
  mouseY=mouseY-ledY;
  if(mode==2 && mouseX < ledWidth && mouseY < ledHeight){
  food = addFoof(food,(float)mouseX,(float)mouseY);
  ripples = addRip(ripples,mouseX,mouseY);
  }
}

void mouseDragged(){
  mouseX = mouseX-ledX;
  mouseY=mouseY-ledY;
  if(mode==2 && mouseX < ledWidth && mouseY < ledHeight){
  food = addFoof(food,(float)mouseX,(float)mouseY);
  if (random(20)<1){
    ripples = addRip(ripples,mouseX,mouseY);
  }
  }
  if (mode == 1){
    push();
    airflowMouseDragged(new PVector(mouseX, mouseY), new PVector(pmouseX, pmouseY));
    pop();
  }
}

void handDragged(float x, float y){
  if(mode==2){
  food = addFoof(food,(float)x,(float)y);
  if (random(20)<1){
    ripples = addRip(ripples,x,y);
  }
  }
}
