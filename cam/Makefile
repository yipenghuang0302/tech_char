DUV=cam
TEST=cam_test
BENCH=test


all: 
	make clean
	make test
	make view

test:
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(DUV).sv $(TEST).sv cam_word.sv decoder_5_32.sv priority_encoder.sv FF.sv mux.sv -o $(BENCH)
	./$(BENCH)
	
view:
	vpd2vcd vcdplus.vpd vcdplus.vcd &
	gtkwave vcdplus.vcd &
leda:
	leda -full64 -sverilog -top $(DUV) $(DUV).sv
	
clean:
	rm -rf csrc *.exe.daidir *.exe *.log *.inf .leda_work *.key *.vpd *.vcd DVEfiles
