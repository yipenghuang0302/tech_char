module mux (data_i, select_i, data_o); 
 input [31:0][31:0] data_i;
 input [4:0] select_i; 
 output logic [31:0] data_o; 
 always_comb begin
 case(select_i) 
 5'd0: data_o = data_i[0];
 5'd1: data_o = data_i[1];
 5'd2: data_o = data_i[2];
 5'd3: data_o = data_i[3];
 5'd4: data_o = data_i[4];
 5'd5: data_o = data_i[5];
 5'd6: data_o = data_i[6];
 5'd7: data_o = data_i[7];
 5'd8: data_o = data_i[8];
 5'd9: data_o = data_i[9];
 5'd10: data_o = data_i[10];
 5'd11: data_o = data_i[11];
 5'd12: data_o = data_i[12];
 5'd13: data_o = data_i[13];
 5'd14: data_o = data_i[14];
 5'd15: data_o = data_i[15];
 5'd16: data_o = data_i[16];
 5'd17: data_o = data_i[17];
 5'd18: data_o = data_i[18];
 5'd19: data_o = data_i[19];
 5'd20: data_o = data_i[20];
 5'd21: data_o = data_i[21];
 5'd22: data_o = data_i[22];
 5'd23: data_o = data_i[23];
 5'd24: data_o = data_i[24];
 5'd25: data_o = data_i[25];
 5'd26: data_o = data_i[26];
 5'd27: data_o = data_i[27];
 5'd28: data_o = data_i[28];
 5'd29: data_o = data_i[29];
 5'd30: data_o = data_i[30];
 5'd31: data_o = data_i[31]; 
 endcase 
 end 
endmodule 
