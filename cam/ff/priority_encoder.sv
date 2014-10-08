
module priority_encoder(
        inp_i,
        out_o,
        valid_o
);

        input [31:0] inp_i;
        output logic [4:0] out_o;
        output logic valid_o;

        always_comb begin
                casex (inp_i)
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxx1: out_o=5'd0;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xx10: out_o=5'd1;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x100: out_o=5'd2;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_1000: out_o=5'd3;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxx1_0000: out_o=5'd4;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xx10_0000: out_o=5'd5;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x100_0000: out_o=5'd6;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_1000_0000: out_o=5'd7;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxx1_0000_0000: out_o=5'd8;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_xx10_0000_0000: out_o=5'd9;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_x100_0000_0000: out_o=5'd10;
                        32'bxxxx_xxxx_xxxx_xxxx_xxxx_1000_0000_0000: out_o=5'd11;
                        32'bxxxx_xxxx_xxxx_xxxx_xxx1_0000_0000_0000: out_o=5'd12;
                        32'bxxxx_xxxx_xxxx_xxxx_xx10_0000_0000_0000: out_o=5'd13;
                        32'bxxxx_xxxx_xxxx_xxxx_x100_0000_0000_0000: out_o=5'd14;
                        32'bxxxx_xxxx_xxxx_xxxx_1000_0000_0000_0000: out_o=5'd15;
                        32'bxxxx_xxxx_xxxx_xxx1_0000_0000_0000_0000: out_o=5'd16;
                        32'bxxxx_xxxx_xxxx_xx10_0000_0000_0000_0000: out_o=5'd17;
                        32'bxxxx_xxxx_xxxx_x100_0000_0000_0000_0000: out_o=5'd18;
                        32'bxxxx_xxxx_xxxx_1000_0000_0000_0000_0000: out_o=5'd19;
                        32'bxxxx_xxxx_xxx1_0000_0000_0000_0000_0000: out_o=5'd20;
                        32'bxxxx_xxxx_xx10_0000_0000_0000_0000_0000: out_o=5'd21;
                        32'bxxxx_xxxx_x100_0000_0000_0000_0000_0000: out_o=5'd22;
                        32'bxxxx_xxxx_1000_0000_0000_0000_0000_0000: out_o=5'd23;
                        32'bxxxx_xxx1_0000_0000_0000_0000_0000_0000: out_o=5'd24;
                        32'bxxxx_xx10_0000_0000_0000_0000_0000_0000: out_o=5'd25;
                        32'bxxxx_x100_0000_0000_0000_0000_0000_0000: out_o=5'd26;
                        32'bxxxx_1000_0000_0000_0000_0000_0000_0000: out_o=5'd27;
                        32'bxxx1_0000_0000_0000_0000_0000_0000_0000: out_o=5'd28;
                        32'bxx10_0000_0000_0000_0000_0000_0000_0000: out_o=5'd29;
                        32'bx100_0000_0000_0000_0000_0000_0000_0000: out_o=5'd30;
	  	        32'b1000_0000_0000_0000_0000_0000_0000_0000: out_o=5'd31;
                        default: out_o=5'd0;
                endcase

                if (inp_i == 32'd0) begin
                        valid_o = 1'b0;
                end

                else begin
                        valid_o = 1'b1;
                end
        end

endmodule
