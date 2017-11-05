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
    Funds = funds;
    TotalFund = Funds.get(Funds.size()-1);
  }
}