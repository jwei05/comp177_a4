class Alluvial {
  float canvas_x;
  float canvas_y;
  float canvas_w;
  float canvas_h;
 
  ArrayList<Circle>party_circles = new ArrayList<Circle>();
  ArrayList<Circle>candidates_circles = new ArrayList<Circle>();
  
  Map<String, Circle> cc_map = new HashMap<String, Circle>();
  Map<String, ArrayList<Candidate>> party_map = new HashMap<String, ArrayList<Candidate>>();
  Map<String, ArrayList<Circle>>party_pos_map = new HashMap<String, ArrayList<Circle>>();
  
  public Alluvial(ArrayList<Candidate>candidates, float c_x, float c_y, float c_w, float c_h){
    canvas_x = c_x;
    canvas_y = c_y;
    canvas_w = c_w;
    canvas_h = c_h;
    
    createPartyMap(candidates);
    initGraph(candidates);
  }
  
  void initGraph(ArrayList<Candidate>candidates){
    // initialize the candidates' circles
    float ratio_sum = 0;
    float spacing_total = canvas_h/5;
    float content_total = 4*canvas_h/5;
    ArrayList<Float>ratios = new ArrayList<Float>();
    
    for (int i = 0; i < candidates.size(); i++) {
      Candidate curr = candidates.get(i);
      Candidate first = candidates.get(0);
      
      float curr_fund = curr.TotalFund;
      float first_fund = first.TotalFund;
      float ratio = sqrt(curr_fund / first_fund);
      
      ratio_sum += ratio;
      ratios.add(ratio);
    }
    
    float first_d = content_total / ratio_sum;
    float max_ratio = find_max(ratios);
    float x_margin = max_ratio * first_d / 2 + 10;
    float y_margin = spacing_total / (candidates.size() +1 );
    float curr_r = 0;
    float accum_y = 0;
    
    party_pos_map.put("Democrat", new ArrayList());
    party_pos_map.put("Republican", new ArrayList());
    party_pos_map.put("Other", new ArrayList());
    
    for (int i  = 0; i < candidates.size(); i++){
      curr_r = ratios.get(i) * first_d / 2;
      Circle c = new Circle(candidates.get(i).Name, canvas_x + canvas_w - x_margin, 
                            accum_y + y_margin + curr_r, curr_r*2, candidates.get(i).TotalFund, false);
      
      candidates_circles.add(c);
      cc_map.put(candidates.get(i).Name, c);
      party_pos_map.get(candidates.get(i).Party).add(c);
      
      accum_y += y_margin + curr_r + curr_r; 
    }
    
    // initialize the party circles
    spacing_total = canvas_h/3;
    y_margin = spacing_total/3;
    content_total = 2*canvas_h/3;
    
    float Dem_dia = content_total / 3;
    float Rep_dia = content_total / 3;
    float Other_dia = content_total / 3;
    x_margin = content_total / 4.5;
    
    Circle demo = new Circle("Democrat", canvas_x + x_margin, y_margin + Dem_dia/2, Dem_dia, 0, true);
    Circle rep = new Circle("Republican", canvas_x + x_margin,
                            y_margin + Dem_dia + y_margin/2 + Rep_dia/2, Rep_dia, 0, true);
    Circle other = new Circle("Other", canvas_x + x_margin, 
                            canvas_h - y_margin - Other_dia/2, Other_dia, 0, true);
    
    party_circles.add(demo);
    party_circles.add(rep);
    party_circles.add(other);
   }
   
  //updates changes to model 
  void report_hover_to_model() {
    for (Circle c: party_circles) {
      String p = c.name;
      ArrayList<Circle> l = party_pos_map.get(p);
      for (Circle circle : l) {
        if (circle.onCircle()) {
          circle.updateModel();
        }
      }
    }
  }
  
  void drawGraph(ArrayList<Candidate>candidates){
    //draw the streams
    update_circle(candidates);
    if (to_draw == "all") {
      for (Circle c : party_circles) {
        float party_x = c.x;
        float party_y = c.y;
        String p = c.name;
        ArrayList<Circle> l = party_pos_map.get(p);
        for (Circle circle : l) {
          float candi_x = circle.x;
          float candi_y = circle.y;
          noFill();
          //calculate stroke weight, dependent on amount of fund
          float stroke = (circle.Funding/model.minfund)/20;
          strokeWeight(stroke);
          bezier(party_x, party_y, candi_x-150, party_y, party_x+150, candi_y, candi_x, candi_y);
        }
        //resets stroke weight
        strokeWeight(1);
      }
      // draw the party
      for (Circle c : party_circles) {
        fill(255);
        c.drawCircle();
      }
      // draw the candidates
      for (Circle c : candidates_circles) {
        c.drawCircle();
      }
    } //candidate
      else if (cc_map.containsKey(to_draw)){
        Circle Cand_c = cc_map.get(to_draw);
        Candidate cand = model.find_candidate(Cand_c.name);
        
        for(Circle pc : party_circles){
          //println(pc.name, "   ", cand.Party);
          if(Objects.equals(pc.name,cand.Party)){
            float party_x = pc.x;
            float party_y = pc.y;
            String p = pc.name;
            ArrayList<Circle> l = party_pos_map.get(p);
            for(Circle circle : l){
              if(Objects.equals(circle.name, to_draw)){
                float candi_x = circle.x;
                float candi_y = circle.y;
                noFill();
                //calculate stroke weight, dependent on amount of fund
                float stroke = (circle.Funding/model.minfund)/20;
                strokeWeight(stroke);
                bezier(party_x, party_y, candi_x-150, party_y, party_x+150, candi_y, candi_x, candi_y);
                strokeWeight(1);
                pc.drawCircle();
                circle.drawCircle();
              }
              //resets stroke weight
              strokeWeight(1);  
            }
          }
        }   
      }//state
      else {
        ArrayList<Candidate> cands_instate = model.FilterbyState(to_draw);
        ArrayList<String> all_parties = findstate(cands_instate);
        
        for(Circle pc : party_circles){
          //println(pc.name, "   ", cand.Party);
          if(all_parties.contains(pc.name)){
            float party_x = pc.x;
            float party_y = pc.y;
            String p = pc.name;
            ArrayList<Circle> l = party_pos_map.get(p);
            for(Circle circle : l){
              String state = model.find_candidate(circle.name).State;
              if(Objects.equals(state, to_draw)){
                float candi_x = circle.x;
                float candi_y = circle.y;
                noFill();
                //calculate stroke weight, dependent on amount of fund
                float stroke = (circle.Funding/model.minfund)/20;
                strokeWeight(stroke);
                bezier(party_x, party_y, candi_x-150, party_y, party_x+150, candi_y, candi_x, candi_y);
                strokeWeight(1);
                pc.drawCircle();
                circle.drawCircle();
              }
              //resets stroke weight
              strokeWeight(1);  
            }
          }
        }   
      }
  }
  
  //find candidate's state
  ArrayList<String> findstate(ArrayList<Candidate>cands_instate){
     Set<String> h = new HashSet<String>();
     for(Candidate c : cands_instate){
        h.add(c.Party); 
     }
     return new ArrayList<String>(h);
  }
  
  void createPartyMap(ArrayList<Candidate>candidates){
    for (Candidate c : candidates) {
      if (party_map.get(c.Party) == null) {
        ArrayList<Candidate>l = new ArrayList<Candidate>();
        l.add(c);
        party_map.put(c.Party, l);
      } else {
        ArrayList<Candidate>l = party_map.get(c.Party);
        l.add(c);
        party_map.put(c.Party, l);
      }
    }
  }
  
  void update_circle(ArrayList<Candidate>candidates){
    for( Candidate c : candidates ){
       if(c.highlight){
         cc_map.get(c.Name).highlight = true;
       }
    }
  }
  
  //resets all the highlighting in party and candidate circles
  void reset(){
    for(Circle c : party_circles) {
       c.highlight = false; 
    }
    for(Circle c : candidates_circles) {
       c.highlight = false; 
    }
  }
}