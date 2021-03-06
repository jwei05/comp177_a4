import java.util.*;
Model model; 
Line_Graph temporal_g;
Sunburst sunburst_g;
Alluvial alluvial_g;
boolean clicked;
String to_draw;

void setup () {
  size(1200, 700);
  background(115, 119, 140);
  model = new Model();
  to_draw = "all";
  
  //intialize all the graphs
  temporal_g = new Line_Graph(model.ElectionCandidates, model.months, 0, 0, 0.6 * width, 0.5 * height);
  sunburst_g = new Sunburst(model.ElectionCandidates, 0, 0.5 * height, 0.6 * width, 0.5 * height);
  alluvial_g = new Alluvial(model.ElectionCandidates,0.6 *width, 0, 0.4*width, height);
  
}

void draw () {
  clear();
  background(115, 119, 140);
  temporal_g.report_hover_to_model();
  alluvial_g.report_hover_to_model();
  sunburst_g.report_hover_to_model(to_draw);
  
  temporal_g.drawGraph(model.Visible_candidates, model.months);
  alluvial_g.drawGraph(model.Visible_candidates);
  sunburst_g.drawGraph(model.Visible_candidates);
  
  model.reset();
}

//if press z, zoomout
void keyPressed(){
  if(key == 'z'){
    //zoomout
    if(model.is_candidate(to_draw)){ 
      to_draw = model.find_candidate(to_draw).State;
    } else {
      to_draw = "all";
    }   
  }
}