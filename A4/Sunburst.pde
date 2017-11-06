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
  
  Map<String, ArrayList<Arc>> state_arcs_map = new HashMap<String, ArrayList<Arc>>();
  ArrayList<Arc> state_arcs = new ArrayList<Arc>();
  Map<Candidate, ArrayList<Arc>> cand_arcs_map = new HashMap<Candidate, ArrayList<Arc>>();
  
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
    initSunburst(candidates); 
  }
  
  void drawGraph(ArrayList<Candidate>candidates){
       updateState_Arc_Map(candidates);
       updateArcs(candidates);
      
       // candidates arcs
       for (String key : state_arcs_map.keySet()) {
         ArrayList<Arc>l = state_arcs_map.get(key);
         for (Arc a : l) {
           a.drawArc();
         }
       }
       
       // state arcs
       for (Arc a : state_arcs) {
         a.drawArc();
       }
       
       // inner
      ellipse(center_x, center_y, inner_r*2, inner_r*2);
  }
  
  void initSunburst(ArrayList<Candidate>candidates){
    // initialize the state arcs
    for ( String key : state_map.keySet()) {
      state_arcs_map.put(key, new ArrayList());
    }
    
    // initialize the candidate arcs
    for (Candidate c : candidates) {
      cand_arcs_map.put(c, new ArrayList());
    }
    
    
    // outer arcs
    float start_angle = 0;
    for ( String key : state_map.keySet()) {
        ArrayList<Candidate>l = state_map.get(key);
        for (Candidate c : l) {
          float curr_val = c.Funds.get(c.Funds.size() - 1);
          float curr_angle = 2*PI*(curr_val/all_candidates_sum);
    
          Arc arc = new Arc(c.Name, 255, center_x, center_y, start_angle, start_angle + curr_angle, outer_r*2, middle_r*2, curr_angle, false);
          state_arcs_map.get(key).add(arc);
          cand_arcs_map.get(c).add(arc);
          
          start_angle += curr_angle;
        }
    }
    
    // middle arcs
    start_angle = 0;
    for ( String key : state_map.keySet()) {
      float state_sum = getFundSum(state_map.get(key));
      float curr_angle = 2*PI*(state_sum/all_candidates_sum);
  
      Arc arc = new Arc(key, 255, center_x, center_y, start_angle, start_angle + curr_angle, middle_r*2, inner_r*2, curr_angle, true);
      state_arcs.add(arc);
      
      start_angle += curr_angle;
    } 
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
  
  void updateArcs(ArrayList<Candidate>candidates) {
    for( Candidate c : candidates ){
       if(c.highlight){
         ArrayList<Arc> l = cand_arcs_map.get(c);
         for (Arc a : l) {
           a.highlight = true;
         }
       }
    }
  }
  
  //update the mapping between state and arc
  void updateState_Arc_Map(ArrayList<Candidate>candidates) {
      state_arcs_map.clear();
      cand_arcs_map.clear();
      ArrayList<String> states = getStates(candidates);
      ArrayList<Arc> updated_arcs = new ArrayList<Arc>();
      for ( String st : states) {
          state_arcs_map.put(st, new ArrayList());
      }
    
      // initialize the candidate arcs
      for (Candidate c : candidates) {
          cand_arcs_map.put(c, new ArrayList());
      }
      //visible candidates only one, only draw circle
      if(states.size() == 1 && candidates.size() == 1){
          Arc a = new Arc(candidates.get(0).Name, 255, center_x, center_y, 0, 2*PI, outer_r *2, 0, 2*PI, false);
          updated_arcs.add(a);
          cand_arcs_map.put(candidates.get(0), updated_arcs); 
      } else if (states.size() == 1){
          twolayer(candidates);
      }

      //// outer arcs
      //float start_angle = 0;
      //for ( String key : state_map.keySet()) {
      //  ArrayList<Candidate>l = state_map.get(key);
      //  for (Candidate c : l) {
      //    float curr_val = c.Funds.get(c.Funds.size() - 1);
      //    float curr_angle = 2*PI*(curr_val/all_candidates_sum);
    
      //    Arc arc = new Arc(c.Name, 255, center_x, center_y, start_angle, start_angle + curr_angle, outer_r*2, middle_r*2, curr_angle, false);
      //    state_arcs_map.get(key).add(arc);
      //    cand_arcs_map.get(c).add(arc);
          
      //    start_angle += curr_angle;
      //  }
      //}
    
      //// middle arcs
      //start_angle = 0;
      //for ( String key : state_map.keySet()) {
      //  float state_sum = getFundSum(state_map.get(key));
      //  float curr_angle = 2*PI*(state_sum/all_candidates_sum);
  
      //  Arc arc = new Arc(key, 255, center_x, center_y, start_angle, start_angle + curr_angle, middle_r*2, inner_r*2, curr_angle, true);
      //  state_arcs.add(arc);
      
      //  start_angle += curr_angle;
      //} 
      
      ////for(String st : states){
      //   ArrayList<Arc> c = cand_arcs_map.get(st); 
      //   state_arcs_map.put(st, c);
      //}
      //if (states.size() == 1){
      //  //recalculate the arc angles 
        
      //}
      
      
      
  }
  
  //recalculates the arcs based off of two layer sunburst
  void twolayer(ArrayList<Candidate>candidates){
      for (Candidate c : candidates) {
         float start = 
         float end = 
         Arc a = new Arc(c.Name, 255, center_x, center_y,   
      }
  }
  
  ArrayList<String> getStates(ArrayList<Candidate>candidates){
    ArrayList<String> allstates = new ArrayList<String>();
    Set<String> uniquestates;
    for (Candidate c : candidates){
        allstates.add(c.State);
    }
    uniquestates = new HashSet<String>(allstates);
    allstates.clear();
    allstates.addAll(uniquestates);
    printArray(allstates);
    return allstates;
  }
  
  //resets all the highlighting
  void reset(){
    for (Arc a : state_arcs){
       a.highlight = false; 
    }
    
    for(String key : state_arcs_map.keySet()){
       ArrayList<Arc> all_arcs = state_arcs_map.get(key);
       for(Arc c : all_arcs){
         c.highlight = false; 
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