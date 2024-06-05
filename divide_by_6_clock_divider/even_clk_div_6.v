module even_clk_div_6 (
  input clk,
  input rst_n,
  output out_clk
);
  
  reg [2:0] ctr;
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      ctr <= 0;
    else if(ctr == 5)
      ctr <= 0;
    else 
      ctr <= ctr + 1;
  end
 
  assign out_clk = (rst_n & (ctr >= 3)) ? 0 : 1;
endmodule