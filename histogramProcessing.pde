public int[] resetArray(int[] a) {

  for (int i = 0; i<a.length; i++){
    a[i] = 0;
  }
  return a;
}

public boolean zeroArray(int[] a){
  int sum = 0;
   for(int i = 0; i < a.length; i++)
   {
     sum += hist[i];
   }
   if(sum==0) return true;
   else return false;
}

public int[] smoothHist(int[] a)
{
    int[] signal  = a;
    int l = signal.length;
    int[] smooth = new int[l];
    
    // compute the smoothed value for each
    //  cell of the array smooth
    smooth[0]  =  (signal[0] + signal[1])/2;
    smooth[l-1] = (signal[l-2] + signal[l-1])/2;
    
    for (int i = 1; i < l - 1; i++)
    {
      smooth[i] = (signal[i-1] + signal[i] + signal[i+1])/3;
    }
    return smooth;
}

int[] getTopColors(int[] hist, int beta)
{
  int[] avgs = new int[10];  
  for(int i = 0; i < avgs.length; i++)
  {
    int sum = 0;
    for(int j = i*(hist.length/avgs.length); j < (i+1)*(hist.length/avgs.length)-1; j++)
    {
      sum+=hist[j];
    }
    avgs[i] = sum/(hist.length*(hist.length/avgs.length));
  }
  
  int[] topSections = new int[beta];
  for(int i=0; i < topSections.length; i++)
  {
    int n = indexOfInt(max(avgs), avgs);
     topSections[i] = n;
     avgs[n] = -1;
  }
  
  int[] topHues = new int[beta];
  topHues = resetArray(topHues);
  for(int i = 0; i < topSections.length; i++)
  {
    for(int j = topSections[i]*(hist.length/avgs.length); j < (topSections[i]+1)*(hist.length/avgs.length)-1; j++)
    {
      if(topHues[i]<hist[j])
      {
        topHues[i] = hist[i];
      }
    }
  }
  
  return topHues;
}


int[] getTopColors2(int[] hist, int beta)
{
  int alpha = 20;
  int[] topColors = new int[beta];
  int max = max(hist);
  for(int i = 0; i < beta; i++)
  {
    if(i > 0 && max(hist)<max*0.15)
    {
      topColors[i] = topColors[0];
    }
    else{
      topColors[i] = indexOfInt(max(hist), hist);
    }
    int n = 0;
    int bottom = topColors[i] - alpha;
    int top = topColors[i] + alpha;
    if(bottom<0) bottom = 0;
    if(top>hist.length) top = hist.length;
    for(int j = bottom; j < top; j++)
    {
      hist[j] = -1;
    }
  }
  return topColors;
}


int indexOfInt(int value, int[] a)
{
  for(int i = 0; i < a.length; i++)
  {
    if(a[i] == value) return i;
  }
  return -1;
}

boolean contains(int value, int[] a){
  for(int j = 0; j < a.length; j++)
  {
    if(a[j] == value) return true;
  }
  return false;
}