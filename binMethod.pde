//this method will employ color bins, and will throw pixels into bins
//then pick the fullest bin as the highlight color

color binMethod(PImage img)
{
  img.loadPixels();
  int numberOfPixels = img.pixels.length;
  resetBins();
  // loop through every pixel
  for (int i = 0; i < numberOfPixels; i+=10) {
      float minDist = 255;
      int mindex = 0;
      color pixel = img.pixels[i];
      
      if(brightness(pixel)>100) {
        // for each pixel, see where it best fits in the bins
        for (int c=0; c<colors.length; c++) {
          float dist = colorDist(pixel, colors[c]);
          if(dist<minDist){
            // new min dist, update index and minDist
            minDist = dist;
            mindex=c;
            //println("found new min" + mindex);
        }
      }
      // we found where this pixel fits, we note that bin
      bins[mindex]++;
      }   
  }    
  // now we find the fullest bin, and return its color
  int bestcolor = getFullestBin();
  return colors[bestcolor];
}

void resetBins()
{
  for (int i=0; i<bins.length; i++) {
   bins[i]=0; 
  }
}

int getFullestBin() {
  int maxIndex=0, max=0;
  for (int i=1; i<bins.length; i++) {
    if (bins[i]>max) {
      max= bins[i];
      maxIndex = i;
    }
  }
  return maxIndex;
}

float colorDist(color c1, color c2)
{
  float rmean =(red(c1) + red(c2)) / 2;
  float r = red(c1) - red(c2);
  float g = green(c1) - green(c2);
  float b = blue(c1) - blue(c2);
  return sqrt((int(((512+rmean)*r*r))>>8)+(4*g*g)+(int(((767-rmean)*b*b))>>8));
}