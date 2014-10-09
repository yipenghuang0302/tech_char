module FF #(parameter WIDTH = 1) 
( 
 input clk, 
 input [WIDTH - 1 : 0] data_i, 
 output [WIDTH - 1 : 0] data_o 
); 
 reg [WIDTH - 1: 0] data; 
 always_ff @(posedge clk) begin 
 data <= data_i; 
 end 
 assign data_o = data; 
endmodule
