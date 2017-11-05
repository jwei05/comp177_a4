class Sunburst{
  float canvas_x;
  float canvas_y;
  float canvas_width;
  float canvas_height;
  float outer_r;
  float middle_r;
  float inner_r;
  float center_x;
  float center_y;
  
  float all_candidates_sum;
  Map<String, ArrayList<Candidate>> state_map = new HashMap<String, ArrayList<Candidate>>();
  
  public Sunburst(ArrayList<Candidate>candidates, float c_x, float c_y, float c_w, float c_h){
    canvas_x = c_x;
    canvas_y = c_y;
    canvas_width = c_w;
    canvas_height = c_h;
    center_x = canvas_width/2;
    center_y = canvas_height/2 + canvas_height;
    outer_r = (canvas_height -  20) / 2;
    middle_r = outer_r - 50;
    inner_r = middle_r - 50;
    all_candidates_sum = getFundSum(candidates);
    createStateMap(candidates);    
  }
  
  void drawGraph(ArrayList<Candidate>candidates){
       drawSunburst(candidates); 
  }
  
  void drawSunburst(ArrayList<Candidate>candidates){
    // outer arcs
    float start_angle = 0;
    for ( String key : state_map.keySet()) {
        ArrayList<Candidate>l = state_map.get(key);
        for (Candidate c : l) {
          float curr_val = c.Funds.get(c.Funds.size() - 1);
          float curr_angle = 2*PI*(curr_val/all_candidates_sum);
          ellipseMode(CENTER);
          fill(255);
          arc(center_x, center_y, outer_r*2, outer_r*2, start_angle, start_angle + curr_angle, PIE); 
          start_angle += curr_angle;
        }
    }
    
    // middle arcs
    start_angle = 0;
    for ( String key : state_map.keySet()) {
      float state_sum = getFundSum(state_map.get(key));
      float curr_angle = 2*PI*(state_sum/all_candidates_sum);
      fill(255);
      arc(center_x, center_y, middle_r*2, middle_r*2, start_angle, start_angle + curr_angle, PIE); 
      start_angle += curr_angle;
    }
    
    // inner
    ellipse(center_x, center_y, inner_r*2, inner_r*2);
  }
  
  void createStateMap(ArrayList<Candidate>candidates) {
    for (Candidate c : candidates) {
      if (state_map.get(c.State) == null) {
        ArrayList<Candidate>l = new ArrayList<Candidate>();
        l.add(c);
        state_map.put(c.State, l);
      } else {
        ArrayList<Candidate>l = state_map.get(c.State);
        l.add(c);
        state_map.put(c.State, l);
      }
    }
  }
}

float getFundSum(ArrayList<Candidate>candidates) {
    float temp_sum = 0;
    for (Candidate c : candidates) {
      float curr_val = c.Funds.get(c.Funds.size() - 1);
      temp_sum += curr_val;
    }
    return temp_sum;
}