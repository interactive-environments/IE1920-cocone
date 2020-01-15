void mousePressed(){
  food = addFoof(food,(float)mouseX,(float)mouseY);
  ripples = addRip(ripples,mouseX,mouseY);
}

void mouseDragged(){
  food = addFoof(food,(float)mouseX,(float)mouseY);
  if (random(20)<1){
    ripples = addRip(ripples,mouseX,mouseY);
  }
}

void handDragged(float x, float y){
  food = addFoof(food,(float)x,(float)y);
  if (random(20)<1){
    ripples = addRip(ripples,x,y);
  }
}
