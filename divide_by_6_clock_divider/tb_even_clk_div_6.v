module tb_even_clk_div_6();
  
  reg clk;
  reg rst_n;
  wire out_clk;
  
  even_clk_div_6 DUT (
    .clk(clk),
    .rst_n(rst_n),
    .out_clk(out_clk)
  );
  
  always #5 clk = ~clk;
  
  initial begin
    clk <= 0;
    rst_n <= 0;
    
    #30 rst_n <= 1;
    
    #500 $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_even_clk_div_6);
  end
endmodule