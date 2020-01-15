class Ripple{
  float x;
  float y;
  float circ = 6;
  float opac = 100;
  Ripple(float _x, float _y){
    x = _x;
    y = _y;
  }
  void move(){
    circ++;
    opac --;
  }
  void display(){
    noFill();
    strokeWeight(4);
    stroke(255,opac);
    ellipse(x,y,circ,circ);
    stroke(bgR,bgG,bgB,opac);
    ellipse(x,y,circ-1,circ-1);
  }
}
  
Ripple[] addRip(Ripple[] f, float _x, float _y){
  Ripple[] newF = new Ripple[f.length+1];
  for(int i = 0; i < f.length; i++){
    newF[i] = f[i];
  }
  newF[newF.length-1] = new Ripple(_x,_y);
  return newF;
}

Ripple[] cleanRipple(Ripple[] rpl){
  int live = 0;
  for (Ripple fF : rpl){
    if (fF.opac >0){
      live++;
    }
  }
  int count = 0;
  Ripple[] survivingFoof = new Ripple[live];
  for (Ripple fF : rpl){
    if (fF.opac >0){
      survivingFoof[count]=fF;
      count++;
    }
  }
  return survivingFoof;
}