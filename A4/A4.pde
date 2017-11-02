import java.util.*;
Model model = new Model();

void setup () {
  size(1200, 700);
  model.parseData();
  
  
  //ArrayList<Candidate> result = new ArrayList<Candidate>();
  //result = model.FilterbyParty("Democrat");
  //println("size: ", result.size());
  
  //for (Candidate c : result ) {
  //  println("name: ", c.Name);
  //  println("state: ", c.State);
  //  println("party: ", c.Party);
  //  printArray(c.Funds);
  //}
  
}

void draw () {
   
   Line_Graph temporal_g = new Line_Graph(model.ElectionCandidates, 
                                    model.months, 0, 0, 0.6 * width, 0.5 * height);
   Sunburst sunburst_g = new Sunburst(model.ElectionCandidates, 0, 0.5 * height, 0.6 * width, 0.5 * height);
   Alluvial alluvial_g = new Alluvial(model.ElectionCandidates,0.6 *width, 0, 0.4*width, height);
                                    
}