class Arc{
  String name;
  color c;
  float cent_x, cent_y, diameter, start, end, angle;
  
  public Arc(String id, color clr, float x, float y, float srt, float End, float dia,
             float Angle){
    name = id;
    c = clr;
    cent_x = x;
    cent_y = y;
    start = srt;
    end = End;
    diameter = dia;
    angle = Angle;
  }
  
  void drawArc(){
    fill(c);
    arc(cent_x, cent_y, diameter, diameter, start, end, PIE); 
  }
}