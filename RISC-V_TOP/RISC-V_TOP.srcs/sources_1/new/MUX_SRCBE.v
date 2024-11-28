`timescale 1ns / 1ps
module MUX_SRCBE(RD2_E,imm_u_E,imm_l_i_E,imm_s_E,ALUsrc_E,srcBE);
input [31:0]RD2_E,imm_u_E,imm_l_i_E,imm_s_E;
inout [1:0]ALUsrc_E;
output [31:0]srcBE;
assign srcBE=(ALUsrc_E==2'b00)?RD2_E:
             (ALUsrc_E==2'b01)?imm_u_E:
             (ALUsrc_E==2'b10)?imm_l_i_E:
             (ALUsrc_E==2'b11)?imm_s_E:32'b0;
endmodule