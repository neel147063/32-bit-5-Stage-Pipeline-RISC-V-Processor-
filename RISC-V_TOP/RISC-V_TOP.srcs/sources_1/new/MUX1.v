`timescale 1ns / 1ps
module MUX1(ResultSrc_W,ALUResult_W,ReadData_W,ResultW);
input ResultSrc_W;
input [31:0]ALUResult_W,ReadData_W;
output [31:0]ResultW;
assign ResultW=(ResultSrc_W==1)?ReadData_W:ALUResult_W;
endmodule
