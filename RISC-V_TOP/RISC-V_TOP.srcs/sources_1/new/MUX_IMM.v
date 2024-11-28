`timescale 1ns / 1ps
module MUX_IMM(imm_b_j_E,imm_u_E,AUIPC_E,imm_E);
input [31:0]imm_b_j_E,imm_u_E;
input AUIPC_E;
output [31:0]imm_E;
assign imm_E=(AUIPC_E==1)?imm_u_E:imm_b_j_E;
endmodule