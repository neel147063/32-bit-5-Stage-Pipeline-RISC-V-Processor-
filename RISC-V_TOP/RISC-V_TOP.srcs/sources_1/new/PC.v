`timescale 1ns / 1ps
module PC(clk,reset,PC_F_next,PC_F);
    input clk;
    input reset;
    input [31:0]PC_F_next;
    output reg [31:0]PC_F;
    always @(posedge clk)begin
        if(reset==0) begin PC_F<=32'b0; end
        else begin PC_F<=PC_F_next; end
    end
endmodule
