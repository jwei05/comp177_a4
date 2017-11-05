class Circle {
  String name;
  float x, y;
  float diameter;
  float Funding;
  
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