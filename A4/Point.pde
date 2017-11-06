class Point{
  float x, y;
  float diameter = 5;
  float fund;
  public Point(float x_pos, float y_pos, float Fund){
     x = x_pos;
     y = y_pos;
     fund = Fund;
  }
  
  void drawPoint() {
    ellipse(x, x, diameter, diameter);
  }
}