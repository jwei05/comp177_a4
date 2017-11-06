//class for circle profile for alluvial graph
class Circle {
  String name;
  float x, y;
  float diameter;
  float Funding;
  boolean highlight; // not on yourself
  boolean is_party;
  public Circle(String Name, float X, float Y, float D, float fund, boolean Is_party){
     name = Name;
     x = X;
     y = Y;
     diameter = D;
     Funding = fund;
     highlight = false;
     is_party = Is_party;
  }
  
  void drawCircle() {
    if (highlight) {
       fill(242, 202, 205);
       //println(this.name);
       ellipse(x, y, diameter, diameter); 
    } else {
      fill(255);
      ellipse(x, y, diameter, diameter); 
    }
  }
  
}