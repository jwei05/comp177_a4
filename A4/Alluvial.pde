class Alluvial {
  float canvas_x;
  float canvas_y;
  float canvas_w;
  float canvas_h;
 
  ArrayList<Circle>party_circles = new ArrayList<Circle>();
  ArrayList<Circle>candidates_circles = new ArrayList<Circle>();

  Map<String, ArrayList<Candidate>> party_map = new HashMap<String, ArrayList<Candidate>>();
  Map<String, ArrayList<Circle>>party_pos_map = new HashMap<String, ArrayList<Circle>>();
  
  public Alluvial(ArrayList<Candidate>candidates, float c_x, float c_y, float c_w, float c_h){
    canvas_x = c_x;
    canvas_y = c_y;
    canvas_w = c_w;
    canvas_h = c_h;
    
    createPartyMap(candidates);
    drawAlluvial(candidates);
  }
  
  
  void drawAlluvial(ArrayList<Candidate>candidates){
    
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
                            accum_y + y_margin + curr_r, curr_r*2, candidates.get(i).TotalFund);
      
      candidates_circles.add(c);
      
      party_pos_map.get(candidates.get(i).Party).add(c);
      
      accum_y += y_margin + curr_r + curr_r; 
    }

    
    // initialize the party circles
    float democrat_sum = getFundSum(party_map.get("Democrat"));
    float rep_sum = getFundSum(party_map.get("Republican"));
    float other_sum = getFundSum(party_map.get("Other"));
    
    float Rep_to_Dem = sqrt(rep_sum/ democrat_sum);
    float Other_to_Dem = sqrt(other_sum/ democrat_sum);
    
    spacing_total = canvas_h/3;
    y_margin = spacing_total/3;
    content_total = 2*canvas_h/3;
    
    float Dem_dia = content_total / 3;
    float Rep_dia = content_total / 3;
    float Other_dia = content_total / 3;
    x_margin = content_total / 4.5;
    
    Circle demo = new Circle("Democrat", canvas_x + x_margin, y_margin + Dem_dia/2, Dem_dia, 0);
    Circle rep = new Circle("Republican", canvas_x + x_margin,
                            y_margin + Dem_dia + y_margin/2 + Rep_dia/2, Rep_dia, 0);
    Circle other = new Circle("Other", canvas_x + x_margin, 
                            canvas_h - y_margin - Other_dia/2, Other_dia, 0);
    
    party_circles.add(demo);
    party_circles.add(rep);
    party_circles.add(other);
    float minfund = model.min_fund;
    
    //draw the streams
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
        float stroke = 0.05*circle.Funding/minfund;
        strokeWeight(stroke);
        bezier(party_x, party_y, candi_x-150, party_y, party_x+150, candi_y, candi_x, candi_y);
      }
    }
     
     // draw the party
    for (Circle c : party_circles) {
      strokeWeight(1);
      fill(255);
      c.drawCircle();
    }
    
    // draw the candidates
    for (Circle c : candidates_circles) {
      c.drawCircle();
    }
    //draw relation
    
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
    //for ( String key : party_map.keySet()) {
    //    ArrayList<Candidate>l = party_map.get(key);
    //    print(key); 
    //    printArray(l);
    //}
  }
}

float find_max(ArrayList<Float>l) {
  float m = 0;
  for (Float num : l) {
    if (num > m) {
      m = num;
    }
  }
  return m;
}