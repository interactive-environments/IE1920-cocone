class gFish {
  
  v3 pos = new v3(random(ledWidth),random(ledHeight));
  float maxSpeed;
  float minSpeed;
  float speed;
  double angle = random(PI*2);
  double angleChange;
  double flex;
  float segLen = random(5)+3;
  float segSize = ((float)Math.pow(random(4),2)+10);
  float[] target = {1200,100};
  int foods = 0;
  double zag = 1;
  Knobs[] body;
  gFish(float _mxS, float _mnS, double _aC, float dp){
    maxSpeed = _mxS;
    minSpeed = _mnS;
    angleChange = _aC;
    body = new Knobs[(int)(random(8)+10)];
    for (int i = 0; i < body.length; i++){
      float percent = (float)i/(float)(body.length-1);
      float segBuff = (((float)(body.length-i)/(float)body.length)*segSize);
      float thisSize = (float)(Math.cos(percent*PI)*segLen)+segBuff;

      //float thisSize = (float)(Math.sin(((float)i/(float)body.length-1)*PI)*segLen)+10;
      //thisSize = 10;
      body[i] = new Knobs(thisSize,pos.x,pos.y,dp);
    }
  }
  
  void move(){
    switch (setTarget()){
      case (1) :
        PVector v1 = new PVector(sin((float)angle),cos((float)angle));
        PVector v2 = new PVector(target[0]-pos.x,target[1]-pos.y); 
        float xAngle = PVector.angleBetween(v1, v2);
        float targetSpeed = scaleAvg(maxSpeed,minSpeed,xAngle/PI);
        speed = scaleAvg(speed,targetSpeed,0.2);
        while (xAngle < 0){
          xAngle += PI * 2;  
        }
        while (xAngle > PI * 2){
          xAngle -= PI * 2;  
        }
        
        float xxAngle = (float)angle - xAngle;
        PVector vX = new PVector(sin((float)xxAngle),cos((float)xxAngle));
        if (PVector.angleBetween(vX, v2) > 0.01){
          xAngle *= -1;
        }
        /*
        stroke(0,255,255);
        line(pos.x,pos.y,target[0],target[1]);
        stroke(255);
        line(pos.x,pos.y,pos.x+(sin((float)angle)*100),pos.y+(cos((float)angle)*100));
        stroke(255,0,0);
        line(pos.x,pos.y,pos.x+(sin((float)xAngle)*100),pos.y+(cos((float)xAngle)*100));
        */
        angle += Math.max(-angleChange,Math.min(angleChange,-xAngle));
        
        
        break;
      case (0) :
         speed = scaleAvg(speed,minSpeed,0.01);
         break;
    }
    if (random(10)<1){
    	angle += random((float)0.25) * zag;
    	zag *= -1;
    }
    angle -= (Math.random()*angleChange)-(angleChange/2);
    while(angle < 0){
      angle += PI *2;
    }
    while (angle > PI * 2){
      angle -= PI *2;
    }
    if (random(100)<1)angle += random(-1,1);

    double xDist = Math.sin(angle);
    double yDist = Math.cos(angle);
    pos.x += xDist * speed;
    pos.y += yDist * speed;
    contain();
    body[0].move(pos.x,pos.y);
    for (int i = 1; i < body.length; i++){
      body[i].move(body[i-1].pos.x,body[i-1].pos.y);
    }
    if (random(3000)<1){
      ripples = addRip(ripples,pos.x,pos.y);
    }
    for (int k = 0; k < food.length; k++){
      if (dist(pos.x,pos.y,food[k].x,food[k].y)< 10 && !food[k].eaten){
            food[k].eaten = true;
            foods++;
            if (random(20)<1){
              ripples = addRip(ripples,pos.x,pos.y);  
            }
          }
    }

  }
  
  int setTarget(){
    int retV = 0;
    if (food.length >0){
      retV = 1;
      target[0] = food[0].x;
      target[1] = food[0].y;
      for (int i = 1; i < food.length; i ++){
        if(dist(pos.x,pos.y,target[0],target[1])>dist(pos.x,pos.y,food[i].x,food[i].y)){
          target[0] = food[i].x;
          target[1] = food[i].y;
          
        }
      }
    }
    return retV;
  }
  
  void display(){
    body[0].display();
    int finpos = (int)((float)body.length * 0.2);
    float finSize = Math.max(body.length,segSize);
    //rect(body[finpos].pos.x-(body.length/2),body[finpos].pos.y-(body.length/2),body.length,body.length);
    rect(body[finpos].pos.x-(finSize/2),body[finpos].pos.y-(finSize/2),finSize,finSize);
    for (Knobs kn : body){
      kn.display();
    }
    if (debug){
      fill(debugClr);
      text(foods,pos.x+15,pos.y+15);
    }
  }
  
  void contain(){
     switch(pos.contain()){
      
      case 1 :
        if (angle < PI *1.5 && angle > PI){
          angle -= angleChange;  
        } else if (angle > PI * 1.5){
          angle += angleChange;
        }
        break;
      case 2 :
        if (angle < PI && angle > PI/2){
          angle += angleChange;  
        } else if (angle < PI/2) {
        //}else{
          angle -= angleChange;
        }
        break;
      case 3 :
        if (angle < PI && angle > PI / 2){
          angle -= angleChange;  
        } else if (angle > PI && angle < PI * 1.5) {
          angle += angleChange;
        }
        break;
      case 4 :
        if (angle > PI * 1.5){
          angle -= angleChange;  
        } else if (angle < PI /2){
          angle += angleChange;  
        }
        break;
      case 5 :
       // angle = PI/2;
        break;
      case 6 :
      //  angle = PI * 1.5;
        break;
      case 7 :
      //  angle = 0;
        break;
      case 8 :
      //  angle = PI;
        break;
      default :
        //do nothing
        break;
    }  
    if (pos.x < body.length*-segLen){
      pos.x = ledWidth+(body.length*segLen);
    }
    if (pos.x > ledWidth+(body.length*segLen)){
      pos.x = -body.length*segLen;
    }
    if (pos.y < -body.length*segLen){
      pos.y = ledHeight + (body.length*segLen);
    }
    if (pos.y > ledHeight+ (body.length*segLen)){
      pos.y = -body.length*segLen;
    }
  }
  
  class Knobs{
    color clr;
    v3 pos;
    float sz;
    Knobs(){ 
      pos = new v3(0,0);
      sz = 0;
    }
    Knobs(float _sz, float x, float y, float dp){
      sz = _sz;
      pos = new v3(random(ledWidth),random(ledHeight));
      float myR = scaleAvg(bgR,225,dp);
      float myG = scaleAvg(bgG,random(100)+25,dp);
      float myB = scaleAvg(bgB,25,dp);
      clr =  color(myR,myG,myB);
    }
    void move(float x, float y){      
      float multi = (float)Math.sqrt(Math.pow(pos.x-x,2)+Math.pow(pos.y-y,2))/segLen;
      pos.x = x + ((pos.x-x)/multi);
      pos.y = y + ((pos.y-y)/multi); 
    }
    
    void display(){
      noStroke();
      fill(clr);
      ellipse(pos.x,pos.y,sz,sz);   
      //fill(255,255,100);
      //ellipse(pos.x-(sz/4),pos.y,sz/2,sz/2);
    }    
  }
}
