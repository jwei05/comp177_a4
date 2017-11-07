//class for circle profile for alluvial graph
class Circle {
  String name;
  float x, y;
  float diameter;
  float Funding;
  boolean highlight; // not on yourself
  boolean is_party;
  color c;
  color party_color;
  
  public Circle(String Name, float X, float Y, float D, float fund, boolean Is_party){
     name = Name;
     x = X;
     y = Y;
     diameter = D;
     Funding = fund;
     highlight = false;
     is_party = Is_party;
     if (Name == "Democrat"){
        c = color(30, 50, 100, 128);
        party_color = color(30, 50, 100);
     } else if (Name == "Republican") {
        c = color(200, 66, 72, 128);
        party_color = color(200, 66, 72);
     } else if (Name == "Other"){
        c = color(190, 226, 152, 128);
        party_color = color(190, 226, 152);
     } else {
        party_color = color(76, 75, 71);
     }
  }
  
  void drawCircle() {
    if (onCircle() || highlight) {
       fill(party_color);
       ellipse(x, y, diameter, diameter); 
       if(onCircle()) {
          toolkit(); 
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
  
  void toolkit(){
     fill(255);
     textSize(20);
     text(this.name, 20, 650); 
  }
}