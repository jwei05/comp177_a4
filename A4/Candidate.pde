class Candidate {
  String Name;
  String State;
  String Party;
  Float TotalFund;
  ArrayList<String> Months;
  ArrayList<Float> Funds;
  
  Candidate (String name, String state, String party, ArrayList<Float> funds) {
    Name = name;
    State = state;
    Party = party;
    //funds overtime
    Funds = funds;
    //total fund by end of campaign
    TotalFund = Funds.get(Funds.size()-1);
  }
}