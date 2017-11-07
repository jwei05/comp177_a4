class Line_Graph {
  float x_margin;
  float y_margin;
  float x_len;
  float y_len;
  float canvas_x;
  float canvas_y;
  float canvas_width;
  float canvas_height;
  float x_unit_len;
  float max; //maximum fund
  int total_mth;
  
  Map<Candidate, ArrayList<Point>> cand_points = new HashMap<Candidate, ArrayList<Point>>();
  
  public Line_Graph(ArrayList<Candidate>candidates, ArrayList<String>fund_months,
                        float c_x, float c_y, float c_w, float c_h) {
     canvas_x = c_x;
     canvas_y = c_y;
     canvas_width = c_w;
     canvas_height = c_h;
     x_margin = canvas_width/12;
     y_margin = canvas_height/7.5;
     x_len = canvas_width - (2 * x_margin);
     y_len = canvas_height - (2 * y_margin);
     
     max = getMaxfund(candidates);
     initData(candidates, fund_months);
     //drawaxisandidates,fund_months);
     //drawData(candid 
  }
  void drawGraph(ArrayList<Candidate> candidates, ArrayList<String>fund_months) {
     drawaxis(fund_months);
     drawData(candidates);
  }
  
  void drawaxis(ArrayList<String>fund_months){
    //draws the x axis
    line(x_margin, y_margin + y_len, x_margin + x_len, y_margin + y_len);
    //draws the y axis
    line(x_margin, y_margin, x_margin, y_margin + y_len);

    //draw the x axis increments
    for(int i = 0; i < total_mth; i++) {      
      float curr_x = x_margin + (i+1) * x_unit_len;
      float curr_y = canvas_height - y_margin;
      line(curr_x, curr_y - 2, curr_x, curr_y + 2);
      textSize(12);
      text(fund_months.get(i), x_margin + (i+1) * x_unit_len,
                               canvas_height - y_margin + 15);
    }
    
    //draw the y axis increment
    float y = (y_margin + y_len) - (y_len - 25);
    line(x_margin - 2, y, x_margin + 2, y);
    textSize(9);
    text(max/1000000, x_margin - 50, y);
  }
  
   //gets the maximum amount of fund amongst all candidates  
    float getMaxfund(ArrayList<Candidate>candidates){
       float temp_max = 0;  
       for(Candidate c : candidates){
           float fund = c.Funds.get(c.Funds.size() - 1);
           if (fund > temp_max){
              temp_max = fund; 
           }
       }
       return temp_max;
    }
    
    void initData(ArrayList<Candidate> candidates, ArrayList<String>fund_months){ 
      float curr_x, curr_y;
      float y_unit_len = (y_len - 25) / max;
      
      total_mth = fund_months.size();
      x_unit_len = x_len/(total_mth + 1);
      
      for (Candidate c : candidates){
         ArrayList<Point> cand_fund = new ArrayList<Point>();
         for(int i = 0; i < c.Funds.size(); i++){           
            curr_x = x_margin + (i+1) * x_unit_len;
            curr_y = (c.Funds.get(i)) * y_unit_len ; 
            Point p = new Point(curr_x, canvas_height - y_margin - curr_y, c.Funds.get(i), c.Name);
            cand_fund.add(p);
         }
         cand_points.put(c, cand_fund);
      }
    }
    
    void report_hover_to_model() {
      for(Candidate key : cand_points.keySet()){
         ArrayList<Point> l_pts = cand_points.get(key);
         for (Point p : l_pts) {
           if (p.onPoint()) {
               p.updateModel();
           }
         } 
      }
    }
    
    
    void drawData(ArrayList<Candidate>candidates){
      updatePoints(candidates);
      for(Candidate key : cand_points.keySet()){
         ArrayList<Point> l_pts = cand_points.get(key);
         color c = color(0);
         
         if (l_pts.get(0).highlight) {
               c = color(255, 255, 102); 
         } 
         
         for (Point p : l_pts) {
           if (p.onPoint()) {
               c = color(255, 255, 102); 
           }
         } 
         
         // draw lines
         for(int i = 0; i < l_pts.size(); i++){
            Point p = l_pts.get(i); 
            if(i != 0) {
               float prev_x = l_pts.get(i-1).x;
               float prev_y = l_pts.get(i-1).y;
               stroke(c);
               line(prev_x, prev_y, p.x, p.y);
               stroke(0);
            }  
            p.drawPoint();
         }
      }
    }
   
    void updatePoints(ArrayList<Candidate>candidates){
        for(Candidate c : candidates){
           if(c.highlight){
              ArrayList<Point> l =  cand_points.get(c); 
              for(Point p : l){
                 p.highlight = true;
              }
           }
        }
    }
    
    void reset(){
        for(Candidate key : cand_points.keySet()){
         ArrayList<Point> c_fundings = cand_points.get(key);
         
         for(int i = 0; i < c_fundings.size(); i++){
            c_fundings.get(i).highlight = false;
         }
      }
    }
}