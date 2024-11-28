`timescale 1ns / 1ps
module main_decoder(op,
                    fun3,
                    regwrite,
                    ALUsrc,
                    memwrite,
                    resultsrc,
                    branch,
                    jump,
                    immsrc,
                    AUIPC,
                    sh_D,
                    sb_D,
                    lh_D,
                    lb_D);

input [6:0]op;
input [2:0]fun3;
output regwrite,
       memwrite,
       resultsrc,
       branch,
       jump,
       AUIPC,
       sh_D,
       sb_D,
       lh_D,
       lb_D;
output [1:0]ALUsrc;
output [2:0]immsrc;

assign resultsrc=(op==7'b0000011)?1:0;//load instruction 1 from memory 0 from alu
assign regwrite=(op==7'b0000011|op==7'b0110011|op==7'b0010011|op==7'b0110111)?1:0;//load,r,i instruction
assign memwrite=(op==7'b0100011)?1:0;//store instruction
assign ALUsrc=(op==7'b0100011)?2'b11:(op==7'b0000011)?2'b10:(op==7'b0010011)?2'b10:(op==7'b0110111)?2'b01:2'b00;//load,store,i instruction
assign AUIPC=(op==7'b0010111)?1:0;
assign branch=(op==7'b1100011)?1:0;//branch instruction
assign sh_D=(op==7'b0100011&& fun3==3'b001)?1:0;
assign sb_D=(op==7'b0100011&& fun3==3'b000)?1:0;
assign lh_D=(op==7'b0000011&& fun3==3'b001)?1:0;
assign lb_D=(op==7'b0000011&& fun3==3'b000)?1:0; 
assign jump=(op==7'b1101111|op==7'b0010111)?1:0;//jump instruction
assign immsrc=(op==7'b0010011||op==7'b0000011)?3'b001:               //i,load
              (op==7'b0100011)?3'b010:                              //s
              (op==7'b1100011)?3'b011:                              //b
              (op==7'b0110111)?3'b100:
              (op==7'b0010111)?3'b100:                              //u
              (op==7'b1101111)?3'b101:3'b000;                        //j
              
endmodule
