class Foof{
  
  boolean eaten = false;
  float opac = 255;
  float x, y;
  float velX = random(-0.05,0.05);
  float velY = random(-0.05,0.05);
  Foof(float _x, float _y){
    x=_x;
    y=_y;
  }
  void move(){
    x+= velX;
    y+= velY;
    if (x<0||x>width||y<0||y>height){
      eaten = true;
    }
  }
  void display(){
    noStroke();
    fill(210,190,110,255);
    ellipse(x,y,8,8);
    opac *= 0.99;
    if (opac < 5){
      eaten = true;
    }
  }
}

Foof[] addFoof(Foof[] f, float _x, float _y){
  Foof[] newF = new Foof[f.length+1];
  for(int i = 0; i < f.length; i++){
    newF[i] = f[i];
  }
  newF[newF.length-1] = new Foof(_x,_y);
  return newF;
}

Foof[] cleanFoof(Foof[] f){
  int live = 0;
  for (Foof fF : f){
    if (!fF.eaten){
      live++;
    }
  }
  int count = 0;
  Foof[] survivingFoof = new Foof[live];
  for (Foof fF : f){
    if (!fF.eaten){
      survivingFoof[count]=fF;
      count++;
    }
  }
  return survivingFoof;
}
