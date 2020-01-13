int frame = 0;
gFish[] gF = new gFish[24];
Foof[] food = new Foof[0];
Ripple[] ripples = new Ripple[0];
float bgR = 20;
float bgG = 90;
float bgB = 70;
Pad[] pd = new Pad[0];
boolean debug = false;
color debugClr = color(0,127,255);

void goldFishSetup() {
  for (int i = 0; i < gF.length; i++){
    gF[i] = new gFish((random(1)+1),1,0.05,random(0.8, 1));
  }
  for (int i = 0; i < pd.length; i++){
    pd[i] = new Pad();
  }
}

void goldFishDraw() {
  frame++;
  background(0);
  food = cleanFoof(food);
  for (int j = 0; j < food.length; j++){
    food[j].move();
    food[j].display();
  }
  for (int i = 0; i < gF.length; i++){
    gF[i].move();
    gF[i].display();
  }
  for (Ripple rp : ripples){
    rp.move();
    rp.display();
  }
  ripples = cleanRipple(ripples);
  for (Pad pp : pd){
    pp.move();
    pp.shadow();
  }
  for (Pad pp : pd){
    pp.display();
  }
}
