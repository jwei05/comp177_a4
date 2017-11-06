class Arc{
  String name;
  color c;
  float cent_x, cent_y, diameter, start, end, angle;
  float inner_d;    // the inner boundary of the wedge
  boolean highlight;
  boolean is_state;
  
  public Arc(String id, color clr, float x, float y, float srt, float End, float dia, float inner_dia,
             float Angle, boolean Is_state){
    name = id;
    c = clr;
    cent_x = x;
    cent_y = y;
    start = srt;
    end = End;
    diameter = dia;
    inner_d = inner_dia;
    angle = Angle;
    highlight = false;
    is_state = Is_state;
  }
  
  void drawArc(){
    ellipseMode(CENTER);
    fill(c);
    arc(cent_x, cent_y, diameter, diameter, start, end, PIE); 
    if (onArc() || highlight) {
      fill(131, 198, 205);
      arc(cent_x, cent_y, diameter, diameter, start, end, PIE); 
      if (onArc()) {
        updateModel();
      }
    }
  }
  
  boolean onArc() {
    float curr_angle = atan2(mouseY - cent_y, mouseX - cent_x);
    if (curr_angle < 0) {
      curr_angle += TWO_PI;
    }
    
    if (sq(mouseX - cent_x) + sq(mouseY - cent_y) <= sq(inner_d/2)) {
      return false;
    }
    
   if (sq(mouseX - cent_x) + sq(mouseY - cent_y) <= sq(diameter/2) && (start < curr_angle && end > curr_angle)) {
       return true;
    } else {
      return false; 
      }
  }
  //TODO: doesn't work
  //void mouseClicked(){
  //  float curr_angle = atan2(mouseY - cent_y, mouseX - cent_x);
  //  if (curr_angle < 0) {
  //    curr_angle += TWO_PI;
  //  }
  //  if (sq(mouseX - cent_x) + sq(mouseY - cent_y) <= sq(diameter/2) && (start < curr_angle && end > curr_angle)){
  //     println("ha"); 
  //    model.updateVisible(name, is_state); 
  //  }
  //}
  void updateModel() {
    if (is_state) {
       model.Update("state", name);
    }
    else {
       model.Update("candidate", name);
    }
  }
}