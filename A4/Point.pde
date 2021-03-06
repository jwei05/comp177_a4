class Point{
  float x, y;
  float diameter = 7;
  float fund;
  boolean highlight;
  String name;
  
  public Point(float x_pos, float y_pos, float Fund, String Name){
     x = x_pos;
     y = y_pos;
     fund = Fund;
     highlight = false;
     name = Name;
  }
  
  void drawPoint() {
    if (onPoint() || highlight) {
      fill(255, 255, 102);
      ellipse(x, y, diameter, diameter);
      if(onPoint()){
        toolkit(); 
      }
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
  
  
  void updateModel() {
    model.Update("candidate", name);
  }
  
  void toolkit(){
     fill(255);
     textSize(20);
     String s = this.name + System.lineSeparator() +
                this.fund/1000000 + " m";
     text(s, 20, 650); 
  }
}