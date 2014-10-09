module cam(
reset,
clk,
read,
read_index,
write,
write_index,
write_data,
search,
search_data,
read_valid,
read_value,
search_valid,
search_index
);

//standard inputs
input reset;
input clk;
input read;
input [4:0] read_index;
input write;
input [4:0] write_index;
input [31:0] write_data;
input search;
input [31:0] search_data;

//wire to mux for selecting correct read value, contains 32x32 bits
wire [31:0][31:0] read_value_mux;

//standard outputs
output read_valid;
output [31:0] read_value;
output search_valid;
output [4:0] search_index;

//logic for decoders, valid results,and valid outputs
logic [31:0] dec_read_index;
logic [31:0] dec_write_index;
logic [31:0] read_results;
logic [31:0] search_results;
logic read_valid_logic;
logic search_valid_logic;

//array of 32 x 32bit words, 
cam_word words[31:0] (clk, reset, read, dec_read_index, write, dec_write_index, write_data, search, search_data, search_results, read_results, read_value_mux);

//decoders for read/write word selection
decoder_5_32 read_dcdr (read_index, dec_read_index);
decoder_5_32 write_dcdr (write_index, dec_write_index);

//encoder for search output
priority_encoder search_ecdr (search_results, search_index, search_valid);

//mux for read output selection
mux read_mux (read_value_mux, read_index,read_value);

assign read_valid = read_valid_logic;
assign search_valid = search_valid_logic;

//or the valid outputs of each word
always_comb begin
	read_valid_logic = | read_results[31:0];
	search_valid_logic = | search_results[31:0];
end

endmodule
