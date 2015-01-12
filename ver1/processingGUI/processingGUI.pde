/* To be used with https://processing.org/
NIRpixel GUI is designed to be used with NIRpixel firmware on a Launchpad and receive measurements from serial port.
Displays the specified number of measurements in a grid with color-coded cell color and measurement value inside.

Copyright Institute IRNAS Rače 2014 - info@irnas.eu

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

import processing.serial.*;
 
Serial myPort;

// divide screen in virtual pixels
int rows=3;
int cols=3;
int xPos = 1; // horizontal position counter
 
void setup () {
  // set the window size:
  size(800, 800);        
   
  // List all the available serial ports
  println(Serial.list());
  // chose serial port
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.clear();
  myPort.bufferUntil('\n'); 
  // set inital background:
  background(0);
}

void draw () {
 // everything happens in the serialEvent()
}
 
void serialEvent (Serial myPort) {
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
   // trim off any whitespace:
   inString = trim(inString);
   
   //parse numbers
   float[] nums = float(split(inString, ' '));

   // set up colors
   // HSB mode for encoding amplitude
   colorMode(HSB,100,100,100);
   textSize(32);
  
   //process eaxh pixel
    for(char r=0;r<rows;r++){
      for(char c=0;c<cols;c++){
        //create color based on value
        //mapping the colors, set the maximum to value you expect to be max
        float color_var = map(nums[r*rows+c], 0, 1000, 75, 0);
        stroke(color_var,100,100);
        
        //set the fill color
        fill(color_var,100,100);
        //draw square
        rect((width/cols)*c, (height/rows)*r, width/cols, height/rows);
        //set text color
        fill(0, 0, 100);
        //draw texr
        text(nums[r*rows+c], (width/cols)*c+100, (height/rows)*r+50);
      }
    }
  }    
}
