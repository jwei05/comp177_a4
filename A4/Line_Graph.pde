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
     initData(candidates);
     //drawaxisandidates,fund_months);
     //drawData(candid 
  }
  void drawGraph(ArrayList<Candidate> candidates, ArrayList<String>fund_months) {
     drawaxis(candidates,fund_months);
     drawData();
  }
  
  void drawaxis(ArrayList<Candidate>candidates, ArrayList<String>fund_months){
    //draws the x axis
    line(x_margin, y_margin + y_len, x_margin + x_len, y_margin + y_len);
    //draws the y axis
    line(x_margin, y_margin, x_margin, y_margin + y_len);

    //draw the x axis increments
    int total_mth = fund_months.size();
    for(int i = 0; i < total_mth; i++) {
      x_unit_len = x_len/(total_mth + 1);      
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
    
    void initData(ArrayList<Candidate> candidates){ 
      float curr_x, curr_y;
      float prev_x, prev_y;
      float y_unit_len = (y_len - 25) / max;
      
      for (Candidate c : candidates){
         ArrayList<Point> cand_fund = new ArrayList<Point>();
         for(int i = 0; i < c.Funds.size(); i++){           
            curr_x = x_margin + (i+1) * x_unit_len;
            curr_y = (c.Funds.get(i)) * y_unit_len ; 
            Point p = new Point(curr_x, canvas_height - y_margin - curr_y, c.Funds.get(i));
            cand_fund.add(p);
         }
         cand_points.put(c, cand_fund);
      }
    }
    
    void drawData(){
      for(Candidate key : cand_points.keySet()){
         ArrayList<Point> c_fundings = cand_points.get(key);
         for(int i = 0; i < c_fundings.size(); i++){
            fill(0);
            Point p = c_fundings.get(i); 
            p.drawPoint();
            if(i != 0) {
               float prev_x = c_fundings.get(i-1).x;
               float prev_y = c_fundings.get(i-1).y;
               line(prev_x, prev_y, p.x, p.y);
            }     
         }
      }
    }
}