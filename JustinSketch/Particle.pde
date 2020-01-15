import org.processing.wiki.triangulate.*;
import java.util.Map;

ArrayList triangles = new ArrayList();
int maxLevel = 5;
ArrayList<Particle> allParticles = new ArrayList<Particle>();

void particleSetup() {
  textAlign(CENTER);
  background(0);
  
  colorMode(RGB);
  //smooth();
  //noLoop();
 
  //// fill the points Vector with points from a spiral
  //float r = 1.0;
  //float rv = 1.01;
  //float a = 0.0;
  //float av = 0.3;
 
  //while(r < min(ledWidth,ledHeight)/2.0) {
  //  points.add(new PVector(ledWidth/2 + r*cos(a), ledHeight/2 + r*sin(a), 0));
  //  a += av;
  //  r *= rv;
  //}
 
  //// get the triangulated mesh
  //triangles = Triangulate.triangulate(points);
}
 
void particleDraw() {
  background(0);
  noStroke();
  fill(0, 30);
  rect(0, 0, ledWidth, ledHeight);
  ArrayList points = new ArrayList();
  allParticles.add(new Particle(mouseX, mouseY, maxLevel));
  if (touchPoints0.size() > 0) allParticles.add(new Particle(touchPoints0.get(0).x, touchPoints0.get(0).y, maxLevel));
  if (touchPoints1.size() > 0) allParticles.add(new Particle(touchPoints1.get(0).x, touchPoints1.get(0).y, maxLevel));
  if (touchPoints2.size() > 0) allParticles.add(new Particle(touchPoints2.get(0).x, touchPoints2.get(0).y, maxLevel));
  if (touchPoints3.size() > 0) allParticles.add(new Particle(touchPoints3.get(0).x, touchPoints3.get(0).y, maxLevel));
  if (touchPoints4.size() > 0) allParticles.add(new Particle(touchPoints4.get(0).x, touchPoints4.get(0).y, maxLevel));
    
  HashMap<PVector,Integer> hm = new HashMap<PVector,Integer>();
  for (int i = allParticles.size()-1; i > -1; i--){
    allParticles.get(i).move();
    
    if (allParticles.get(i).vel.mag() < 0.01){
      allParticles.remove(i);
    } else {
      PVector p = new PVector(allParticles.get(i).pos.x, +allParticles.get(i).pos.y);
      points.add(p);
      hm.put(p, allParticles.get(i).life);
    }
    
  }
  
  if (allParticles.size() > 0){
    triangles = Triangulate.triangulate(points); // TODO
  
    for (int i = 0; i < triangles.size(); i++) {
      Triangle t = (Triangle)triangles.get(i);
      
      int distThresh = 25;
        if (dist(t.p1.x, t.p1.y, t.p2.x, t.p2.y) > distThresh) {
          continue;
        }
        
        if (dist(t.p2.x, t.p2.y, t.p3.x, t.p3.y) > distThresh) {
          continue;
        }
        
        if (dist(t.p1.x, t.p1.y, t.p3.x, t.p3.y) > distThresh) {
          continue;
        }
       push();
       colorMode(HSB, 360);
       noStroke();
       fill(165+max(hm.get(t.p1), max(hm.get(t.p2), hm.get(t.p3)))*1.5, 360, 360); // Fix the Life thing
       triangle(t.p1.x, t.p1.y,
                t.p2.x, t.p2.y,
                t.p3.x, t.p3.y);
       pop();
    }
  }
}

public class Particle{
  int level;
  PVector pos;
  PVector vel;
  int life = 0;
  public Particle(float x, float y, int level){
    this.level = level;
    this.pos = new PVector(x, y);
    this.vel = PVector.random2D();
    this.vel.mult(map(this.level, 0, maxLevel, 5, 2));
  }
  public void move(){
    this.life++;
    this.vel.mult(0.9);
    this.pos.add(this.vel);
    if (this.life % 30 == 0){
      if (this.level > 0){
        this.level--;
        Particle p = new Particle(this.pos.x, this.pos.y, this.level-1);
        allParticles.add(p);
      }
    }
  }
}
