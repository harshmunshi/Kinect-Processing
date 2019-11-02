// Let us import mandatory libraries


import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

// currently we do not need world coordinates, we can work with raw pixel values.

void setup(){
  // Rendering 3D
  size(800, 600, P3D);
  kinect = new Kinect(this);
  kinect.initDepth();
}

void draw(){
 
    background(0,0,255);
    // read the depth stream
    int[] depth = kinect.getRawDepth();
    
    // make a sample circle and do nothing
    
    
    // read the depth, convert it to meters and check for number of pixels in some range
    int skip = 4;
    int pixelSum = 0;
    for (int x = 0; x < kinect.width; x+=skip){
      for (int y =0; y < kinect.height; y+=skip){
        int offset =  x + y*kinect.width;
        int rawDepth = depth[offset];
        if (rawDepth > 900 && rawDepth <2047){
           pixelSum += 1;
        }
        
      }
    }
    
    // check for pixel sum
    // it can be 0 or 2047, so let's have a min of 20, 20 + 200*(pixelSum/2048)
    float c_x = 20 + 50*(float(pixelSum)/2048.0);
    //println(c_x);
    ellipse(400,300,int(c_x),int(c_x));
    fill(255,0,0);
}
