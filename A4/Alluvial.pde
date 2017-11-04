class Alluvial {
  float canvas_x;
  float canvas_y;
  float canvas_w;
  float canvas_h;
  
  float candidate_d;
  Map<String, ArrayList<Candidate>> party_map = new HashMap<String, ArrayList<Candidate>>();
 
  public Alluvial(ArrayList<Candidate>candidates, float c_x, float c_y, float c_w, float c_h){
    canvas_x = c_x;
    canvas_y = c_y;
    canvas_w = c_w;
    canvas_h = c_h;
    candidate_d = canvas_h / (2*candidates.size() + 1);
    
    createPartyMap(candidates);
    drawAlluvial(candidates);
    
  }
  
  
  void drawAlluvial(ArrayList<Candidate>candidates){
    // draw the candidates' circles
    float ratio_sum = 0;
    float spacing_total = canvas_h/5;
    float content_total = 4*canvas_h/5;
    ArrayList<Float>ratios = new ArrayList<Float>();
    
    for (int i = 0; i < candidates.size(); i++) {
      Candidate curr = candidates.get(i);
      Candidate first = candidates.get(0);
      float curr_fund = curr.Funds.get(curr.Funds.size() - 1);
      float first_fund = first.Funds.get(first.Funds.size() - 1);
      float ratio = sqrt(curr_fund / first_fund);
      ratio_sum += ratio;
      ratios.add(ratio);
      //float x_pos = canvas_x + canvas_w - 3*candidate_d;
      //float y_pos = 2*candidate_d * (i+1) - 0.5*candidate_d;
      //ellipse(x_pos, y_pos, candidate_d, candidate_d);
    }
    
    
    float first_d = content_total / ratio_sum;
    float max_ratio = find_max(ratios);
    float x_margin = max_ratio * first_d / 2 + 10;
    
    float y_margin = spacing_total / (candidates.size() +1 );
    float curr_r = 0;
    float accum_y = 0;
    for (int i  = 0; i < candidates.size(); i++){
      curr_r = ratios.get(i) * first_d / 2;
      ellipse(canvas_x + canvas_w - x_margin, accum_y + y_margin + curr_r, curr_r*2, curr_r * 2);
      accum_y += y_margin + curr_r + curr_r; 
    }

    
    // draw the party circles
    float democrat_sum = getFundSum(party_map.get("Democrat"));
    float rep_sum = getFundSum(party_map.get("Republican"));
    float other_sum = getFundSum(party_map.get("Other"));
    
    float Rep_to_Dem = sqrt(rep_sum/ democrat_sum);
    float Other_to_Dem = sqrt(other_sum/ democrat_sum);
    
    spacing_total = canvas_h/3;
    y_margin = spacing_total/3;
    content_total = 2*canvas_h/3;
    
    float Dem_dia = content_total / (1 + Rep_to_Dem + Other_to_Dem);
    float Rep_dia = Dem_dia * Rep_to_Dem;
    float Other_dia = Dem_dia * Other_to_Dem;
    x_margin = max(Dem_dia, max(Rep_dia, Other_dia));
    
    ellipse(canvas_x + x_margin, y_margin + Dem_dia/2, Dem_dia, Dem_dia );
    ellipse(canvas_x + x_margin, y_margin + Dem_dia + y_margin/2 + Rep_dia/2, Rep_dia, Rep_dia);
    ellipse(canvas_x + x_margin, canvas_h - y_margin - Other_dia/2, Other_dia, Other_dia);
    
    // draw the streams
    
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
  
  
  //ArrayList<Float> FundList(ArrayList<Candidate>candidates) {
    
  //}
  
  
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