module cam_word(
clk,
reset,
read,
dec_read_index,
write,
dec_write_index,
write_data,
search,
search_data,
search_results,
read_results,
read_value
); 
//inputs to each word
input clk;
input reset;
input read;
input dec_read_index;
input write;
input dec_write_index;
input [31:0] write_data;
input search;
input [31:0] search_data;

//outputs
output search_results;
output read_results;
output [31:0] read_value;

//for data output and input as well as valid bits
logic [31:0] data_i;
logic [31:0] data_o;
logic valid_i;
logic valid_o;
logic search_results_logic;
logic read_results_logic;
logic [31:0] data_i_logic;
logic valid_i_logic; 

//flip-flop array
FF #(.WIDTH(32)) data_ff (clk, data_i, data_o);
//valid bit flip-flop
FF valid_ff (clk, valid_i, valid_o);

//assign logic 
assign read_value = data_o;
assign read_results = read_results_logic;
assign search_results = search_results_logic;
assign data_i = data_i_logic;
assign valid_i = valid_i_logic;


always_comb begin
//test search match
	if (search == 1'b1 && search_data == data_o) begin
		search_results_logic = 1'b1;
	end else begin
		search_results_logic = 1'b0;
	end

//test for read and the correct signal from the decoder

	if (read && dec_read_index && valid_o) begin
		read_results_logic = 1'b1;
	end else begin
		read_results_logic = 1'b0;
	end

//test for reset and writes:

	if (reset == 1'b1) begin
		valid_i_logic = 1'b0;
		data_i_logic = 32'd0;
	end else if(dec_write_index == 1'b1 && write) begin
	//if this word is being selected and the write signal is on
		data_i_logic = write_data;
		valid_i_logic = 1'b1;
		//make the valid bit 1 when write occurs
	end else begin
	//if not being written to, send old data back to the ff
		data_i_logic = data_o;
                valid_i_logic = valid_o;
	end	

end
endmodule
