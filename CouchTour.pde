import java.awt.*;
import processing.video.*;

Movie myMovie;
PImage screenshot;

void setup() {
  size(100, 100);
  myMovie = new Movie(this, "visualizer.mp4");
  myMovie.loop();
}
 
void draw() {  
    //screenshot();
    color pC = binMethod(screenshot); //get next current color
    fill(pC); 
    rect(0, 0, 100, 100);    
}

void screenshot() {
  try {
    screenshot = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
  } catch (AWTException e) { }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  screenshot = myMovie;
}