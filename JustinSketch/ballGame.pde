Ball balls[] = {new Ball(25), new Ball(25), new Ball(25)};
void ballSetup(){
  ellipseMode(RADIUS);
  
  
}

void ballDraw(){
  for (int i = 0; i < balls.length; i++){
    if (touchPoints0.size() > 0 && touchPoints0.get(0).dist(balls[i].location) < balls[i].radius+1){
       balls[i].touched();
    }
    if (touchPoints1.size() > 0 && touchPoints1.get(0).dist(balls[i].location) < balls[i].radius+1){
       balls[i].touched();
    }
    if (touchPoints2.size() > 0 && touchPoints2.get(0).dist(balls[i].location) < balls[i].radius+1){
       balls[i].touched();
    }
    if (touchPoints3.size() > 0 && touchPoints3.get(0).dist(balls[i].location) < balls[i].radius+1){
       balls[i].touched();
    }
    if (touchPoints4.size() > 0 && touchPoints4.get(0).dist(balls[i].location) < balls[i].radius+1){
       balls[i].touched();
    }
    if (new PVector(mouseX, mouseY).dist(balls[i].location) < balls[i].radius+1){
       balls[i].touched();
    }
    balls[i].drawBall();
  }
}
class Ball{
  PVector location;
  float radius;
  color colour;
  Ball(float radius){
    this.colour = color(255.2, 1, 1);
    this.location = new PVector(random(900)+150, random(180)+30);
    this.radius = radius;
  }
  
  void touched(){
    this.location = new PVector(random(900)+150, random(180)+30);
    this.colour = getColor();
  }
  
  void drawBall(){
    fill(this.colour);
    ellipse(location.x, location.y, radius, radius);
  }
  color getColor(){
    colorMode(HSB, 100);
    float hue = frameCount % 100;
    return color(hue, 255, 255);
  }
}
