`timescale 1ns / 1ps
module EXTEND(i_c,immsrc,imm_b_j,imm_l_i,imm_s,imm_u);
input [31:0]i_c;
input [2:0]immsrc;
output [31:0]imm_b_j,
             imm_l_i,
             imm_s,
             imm_u;
assign imm_b_j=(immsrc==3'b101)?{12'b0,i_c[31],i_c[19:12],i_c[20],i_c[30:21]}:    //jump imm
               (immsrc==3'b011)?{20'b0,i_c[31],i_c[7],i_c[30:25],i_c[11:8]}:32'b0;//branch imm
assign imm_l_i=(immsrc==3'b001)?{20'b0,i_c[31:20]}:32'b0;                         //load_i imm
assign imm_s=(immsrc==3'b010)?{20'b0,i_c[31:25],i_c[11:7]}:32'b0;                 //store imm
assign imm_u=(immsrc==3'b100)?{12'b0,i_c[31:12]}:32'b0;                           //u imm
endmodule
