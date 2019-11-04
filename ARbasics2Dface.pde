import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
Rectangle[] faces;

float x,y,z;
float i;
void setup() {
  size(1280,960,P3D);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  background(0);
  lights();
  stroke(255);
  noFill();
  video.start();
}

void draw() {
  
  background(0);
  opencv.loadImage(video);
  image(video, 0, 0 );
  delay(300);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    translate(width/2, height/2, 0);
    float angleval = (width/2-faces[0].x*4)/float(width/2) * 0.2;
    float angleValY = (height/2-faces[0].y*4)/float(height/2)*0.1;
    rotateY(angleval);
    rotateX(angleValY);
    box(500);
  }
}

void captureEvent(Capture c) {
  c.read();
}
