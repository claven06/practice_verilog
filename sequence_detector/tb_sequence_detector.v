// Code your testbench here
// or browse Examples
module tb_sequence_detector();
  
  reg clk, rst_n, data_in;
  wire data_out;
  
  sequence_detector DUT (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .data_out(data_out)
  );
  
  always #5 clk <= ~clk;
  
  integer i;
  reg [23:0] test = 24'b11010101_00010110_10101011;
  
  initial begin
    clk <= 1;
    rst_n <= 0;
    data_in <= 0;
    
    #30 rst_n <= 1;

    for (i = 0; i < 24; i = i + 1) begin
      data_in <= test[23];
      #10 test <= test << 1;
    end
    
    #500 $finish;
    
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_sequence_detector);
  end
endmodule