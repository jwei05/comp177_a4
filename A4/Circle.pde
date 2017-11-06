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
    if (onCircle() || highlight) {
       fill(242, 202, 205);
       //println(this.name);
       ellipse(x, y, diameter, diameter); 
       if (onCircle()) {
         updateModel();
       }
    } else {
      fill(255);
      ellipse(x, y, diameter, diameter); 
    }
  }
  
  
  boolean onCircle(){
    if(sq(mouseX - x) + sq(mouseY - y) <= sq(diameter/2)){
       return true; 
    }
    return false;
  }
  
  
  void updateModel() {
    if (is_party) {
       model.Update("party", name);
    }
    else {
       model.Update("candidate", name);
    }
  }
  
}