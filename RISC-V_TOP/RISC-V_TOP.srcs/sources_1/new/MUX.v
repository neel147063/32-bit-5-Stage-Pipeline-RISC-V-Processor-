`timescale 1ns / 1ps
module MUX(PCPlus1F,PCTargetE,PCSrcE,PC_F_next);
input [31:0]PCPlus1F,PCTargetE;
input PCSrcE;
output [31:0]PC_F_next;
assign PC_F_next=(PCSrcE==1)?PCTargetE:PCPlus1F;
endmodule
