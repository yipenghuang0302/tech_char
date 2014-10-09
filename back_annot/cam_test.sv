module cam_test();


//make inputs
reg reset;
reg clk;
reg read;

reg [4:0] read_index;
reg write;
reg [4:0] write_index;
reg [31:0] write_data;
reg search;
reg [31:0] search_data;

//outputs
logic read_valid;
logic [31:0] read_value;
logic search_valid;
logic [4:0] search_index;

//make cam
cam my_cam (reset, clk, read,read_index,write,write_index,write_data,search,search_data,read_valid,read_value,search_valid, search_index);

//set clk
initial clk = 0;
always #5 clk =~clk;

initial begin
	$vcdpluson;

	$sdf_annotate("cam_synth.sdf", cam);

//load initial values:

	write_index = 5'd0;
	write_data = 32'd0;
	#10
	write = 1'b1;
	#10
	write = 0'b0;
	
	
        write_index = 5'd1;
        write_data = 32'd1;
        #10
	write = 1'b1;
	#10
        write = 0'b0;
	

        write_index = 5'd2;
        write_data = 32'd1;
	#10
	write = 1'b1;
        #10
        write = 0'b0;


        write_index = 5'd3;
        write_data = 32'd3;
        #10
	write = 1'b1;
	#10
        write = 0'b0;	

//read initial values:

	read_index = 5'd0;
	#10
	read = 1'b1;
	#5 $display("read at 0 is %d, expected 0, is valid: %d, expected 1\n",read_value,read_valid);
	read = 1'b0;
	#10

	read_index = 5'd1;
	#10
	read = 1'b1;
        #5 $display("read at 1 is %d, expected 1, is valid: %d, expected 1\n",read_value,read_valid);
	read = 1'b0;
        #10


	read_index = 5'd2;
	#10
	read = 1'b1;
        #5 $display("read at 2 is %d, expected 1, is valid: %d, expected 1\n",read_value,read_valid);
	read = 1'b0;
        #10


	read_index = 5'd3;
	#10
	read = 1'b1;
        #5 $display("read at 3 is %d, expected 3, is valid: %d, expected 1\n",read_value,read_valid);
	read = 1'b0;
        #10

	read_index = 5'd4;
        #10
        read = 1'b1;
        #5 $display("read at 4 is %d, no expected, is valid: %d, expected 0\n",read_value,read_valid);
        read = 1'b0;
        #10

//search values:
	
	search_data = 32'd0;
	#10
	search = 1'b1;
	#5 $display("search for 0, expected at 0, found at: %d, should be valid, is valid: %b\n",search_index,search_valid);
        search = 1'b0;
	#10


	search_data = 32'd1;
	#10
        search = 1'b1;
	#5 $display("search for 1, expected at 1, found at: %d, should be valid, is valid: %b\n",search_index,search_valid);
        search = 1'b0;
        #10


	search_data = 32'd3;
	#10
        search = 1'b1;
	#5 $display("search for 3, expected at 3, found at: %d, should be valid, is valid: %b\n",search_index,search_valid);
        search = 1'b0;
        #10


	search_data = 32'd2;
	#10
        search = 1'b1;
	#5 $display("search for 2, found at: %b, should NOT be valid, is valid: %b\n",search_index,search_valid);
        search = 1'b0;
        #10

//simultaneous cases:

        search_data = 32'd3;
        read_index = 5'd3;
        write_index = 5'd3;
        write_data = 32'd4;

        #12

        read = 1'b1;
        search = 1'b1;
        write = 1'b1;

        #2 $display("simultaneous search, read, write:\n search for 3, expected at 3 found at: %d, should be valid, is valid: %d\nread index 3, expect 3, found: %d, expect valid, found:%d\n",search_index,search_valid,read_value,read_valid);
	#5//wait one cycle for write to register
	search_data = 32'd4;
	$display("simultaneous search and read:\n search for 4, expected at 3 found at: %d, should be valid, is valid: %d\nread index 3, expect 4, found: %d, expect valid, found:%d\n",search_index,search_valid,read_value,read_valid);

	#10
	search_data = 32'd0;
        read_index = 5'd1;
        write_index = 5'd2;
        write_data = 32'd4;

        #12

        read = 1'b1;
        search = 1'b1;
        write = 1'b1;

        #2 $display("simultaneous search, read, write:\n search for 0, expected at 0 found at: %d, should be valid, is valid: %d\nread index 1, expect 1, found: %d, expect valid, found:%d\n",search_index,search_valid,read_value,read_valid);

        #5//wait one cycle for write to register
        search_data = 32'd4;

        #2 $display("simultaneous search and read:\n search for 4, expected at 2 found at: %d, should be valid, is valid: %d\nread index 1, expect 1, found: %d, expect valid, found:%d\n",search_index,search_valid,read_value,read_valid);

	#2
	write = 1'b0;
	search = 1'b0;
	read = 1'b0;

//reset:
	#10
	reset = 1'b1;
	#10
	reset = 1'b0;
	#10

//read reset values:

	read_index = 5'd0;
        #10
        read = 1'b1;
        #5 $display("output at 0 is %d, expected 0, is valid: %d, expected 0\n",read_value,read_valid);
        read = 1'b0;
        #10

        read_index = 5'd1;
        #10
        read = 1'b1;
        #5 $display("output at 1 is %d, expected 0, is valid: %d, expected 0\n",read_value,read_valid);
        read = 1'b0;
        #10


        read_index = 5'd2;
        #10
        read = 1'b1;
        #5 $display("output at 2 is %d, expected 0, is valid: %d, expected 0\n",read_value,read_valid);
        read = 1'b0;
        #10


        read_index = 5'd3;
        #10
        read = 1'b1;
        #5 $display("output at 3 is %d, expected 0, is valid: %d, expected 0\n",read_value,read_valid);
        read = 1'b0;
        #10

        read_index = 5'd4;
        #10
        read = 1'b1;
        #5 $display("output at 4 is %d, no expected, is valid: %d, expected 0\n",read_value,read_valid);
        read = 1'b0;
        #10


$finish;
end
endmodule
