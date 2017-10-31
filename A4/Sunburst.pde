class Sunburst{
  float canvas_x;
  float canvas_y;
  float canvas_width;
  float canvas_height;
  float sum;
  float outer_r;
  float center_x;
  float center_y;
  
  public Sunburst(float c_x, float c_y, float c_w, float c_h){
    canvas_x = c_x;
    canvas_y = c_y;
    canvas_width = c_w;
    canvas_height = c_h;
    center_x = canvas_width/2;
    center_y = canvas_height/2 + canvas_height;
    outer_r = (canvas_height -  20) / 2;
    drawSunburst();
    
  }
  void drawSunburst(){
     ellipse(center_x, center_y, outer_r * 2, outer_r * 2); 
  }
 
}