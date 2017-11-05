import java.util.*;
Model model; 
Line_Graph temporal_g;
Sunburst sunburst_g;
Alluvial alluvial_g;

void setup () {
  size(1200, 700);
  model = new Model();
  
  temporal_g = new Line_Graph(model.ElectionCandidates, 
                                    model.months, 0, 0, 0.6 * width, 0.5 * height);
  sunburst_g = new Sunburst(model.ElectionCandidates, 0, 0.5 * height, 0.6 * width, 0.5 * height);
  alluvial_g = new Alluvial(model.ElectionCandidates,0.6 *width, 0, 0.4*width, height);
  
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
  temporal_g.drawGraph(model.ElectionCandidates, model.months);
  sunburst_g.drawGraph(model.ElectionCandidates);
  alluvial_g.drawGraph(model.ElectionCandidates);
                                    
}