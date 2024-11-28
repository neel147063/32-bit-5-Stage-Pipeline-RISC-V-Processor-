`timescale 1ns / 1ps
module M_C(clk,reset,ALUResult_M,WriteData_M,MemWrite_M,RD_M,RegWrite_M,ResultSrc_M,sh_M,sb_M,lh_M,lb_M,
           RegWrite_W,ResultSrc_W,RD_W,ALUResult_W,ReadData_M);
//INPUT
input clk,reset,MemWrite_M,RegWrite_M,ResultSrc_M,sh_M,sb_M,lh_M,lb_M;
input [4:0]RD_M;
input [31:0]ALUResult_M,WriteData_M;
//OUTPUT
output RegWrite_W,ResultSrc_W;
output [4:0]RD_W;
output [31:0]ALUResult_W,ReadData_M;
 
//REG
reg RegWrite_M_r,ResultSrc_M_r;
reg [4:0]RD_M_r;
reg [31:0]ALUResult_M_r;

DM dm(.clk(clk),
      .reset(reset),
      .ALUResult_M(ALUResult_M),
      .WriteData_M(WriteData_M),
      .MemWrite_M(MemWrite_M),
      .ReadData_M(ReadData_M),
      .sh_M(sh_M),
      .sb_M(sb_M),
      .lh_M(lh_M),
      .lb_M(lb_M));

always @(posedge clk)begin
    if(reset==0)begin
        RegWrite_M_r<=0;
        ResultSrc_M_r<=0;
        RD_M_r<=0;
        ALUResult_M_r<=0;
    end
    else begin
        RegWrite_M_r<=RegWrite_M;
        ResultSrc_M_r<=ResultSrc_M;
        RD_M_r<=RD_M;
        ALUResult_M_r<=ALUResult_M;
    end
end
assign RegWrite_W=RegWrite_M_r;
assign ResultSrc_W=ResultSrc_M_r;
assign RD_W=RD_M_r;
assign ALUResult_W=ALUResult_M_r;  
endmodule
