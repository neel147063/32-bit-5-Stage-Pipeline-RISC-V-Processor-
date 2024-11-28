`timescale 1ns / 1ps
module DM(clk,
          reset,
          ALUResult_M,
          WriteData_M,
          MemWrite_M,
          sh_M,sb_M,lh_M,lb_M,
          ReadData_M);
input clk,reset,MemWrite_M,sh_M,sb_M,lh_M,lb_M;
input [31:0]ALUResult_M,WriteData_M;//address,data
output reg [31:0]ReadData_M;
reg [31:0] dm[0:64];
integer i;
always @(posedge clk)begin
    if(reset==0)begin
        for(i=0;i<64;i=i+1)dm[i]=32'b0;
    end  
    else begin
        if (MemWrite_M==1)begin
            if(sh_M==1)begin dm[ALUResult_M]<={16'b0,WriteData_M[15:0]}; end
            else if(sb_M==1)begin dm[ALUResult_M]<={24'b0,WriteData_M[7:0]}; end
            else begin dm[ALUResult_M]<=WriteData_M; end
        end
        else if (MemWrite_M==0) begin 
            if(lh_M==1)ReadData_M<={16'b0,dm[ALUResult_M][15:0]};
            else if(lb_M==1)ReadData_M<={24'b0,dm[ALUResult_M][7:0]};
            else ReadData_M<=dm[ALUResult_M];
        end
    end
end
endmodule
