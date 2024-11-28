`timescale 1ns / 1ps
module RF(clk,reset,a1,a2,a3,WD3,RD1,RD2,WE3);
input WE3,clk,reset;
input [4:0]a1,a2,a3;
input [31:0]WD3;
output [31:0]RD1,RD2;
    reg[31:0] reg_mem[31:0];
    assign RD1=reg_mem[a1];
    assign RD2=reg_mem[a2];
    integer i;
    always @(posedge clk)begin
        if(reset==0)begin for(i=0;i<32;i=i+1)reg_mem[i]<=32'b0; end
        else if(WE3==1)begin reg_mem[a3]<=WD3; end
    end    
endmodule
