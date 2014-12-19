

import processing.video.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
Robot robot;
boolean mouse = false;

Capture video;
// Previous Frame
PImage prevFrame;
// How different must a pixel be to be a "motion" pixel
float threshold = 120;
int pox = 0;
int speed = 10;
int mousex = 0;
int current_x = 0;



void setup() {
  
   try { 
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
  }       
  
  size(320,240);
  video = new Capture(this, width, height, 40);
  prevFrame = createImage(video.width,video.height,RGB);
  video. start();
  
}

void draw() {
        int sumx = 0;
        int countx = 0;
        

  if (video.available()) {
    prevFrame.copy(video,0,0,video.width,video.height,0,0,video.width,video.height); // Before we read the new frame, we always save the previous frame for comparison!
    prevFrame.updatePixels();
    video.read();
    
  }
  
  loadPixels();
  
  video.loadPixels();
  prevFrame.loadPixels();
 
  

  for (int x = 0; x < video.width; x ++) {
  for (int y = 0; y < video.height; y ++ ) {

      
      //int loc = (width-1-x) + y*video.width;  
      int loc = x + y*video.width;        
      color current = video.pixels[loc];      
      color previous = prevFrame.pixels[loc]; 
      
  
      float r1 = red(current); float g1 = green(current); float b1 = blue(current);
      float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
      float diff = dist(r1,g1,b1,r2,g2,b2);
     
      if (diff > threshold) { 
 
        pixels[loc] = color(20);
          if(abs(pox-x)<500){
              countx = countx+1;
              sumx = sumx + x;
          }
              
              
        
        
      } else 
      {
        pixels[loc] = color(255);
      }
      
    }
  }

  
  updatePixels();
  
   if (countx > 20){ 
     pox = (sumx / countx);
    
    ellipse(width/2,10,10,10);
    mouse = true;
    //print("|",sumx,"_",countx,"|");
  }
  
  else{mouse = false;}
  ellipse(pox,height/2,10,10);
  line(width/2, 0, width/2,height);
  
  if (mouse) {
            //robot.keyPress(KeyEvent.VK_SPACE); //fire spacebar event
            //robot.keyRelease(KeyEvent.VK_SPACE);
    
         int ratio = (displayWidth/(width-170));
          mousex = ((width - pox)*ratio)-300;
         
         
   
        }
       
       if(abs(current_x-mousex)<20){
       //speed = 0;
         }
       
       
       else if(current_x<mousex){
         
        robot.mouseMove ((current_x),(displayHeight/2));
          current_x = current_x+speed; 
          speed = abs(current_x-mousex)/8;
          
       }
       else if(current_x>mousex){
        
        robot.mouseMove ((current_x),(displayHeight/2));
          current_x = current_x-speed; 
         speed = abs(current_x-mousex)/8;
       }
       
       

  
}

