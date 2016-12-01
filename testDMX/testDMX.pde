import dmxP512.*;
import processing.serial.*;

DmxP512 dmxOutput;
int universeSize=128;

boolean LANBOX=false;
String LANBOX_IP="192.168.1.77";

boolean DMXPRO=true;
String DMXPRO_PORT="/dev/ttyS0";//case matters ! on windows port must be upper cased.
int DMXPRO_BAUDRATE=115000;


void setup() {
  
  size(245, 245, JAVA2D);  
  
  dmxOutput=new DmxP512(this,universeSize,false);
  
  if(LANBOX){
    dmxOutput.setupLanbox(LANBOX_IP);
  }
  
  if(DMXPRO){
    dmxOutput.setupDmxPro(DMXPRO_PORT,DMXPRO_BAUDRATE);
  }
   
}

void draw() {    
  int nbChannel=20;  
  background(0);
  
  dmxOutput.set(1,255);
  dmxOutput.set(2,255);
  dmxOutput.set(3,255);
    
  
}