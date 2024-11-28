`timescale 1ns / 1ps
module ADDER_E(PCD_E,imm_E,PCTargetE);
input [31:0]PCD_E,imm_E;
output [31:0]PCTargetE;
assign PCTargetE=PCD_E+imm_E;
endmodule
