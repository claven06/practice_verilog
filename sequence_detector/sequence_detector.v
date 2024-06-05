// Detect 110101 sequence in the input data stream
module sequence_detector (
    input clk,
    input rst_n,
    input data_in,
    output data_out
);

  reg [2:0] current_state;
  reg [2:0] next_state;

parameter [2:0]
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    S3 = 3'b011,
    S4 = 3'b100,
    S5 = 3'b101,
    S6 = 3'b110;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
        current_state <= S0;
    else
        current_state <= next_state;
end

  always @(*) begin
    case(current_state)
        S0: begin
            if(data_in) begin
                next_state <= S1;
            end else begin
                next_state <= S0;
            end
        end

        S1: begin
            if(data_in) begin
                next_state <= S2;
            end else begin
                next_state <= S0;
            end
        end

        S2: begin
            if(!data_in) begin
                next_state <= S3;
            end else begin
                next_state <= S2;
            end
        end

        S3: begin
            if(data_in) begin
                next_state <= S4;
            end else begin
                next_state <= S0;
            end
        end

        S4: begin
            if(!data_in) begin
                next_state <= S5;
            end else begin
                next_state <= S1;
            end
        end

        S5: begin
            if(data_in) begin
                next_state <= S6;
            end else begin
                next_state <= S0;
            end
        end

        S6: begin
            if(data_in) begin
                next_state <= S1;
            end else begin
                next_state <= S0;
            end
        end

        default: next_state <= S0;
    endcase
end

assign data_out = (current_state == S6) ? 1'b1 : 1'b0;
endmodule