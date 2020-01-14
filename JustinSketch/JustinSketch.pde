import org.openkinect.freenect.*;
import org.openkinect.processing.*;


OPC opc;
Kinect kinect;
PImage depthImg;
import org.processing.wiki.triangulate.*;
import java.util.Map;


int minDepth =  755;
int maxDepth = 875;
int mode = 1;
PVector[] vectors1 = {new PVector(71, 186), new PVector(78, 186), new PVector(95, 363), new PVector(102, 363)};
PVector[] vectors2 = {new PVector(192, 38), new PVector(195, 47), new PVector(72, 178), new PVector(79, 176)};
PVector[] vectors3 = {new PVector(197, 30), new PVector(382, 34), new PVector(197, 39), new PVector(384, 42)};
PVector[] vectors4 = {new PVector(388, 49), new PVector(395, 51), new PVector(486, 190), new PVector(494, 189)};
PVector[] vectors5 = {new PVector(485, 195), new PVector(495, 194), new PVector(497, 382), new PVector(505, 382)};
PVector[][] allVectors = {vectors1, vectors2, vectors3, vectors4, vectors5};
void setup(){
  size(1200, 240);
  if (mode == 1) airflowSetup();
  if (mode == 2) goldFishSetup();
  if (mode == 4) particleSetup();
  ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
  opc = new OPC(this, "127.0.0.1", 7890);
  kinect = new Kinect(this);
  kinect.initDepth();
  depthImg = new PImage(kinect.width, kinect.height);
  
  for (int j = 0; j < 5; j++){
    for(int i = 0; i < 5; i++){
      opc.ledStrip(i*64 + j*512, 16, width/6 + j*width/6, height/24 + height/12 + i*height/6, width/100, 0, true);
      opc.ledStrip(16+i*64 + j*512, 15, width/6 + j*width/6, height/24 + height/6 + i*height/6, width/100, 0, false);
    }
  }
  
}

void draw(){
  background(0);
  int[] rawDepth = kinect.getRawDepth();
  touchPoints0.clear();
  touchPoints1.clear();
  touchPoints2.clear();
  touchPoints3.clear();
  touchPoints4.clear();
  for (int i=0; i < rawDepth.length; i++) {
      int x = i % kinect.width;
      int y = i / kinect.width;
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      if (inBox(x, y, vectors1) || inBox(x, y, vectors2) || inBox(x, y, vectors3) || inBox(x, y, vectors4) || inBox(x, y, vectors5)){
        touch(x, y, rawDepth[i]);
      }
    }
  }
  if (mode == 1){
    if (touchPoints0.size() > 0) {
      airflowMouseDragged(touchPoints0.get(0), previous0);
      previous0 = touchPoints0.get(0);
    }
    if (touchPoints1.size() > 0) {
      airflowMouseDragged(touchPoints1.get(0), previous1);
      previous1 = touchPoints1.get(0);
    }
    if (touchPoints2.size() > 0) {
      airflowMouseDragged(touchPoints2.get(0), previous2);
      previous2 = touchPoints2.get(0);
    }
    if (touchPoints3.size() > 0) {
      airflowMouseDragged(touchPoints3.get(0), previous3);
      previous3 = touchPoints3.get(0);
    }
    if (touchPoints4.size() > 0) {
      airflowMouseDragged(touchPoints4.get(0), previous4);
      previous4 = touchPoints4.get(0);
    }
    //airflowMouseDragged(new PVector(mouseX, mouseY), previous0);
    //previous0 = new PVector(mouseX, mouseY);
    airflowDraw();
  } else if (mode == 2){
    if (touchPoints0.size() > 0) handDragged(touchPoints0.get(0).x, touchPoints0.get(0).y);
    if (touchPoints1.size() > 0) handDragged(touchPoints1.get(0).x, touchPoints1.get(0).y);
    if (touchPoints2.size() > 0) handDragged(touchPoints2.get(0).x, touchPoints2.get(0).y);
    if (touchPoints3.size() > 0) handDragged(touchPoints3.get(0).x, touchPoints3.get(0).y);
    if (touchPoints4.size() > 0) handDragged(touchPoints4.get(0).x, touchPoints3.get(0).y);
    
    goldFishDraw();
  } else if (mode == 3){
  } else if (mode == 4){
    particleDraw();
  }
  //push();
  //fill(255);
  //stroke(255);
  //if (touchPoints0.size() > 0) ellipse(touchPoints0.get(0).x, touchPoints0.get(0).y, 9, 9);
  //if (touchPoints1.size() > 0) ellipse(touchPoints1.get(0).x, touchPoints1.get(0).y, 9, 9);
  //if (touchPoints2.size() > 0) ellipse(touchPoints2.get(0).x, touchPoints2.get(0).y, 9, 9);
  //if (touchPoints3.size() > 0) ellipse(touchPoints3.get(0).x, touchPoints3.get(0).y, 9, 9);
  //pop();
}
PVector previous0 = new PVector(0, 0);
PVector previous1 = new PVector(0, 0);
PVector previous2 = new PVector(0, 0);
PVector previous3 = new PVector(0, 0);
PVector previous4 = new PVector(0, 0);
ArrayList<PVector> touchPoints0 = new ArrayList<PVector>();
ArrayList<PVector> touchPoints1 = new ArrayList<PVector>();
ArrayList<PVector> touchPoints2 = new ArrayList<PVector>();
ArrayList<PVector> touchPoints3 = new ArrayList<PVector>();
ArrayList<PVector> touchPoints4 = new ArrayList<PVector>();
void touch(int x, int y, int depth){
  //touchPoints.clear();
  for (int i = 0; i < 5; i++){
    if (inBox( x, y, allVectors[i])){
      float dist0 = 0;
      float dist1 = 0;
      switch(i){
        case 0:
          dist0 = allVectors[i][2].dist(new PVector(x, y));
          dist1 = allVectors[i][0].dist(new PVector(x, y));
        break;
        case 1:
          dist0 = allVectors[i][1].dist(new PVector(x, y));
          dist1 = allVectors[i][0].dist(new PVector(x, y));
        break;
        case 2:
          dist0 = allVectors[i][0].dist(new PVector(x, y));
          dist1 = allVectors[i][2].dist(new PVector(x, y));
        break;
        case 3:
          dist0 = allVectors[i][0].dist(new PVector(x, y));
          dist1 = allVectors[i][2].dist(new PVector(x, y));
        break;
        case 4:
          dist0 = allVectors[i][0].dist(new PVector(x, y));
          dist1 = allVectors[i][2].dist(new PVector(x, y));
        break;
      }
      float totalDist = dist0 + dist1;
      float xPercentage = dist0/totalDist;
      int finalX = width-int(xPercentage*width/6 + (4-i) * width/6)-width/12;
      int finalY = (depth-minDepth)*height/(maxDepth-minDepth);
      switch(i){
        case 0:
        touchPoints0.add(new PVector(finalX, finalY));
        break;
        case 1:
        touchPoints1.add(new PVector(finalX, finalY));
        break;
        case 2:
        touchPoints2.add(new PVector(finalX, finalY));
        break;
        case 3:
        touchPoints3.add(new PVector(finalX, finalY));
        break;
        case 4:
        touchPoints4.add(new PVector(finalX, finalY));
        break;
      }
    }
  }
}


boolean inBox(int x, int y, PVector[] vectors){
  PVector p1 = vectors[0].copy();
  PVector p2 = vectors[1].copy();
  PVector p3 = vectors[2].copy();
  PVector p4 = vectors[3].copy();
  PVector upperLine = new PVector(1, (p1.y - p2.y)/(p1.x - p2.x));
  PVector underLine = new PVector(1, (p3.y - p4.y)/(p3.x - p4.x));
  
  PVector rightLine = new PVector((p2.x - p4.x)/(p2.y - p4.y), 1);
  PVector leftLine = new PVector((p1.x - p3.x)/(p1.y - p3.y), 1);
  upperLine.mult((x - p1.x));
  underLine.mult((x - p4.x));
  rightLine.mult((y - p2.y));
  leftLine.mult((y-p3.y));
  p1.add(upperLine);
  p4.add(underLine);
  p2.add(rightLine);
  p3.add(leftLine);
  return (y > p1.y && y < p4.y && x < p2.x && x > p3.x);
}
