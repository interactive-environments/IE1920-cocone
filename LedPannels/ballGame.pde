

Ball balls[] = {new Ball(25), new Ball(25), new Ball(25), new Ball(25), new Ball(25), new Ball(25), new Ball(25)};

Level levels[] = {new Level(2,25,false,0),new Level(7,25,false,0),new Level(16,25,false,0),new Level(2,25,true,2),new Level(7,25,true,2)};

boolean MOVING_BALLS = true;
int BALLS = 7;
int BALL_RADIUS = 25;
int BALL_SPEED = 2;

boolean USE_LEVELS = true;
int LEVEL = 0;



void createBalls(int b, int r, boolean moving,int speed) {
  balls = new Ball [b];
  for (int i = 0; i < b ; i++) {
      balls[i] = new Ball(r,moving,speed);  
  }
}

void createBalls(Level level) {
  balls = new Ball [level.balls];
  for (int i = 0; i < level.balls ; i++) {
      balls[i] = new Ball(level.radius,level.moving,level.speed);  
  }
}

void ballSetup(){
  ellipseMode(RADIUS);
  if (USE_LEVELS) {
     LEVEL = 0;
     createBalls(levels[LEVEL]);
  } else {
    createBalls(BALLS,BALL_RADIUS,MOVING_BALLS,BALL_SPEED);  
  }
  
}

void nextLevel() {
   if (!USE_LEVELS) return;
   LEVEL++;
   
   if (LEVEL < levels.length){
     createBalls(levels[LEVEL]);
   } else {
     createBalls(int(random(16)),25,(random(1) > .5),int(random(4)));
   }
   
   
}

void ballDraw(){
  int count = 0;
  for (int i = 0; i < balls.length; i++){
    if (USE_LEVELS && balls[i].caught) {
      count++;
      continue;
    }
    if (touchPoints0.size() > 0 && touchPoints0.get(0).dist(balls[i].location) < balls[i].radius*2){
       balls[i].touched();
    }
    if (touchPoints1.size() > 0 && touchPoints1.get(0).dist(balls[i].location) < balls[i].radius*2){
       balls[i].touched();
    }
    if (touchPoints2.size() > 0 && touchPoints2.get(0).dist(balls[i].location) < balls[i].radius*2){
       balls[i].touched();
    }
    if (touchPoints3.size() > 0 && touchPoints3.get(0).dist(balls[i].location) < balls[i].radius*2){
       balls[i].touched();
    }
    if (touchPoints4.size() > 0 && touchPoints4.get(0).dist(balls[i].location) < balls[i].radius*2){
       balls[i].touched();
    }
    if (new PVector(mouseX, mouseY).dist(balls[i].location) < balls[i].radius+1){
       balls[i].touched();
    }
    balls[i].drawBall();
    if (balls[i].moving) {
      balls[i].move();
    }
  }
  if (count == balls.length) {
    nextLevel();
  }
}
class Ball{
  PVector location;
  PVector movement;
  boolean moving;
  float radius;
  color colour;
  float rand;
  int speed;
  boolean caught = false;
  
  Ball(float radius){
    
    float r = random(255);
    float g = random(255);
    float b = random(255);
    
    while (r+g+b < 255) {
      r = random(255);
      g = random(255);
      b = random(255);
    }
    
    
    this.colour = color(r, g, b);
    this.location = new PVector(random(900)+150, random(180)+30);
    this.radius = radius;
    this.rand = random(20);
    this.moving = false;
    this.movement = new PVector(0,0);
    this.speed = 0;
  }
  
  Ball(float radius, boolean moving, int speed) {
     this(radius);
     if (moving) {
        this.speed = speed;
        this.moving = true;
        this.movement = new PVector(random(-1 * this.speed,this.speed),random(-1 * this.speed,this.speed));
     }
  }
  
  void touched(){
    if (USE_LEVELS) {
      this.caught = true; 
    }
    this.location = new PVector(random(900)+150, random(180)+30);
    this.colour = getColor();
    this.rand = random(20);
    if (this.moving) {
        this.movement.set(random(-1 * this.speed,this.speed),random(-1 * this.speed,this.speed));
    }
  }
  
  void move() {
     if (!this.moving) return;
     this.location.add(this.movement);
     
     //OVER FLOW WRAP
     if (this.location.x > ledWidth) this.location.x = 0;
     if (this.location.x < 0) this.location.x = ledWidth;
     
     if (this.location.y > ledHeight) this.location.y = 0;
     if (this.location.y < 0) this.location.y = ledHeight;
  }
  
  void drawBall(){
    if (USE_LEVELS && this.caught) return;
    fill(this.colour);
    ellipse(location.x, location.y, radius+rand, radius+rand);
  }
  
  color getColor(){
    colorMode(HSB, 100);
    float hue = random(100);
    return color(hue, 255, 255);
  }
}

class Level {
  
  int balls,radius,speed;
  boolean moving;
  
  
  Level(int balls,int radius,boolean moving,int speed) {
    this.balls = balls;
    this.radius = radius;
    this.speed = speed;
    this.moving = moving;
  }
  
}
