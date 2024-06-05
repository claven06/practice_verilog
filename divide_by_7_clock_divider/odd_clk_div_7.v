module odd_clk_div_7 (
	input clk,
    input rst_n,
  	output out_clk
);
  
  reg [2:0] ctr;
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      ctr <= 0;
	  else if (ctr == 6) 
	  // for divide by 5 clock, change ctr == 6 to 4
	  // for divide by 3 clock, change ctr == 6 to 2
      ctr <= 0;
    else
      ctr <= ctr + 1;
  end
 
  wire ff1_en, ff2_en;
  reg ff1, ff2;
  
  assign ff1_en = (ctr == 0) ? 1 : 0;
  assign ff2_en = (ctr == 4) ? 1 : 0; 
  // for divide by 5 clock, change ctr == 4 to 3
  // for divide by 3 clock, change ctr == 4 to 2
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      ff1 <= 0;
    end
    else begin
      if (ff1_en)
        ff1 <= ~ff1;
    end
  end
  
  always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
      ff2 <= 0;
    end
    else begin
      if (ff2_en)
        ff2 <= ~ff2;
    end
  end
  
  assign out_clk = ff1 ^ ff2;
endmodule
