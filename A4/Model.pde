class Model {
  ArrayList<Candidate> ElectionCandidates = new ArrayList<Candidate>();  // data
  ArrayList<Candidate> Visible_candidates = new ArrayList<Candidate>(); 
  ArrayList<Candidate> Highlight_candidates = new ArrayList<Candidate>(); 

  
  void parseData() {
    String[] lines = loadStrings("./data.csv");
    
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
}