`timescale 1ns / 1ps
module W_B_C(ResultSrc_W,ALUResult_W,ReadData_W,ResultW);
input ResultSrc_W;
input [31:0]ALUResult_W,ReadData_W;
//OUTPUT
output [31:0]ResultW;

MUX1 mux(.ResultSrc_W(ResultSrc_W),
        .ALUResult_W(ALUResult_W),
        .ReadData_W(ReadData_W),
        .ResultW(ResultW));
endmodule
