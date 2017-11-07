class Model {
  ArrayList<Candidate> ElectionCandidates = new ArrayList<Candidate>();  // data
  ArrayList<Candidate> Visible_candidates;//= new ArrayList<Candidate>(); 
  ArrayList<Candidate> Highlight_candidates = new ArrayList<Candidate>(); 
  ArrayList<String> months = new ArrayList<String>();
  
  float minfund;
  
  float all_candidates_sum;
  Map<String, ArrayList<Candidate>> state_map = new HashMap<String, ArrayList<Candidate>>();
  
  
  Model() {
     parseData();
     Visible_candidates = (ArrayList<Candidate>)ElectionCandidates.clone();
     minfund = find_min_fund();
     createStateMap(ElectionCandidates);  
     all_candidates_sum = getFundSum(ElectionCandidates);
  }
  
  //resets the highlighting
  void reset(){
     for(Candidate c : Visible_candidates){
        c.highlight = false; 
     }
     alluvial_g.reset();
     sunburst_g.reset_1();
     sunburst_g.reset_2();
     temporal_g.reset();
  }
  
  //updates the interactions between the three graphs
  void Update(String filtergroup, String filtername ) {
    if (filtergroup == "state") {
      ArrayList<Candidate> l = FilterbyState(filtername);
      for( Candidate c : l ){
          c.highlight = true; 
      }
    } else if (filtergroup == "party"){
      ArrayList<Candidate> l = FilterbyParty(filtername);
      for( Candidate c : l ){
         c.highlight = true; 
      }
    }//filter by candidate 
    else {
      for(Candidate c : Visible_candidates){
         if(c.Name == filtername) {
            c.highlight = true; 
         }
      }
    }

  }
  
  float find_min_fund() {
    float min = Float.MAX_VALUE;
    for (Candidate c : ElectionCandidates) {
      if (c.TotalFund < min) {
         min = c.TotalFund;
      }
    }
    return min;
  }
  //read in data
  void parseData() {
    String[] lines = loadStrings("./data.csv");
    String[] headers = split(lines[0], ",");
    for (int i= 4; i < 13; i++) {
      months.add(headers[i]);
    }
    
    for (int i = 1; i < lines.length; i++) {
      String[] data = split(lines[i], ",");
      String name = data[0];
      String state =  data[1];
      String party = data[2];
      ArrayList<Float> funds = new ArrayList<Float>();
    
      for (int j = 4; j < 13; j++) {
        funds.add(float(data[j]));
      }
      
      Candidate c = new Candidate(name, state, party, funds);
      ElectionCandidates.add(c);
    }
  
  //for (Candidate c : ElectionCandidates ) {
  //  println("name: ", c.Name);
  //  println("state: ", c.State);
  //  println("party: ", c.Party);
  //  printArray(c.Funds);
  //}
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
  
  ArrayList<Candidate> FilterbyState(String state) {
    ArrayList<Candidate> result = new ArrayList<Candidate>();
    for (Candidate c : Visible_candidates) {
      //println("state "+ "--" +c.State + "--"+state+"--");
      if (Objects.equals(c.State, state)) {
        result.add(c);
      }
    }
    return result;
  }
  
  void updateVisible(String name, boolean is_state){
    //if state, then two layers
    if(is_state){
        to_draw = name;
    } else {
        to_draw = name;
    }
  }
  
  ArrayList<Candidate>FilterbyParty(String party) {
    ArrayList<Candidate> result = new ArrayList<Candidate>();
    for (Candidate c : Visible_candidates) {
      if (Objects.equals(c.Party, party)) {
        result.add(c);
      }
    }
    return result;
  }  
}