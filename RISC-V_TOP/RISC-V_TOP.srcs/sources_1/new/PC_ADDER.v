`timescale 1ns / 1ps
module PC_ADDER(PC_F,b,PCplus1F);
input b;
input [31:0]PC_F;
output [31:0]PCplus1F;
assign PCplus1F=PC_F+b;
endmodule
