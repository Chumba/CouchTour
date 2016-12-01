import java.awt.*;

PImage screenshot;

void setup() {
  size(100, 100);
}
 
void draw() {  
    screenshot();
    color pC = binMethod(screenshot); //get next current color
    fill(pC); 
    rect(0, 0, 100, 100);    
}

void screenshot() {
  try {
    screenshot = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
  } catch (AWTException e) { }
}