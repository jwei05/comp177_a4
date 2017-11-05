//class for circle profile for alluvial graph
class Circle {
  String name;
  float x, y;
  float diameter;
  float Funding;
  boolean highlight; // not on yourself
  
  public Circle(String Name, float X, float Y, float D, float fund){
     name = Name;
     x = X;
     y = Y;
     diameter = D;
     Funding = fund;
  }
  
  void drawCircle() {
    ellipse(x, y, diameter, diameter); 
  }
  
}