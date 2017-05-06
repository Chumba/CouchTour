import processing.video.*;
import signal.library.*;
import controlP5.*; 

ControlP5 controlP5;             //Define the variable controlP5 as a ControlP5 type.
DropdownList filters;              //Define the variable ports as a Dropdownlist.

int filterMode = 0;
Movie myMovie;
PImage frame;
SignalFilter myFilter;
int[] hist = new int[256];

// Main OneEuroFilter parameters
float minCutoff = 0.02; // decrease this to get rid of slow speed jitter
float beta      = 2.0;  // increase this to get rid of high speed lag
float alpha     = 0.5; 
public void setup() {
  size(1280, 460);
  myMovie = new Movie(this, "smallPhish.mov");
  myMovie.loop();
  myMovie.volume(0);
  myFilter = new SignalFilter(this);
 // Pass the parameters to the filter
  myFilter.setMinCutoff(minCutoff);
  myFilter.setBeta(beta); 
  
//  controlP5 = new ControlP5(this);
  //Make a dropdown list calle ports. Lets explain the values: ("name", left margin, top margin, width, height (84 here since the boxes have a height of 20, and theres 1 px between each item so 4 items (or scroll bar).
//  filters = controlP5.addDropdownList("list-1",10,25,100,84);
  //Setup the dropdownlist by using a function. This is more pratical if you have several list that needs the same settings.
//  customize(filters); 
}
 
public void draw() {  
  colorMode(RGB, 255, 255, 255);
  hist = resetArray(hist);
  fill(150);
  rect(640, 0, 640, 460);
  if(frame!=null){
    image(myMovie, 0, 0, 640, 360);

    // Generate hue histogram
    for (int i = 0; i < frame.width; i++) {
      for (int j = 0; j < frame.height; j++) {
        // Only consider pixels brighter than 100
        int b = PApplet.parseInt(brightness(get(i,j)));
        if(b > 100 && b < 230){
          int bright = PApplet.parseInt(hue(get(i, j)));
          hist[bright]++;
        }         
      }
    }
    
    // filter the histogram
    if(zeroArray(hist)){
      hist = smoothHist(hist);
    }   
    
    // Find the largest value in the histogram
    // and its index
    int histMax = max(hist);
    int indexOfHistMax = 0;
    for(int i = 0; i<hist.length;i++){
      if(hist[i]==histMax) indexOfHistMax = i;
    }
    
       
    int beta = 3;
    int[] topColors = new int[beta];
    int[] cHist = new int[hist.length];
    arrayCopy(hist, cHist);
    topColors = getTopColors2(cHist, beta);
    topColors[0] = indexOfHistMax;
    for(int i = 0; i < topColors.length; i++)
    {
      // draw color box
      colorMode(HSB, 256, 100, 100);
      fill(topColors[i], 100, 100); 
      rect(0+(640/topColors.length)*i, 360, 640/topColors.length, 100);       
    }
    
    //draw histogram
    for (int i = 0; i < frame.width; i += 1) {
      // Map i (from 0..img.width) to a location in the histogram (0..255)
      int which = PApplet.parseInt(map(i, 0, frame.width, 0, 255));
      // Convert the histogram value to a location between 
      // the bottom and the top of the picture
      int y = PApplet.parseInt(map(hist[which], 0, histMax, frame.height, 0));
      line(i+640, frame.height, i+640, y);
      fill(which, 100, 100);
      ellipse(i+640, y, 10, 10);
      
      if(contains(i, topColors)){
        // Circle histogram data we chose
        stroke(2);
        fill(which, 100, 100);
        ellipse(i+640, y, 10, 10);
        line(i+640, frame.height, i+640, y);
        stroke(0.5);
      }
    }
    
    // draw the hue guide below the hHist
    for(int i = 0; i < 640 ; i ++)
    {
      noStroke();
      colorMode(HSB, 640, 100, 100);
      fill(i, 100, 100);
      rect(i+640, 360, 1, 100);
      stroke(.5);
    }
  }
}

// Called every time a new frame is available to read
public void movieEvent(Movie m) {
  m.read();
  frame = myMovie;
}