import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

PVector vertices[], vertices2[];
int pts = 40; 
float angle = 0;
float radius = 20.0;

// lathe segments
int segments = 60;
float latheAngle = 0;
float latheRadius = 50.0;

float x,y,z;
float i;
void setup() {
  size(1280,960,P3D);
  background(0);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  lights();
  stroke(255);
  noFill();
}

void draw() {
  
  background(0);
  //translate(0, 0, 0);
  opencv.loadImage(video);
  image(video, 0, 0 );
  Rectangle[] faces = opencv.detect();
  for (int i = 0; i < faces.length; i++) {
    stroke(255);
    strokeWeight(1);
    noFill();
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    // first translate to required position and make the room
    pushMatrix();
    noFill();
    translate(width/2, height/2, 0);
    float angleval = (width/2-faces[i].x*4)/float(width/2) * 0.9;
    float angleValY = (height/2-faces[i].y*4)/float(height/2)*0.1;
    println(angleValY);
    rotateY(angleval);
    rotateX(angleValY);
    box(600);
    popMatrix();
    
    pushMatrix();
    translate(width/2-200, height/2, -200);
    rotateY(angleval);
    rotateX(angleValY);
    strokeWeight(2);
    line(0, 0,0 , 0, 0, -250);
    noStroke();
    fill(150, 195, 125);
    vertices = new PVector[pts+1];
    vertices2 = new PVector[pts+1];
      for(int j=0; j<=pts; j++){
    vertices[j] = new PVector();
    vertices2[j] = new PVector();
    vertices[j].x = latheRadius + sin(radians(angle))*radius;
      vertices[j].z = cos(radians(angle))*radius;
    angle+=360.0/pts;
  }
  // draw
    latheAngle = 0;
  for(int k=0; k<=segments; k++){
    beginShape(QUAD_STRIP);
    for(int l=0; l<=pts; l++){
      if (k>0){
        vertex(vertices2[l].x, vertices2[l].y, vertices2[l].z);
      }
      vertices2[l].x = cos(radians(latheAngle))*vertices[l].x;
      vertices2[l].y = sin(radians(latheAngle))*vertices[l].x;
      vertices2[l].z = vertices[l].z;
      vertex(vertices2[l].x, vertices2[l].y, vertices2[l].z);
    }
      latheAngle+=360.0/segments;
    
    endShape();
  }
    popMatrix();
    
    pushMatrix();
    // Make a cuboid at some other depth
    int obstaclesize = 150;
    translate(width/2 + 150, height/2+100, 0);
    rotateY(angleval);
    rotateX(angleValY);
    stroke(255);
    strokeWeight(2);
    line(0, 0,0 , 0, 0, -500);
    noStroke();
    fill(0,255,0);
    box(obstaclesize);
    popMatrix();
    
  }
}

void captureEvent(Capture c) {
  c.read();
}
