class Point{
  float x, y;
  float diameter = 5;
  float fund;
  boolean highlight;
  
  public Point(float x_pos, float y_pos, float Fund){
     x = x_pos;
     y = y_pos;
     fund = Fund;
     highlight = false;
  }
  
  void drawPoint() {
    if (onPoint() || highlight) {
      //println("onlhihg: ");
      
      fill(255, 255, 102);
      ellipse(x, y, diameter, diameter);
    } else {
      fill(0);
      ellipse(x, y, diameter, diameter);
    }
  }
  
  boolean onPoint(){
    if(sq(mouseX - x) + sq(mouseY - y) <= sq(diameter/2)){
       return true; 
    }
    return false;
  }
}