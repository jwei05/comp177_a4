import java.util.*;
void setup () {
  
  Model model = new Model();
  model.parseData();
  
  ArrayList<Candidate> result = new ArrayList<Candidate>();
  result = model.FilterbyParty("Democrat");
  //println("size: ", result.size());
  
  //for (Candidate c : result ) {
  //  println("name: ", c.Name);
  //  println("state: ", c.State);
  //  println("party: ", c.Party);
  //  printArray(c.Funds);
  //}
  
}

void draw () {
}