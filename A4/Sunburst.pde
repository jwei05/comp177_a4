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
  
  // the complete one 
  Map<String, ArrayList<Arc>> state_arcs_map_1 = new HashMap<String, ArrayList<Arc>>();
  ArrayList<Arc> state_arcs_1 = new ArrayList<Arc>();
  Map<Candidate, ArrayList<Arc>> cand_arcs_map_1 = new HashMap<Candidate, ArrayList<Arc>>();
  
  // the state one 
  Map<String, ArrayList<Arc>> state_arcs_map_2 = new HashMap<String, ArrayList<Arc>>();
  Map<Candidate, ArrayList<Arc>> cand_arcs_map_2 = new HashMap<Candidate, ArrayList<Arc>>();
  
  // the candidate
  Map<String, Arc> cand_arc_map_3 = new HashMap<String, Arc>();
  
  
  public Sunburst(ArrayList<Candidate>candidates, float c_x, float c_y, float c_w, float c_h){
    canvas_x = c_x;
    canvas_y = c_y;
    canvas_width = c_w;
    canvas_height = c_h;
    center_x = canvas_width/2 + 50;
    center_y = canvas_height/2 + canvas_height;
    outer_r = (canvas_height -  20) / 2;
    middle_r = outer_r - 50;
    inner_r = middle_r - 50;
    
    initSunburst_1(candidates); 
    initSunburst_2(candidates);
    initSunburst_3(candidates);
  }
  
  void initSunburst_1(ArrayList<Candidate>candidates){
    // fill with empty arrays
    for ( String key : model.state_map.keySet()) {
      state_arcs_map_1.put(key, new ArrayList());
    }
 
    // fill with empty arrays
    for (Candidate c : candidates) {
      cand_arcs_map_1.put(c, new ArrayList());
    }
    
    // initialize state_arcs_map_1
    float start_angle = 0;
    for ( String key : model.state_map.keySet()) {
        ArrayList<Candidate>l = model.state_map.get(key);
        for (Candidate c : l) {
          float curr_val = c.Funds.get(c.Funds.size() - 1);
          float curr_angle = 2*PI*(curr_val/model.all_candidates_sum);
          Arc arc = new Arc(c.Name, 255, center_x, center_y, start_angle, start_angle + curr_angle, outer_r*2, middle_r*2, curr_angle, false);
          state_arcs_map_1.get(key).add(arc);
          cand_arcs_map_1.get(c).add(arc);
          start_angle += curr_angle;
        }
    }
    
    // initialize state_arcs_1
    start_angle = 0;
    for ( String key : model.state_map.keySet()) {
      float state_sum = getFundSum(model.state_map.get(key));
      float curr_angle = 2*PI*(state_sum/model.all_candidates_sum);
      Arc arc = new Arc(key, 255, center_x, center_y, start_angle, start_angle + curr_angle, middle_r*2, inner_r*2, curr_angle, true);
      state_arcs_1.add(arc);
      start_angle += curr_angle;
    } 
  }
  
  void initSunburst_2(ArrayList<Candidate>candidates) { 
    // fill with empty arrays
    for ( String key : model.state_map.keySet()) {
      state_arcs_map_2.put(key, new ArrayList());
    }
    
    // fill with empty arrays
    for (Candidate c : candidates) {
      cand_arcs_map_2.put(c, new ArrayList());
    }
    
    // initialize state_arcs_map_2
    float start_angle = 0;
    for ( String key : model.state_map.keySet()) {
        ArrayList<Candidate>l = model.state_map.get(key);
        for (Candidate c : l) {
          float curr_val = c.Funds.get(c.Funds.size() - 1);
          float state_sum = getFundSum(model.state_map.get(key));
          float curr_angle = 2*PI*(curr_val/state_sum);
          Arc arc = new Arc(c.Name, 255, center_x, center_y, start_angle, start_angle + curr_angle, outer_r*2, middle_r*2, curr_angle, false);
          state_arcs_map_2.get(key).add(arc);
          cand_arcs_map_2.get(c).add(arc);
          start_angle += curr_angle;
        }
        start_angle = 0;
    }
  }
  
  void initSunburst_3 (ArrayList<Candidate>candidates){
    for (Candidate c : candidates) {
      Arc a = new Arc(c.Name, 255, center_x, center_y, 0, 2*PI, outer_r *2, 0, 2*PI, false);
      cand_arc_map_3.put(c.Name, a);
    }
  }
  
  void report_hover_to_model(String to_draw) {   
    if (to_draw == "all") {
      // candidates arcs
       for (String key : state_arcs_map_1.keySet()) {
         ArrayList<Arc>l = state_arcs_map_1.get(key);
         for (Arc a : l) {
           if (a.onArc()) {
             a.updateModelHighlight();
           }
         }
       }
       // state arcs
       for (Arc a : state_arcs_1) {
         if (a.onArc()) {
           a.updateModelHighlight();
         }
       }
    } else if (state_arcs_map_1.containsKey(to_draw)){
      // candidates arcs
       ArrayList<Arc>l = state_arcs_map_2.get(to_draw);
       for (Arc a : l) {
         if (a.onArc()) {
           a.updateModelHighlight();
         }
       }
    } else {
      Arc a = cand_arc_map_3.get(to_draw);
      if (a.onArc()) {
        a.updateModelHighlight();
      }
    }
    
  }
  
  void drawGraph(ArrayList<Candidate>candidates){
       // Draw the complete graph (3 layers)
       if (to_draw == "all") {
         updateArcsHighlight_1(candidates);
         // candidates arcs
         for (String key : state_arcs_map_1.keySet()) {
           ArrayList<Arc>l = state_arcs_map_1.get(key);
           for (Arc a : l) {
             a.drawArc();
           }
         }
         // state arcs
         for (Arc a : state_arcs_1) {
           a.drawArc();
         }
         // inner
         ellipse(center_x, center_y, inner_r*2, inner_r*2);
       } else if (state_arcs_map_1.containsKey(to_draw)) {
         // Draw the state graph (2 layers) 
         updateArcsHighlight_2(candidates);
         ArrayList<Arc>l = state_arcs_map_2.get(to_draw);
         for (Arc a : l) {
           a.drawArc();
         } 
         // inner
         ellipse(center_x, center_y, middle_r*2, middle_r*2);
       } else {
         updateArcsHighlight_3(candidates);
         Arc a = cand_arc_map_3.get(to_draw);
         a.drawArc();
       }   
       
  }
  
  
  void updateArcsHighlight_1(ArrayList<Candidate>candidates) {
    for( Candidate c : candidates ){
       if(c.highlight){
         ArrayList<Arc> l = cand_arcs_map_1.get(c);
         for (Arc a : l) {
           a.highlight = true;
         }
       }
    }
  }
  
  void updateArcsHighlight_2(ArrayList<Candidate>candidates) {
    for( Candidate c : candidates ){
       if(c.highlight){
         ArrayList<Arc> l = cand_arcs_map_2.get(c);
         for (Arc a : l) {
           a.highlight = true;
         }
       }
    }
  }
  
  void updateArcsHighlight_3(ArrayList<Candidate>candidates) {
    for( Candidate c : candidates ){
       if(c.highlight){
         Arc a = cand_arc_map_3.get(c.Name);
         a.highlight = true;
       }
    }
  }
  
  
  //resets all the highlighting
  void reset_1(){
    for (Arc a : state_arcs_1){
       a.highlight = false; 
    }
    for(String key : state_arcs_map_1.keySet()){
       ArrayList<Arc> all_arcs = state_arcs_map_1.get(key);
       for(Arc c : all_arcs){
         c.highlight = false; 
       }  
    }
  }
  
  void reset_2(){
    for (Arc a : state_arcs_1){
       a.highlight = false; 
    }
    for(String key : state_arcs_map_2.keySet()){
       ArrayList<Arc> all_arcs = state_arcs_map_2.get(key);
       for(Arc c : all_arcs){
         c.highlight = false; 
       }  
    }
  }
  
  void reset_3() {
    for (String key : cand_arc_map_3.keySet()) {
      cand_arc_map_3.get(key).highlight = false;
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