`timescale 1ns / 1ps
module F_C(clk,reset,PCSrcE,PCTargetE,PCplus1D,PC_D,InstrD);
//INPUT
input clk,
      reset,
      PCSrcE;
input [31:0]PCTargetE;
//OUTPUT
output [31:0]PCplus1D,PC_D,InstrD;
//WIRE
wire [31:0] PC_F_next,PCplus1F,PC_F,InstrF;
//REG
reg [31:0] PC_F_reg,PCplus1F_reg,InstrF_reg; 
           
    MUX mux(.PCPlus1F(PCplus1F),
            .PCTargetE(PCTargetE),
            .PCSrcE(PCSrcE),
            .PC_F_next(PC_F_next));
    PC pc(.clk(clk),
          .reset(reset),
          .PC_F_next(PC_F_next),
          .PC_F(PC_F));
    IM im(.reset(reset),.A(PC_F),.InstrF(InstrF));
    PC_ADDER pc_adder(.PC_F(PC_F),.b(1'b1),.PCplus1F(PCplus1F));
    
always @(posedge clk or negedge reset)begin
    if(reset==0)begin PC_F_reg=32'b0;
                      PCplus1F_reg=32'b0;
                      InstrF_reg=32'b0; end
    else begin  PC_F_reg=PC_F;
                PCplus1F_reg=PCplus1F;
                InstrF_reg=InstrF; end
end

assign PCplus1D=PCplus1F_reg;
assign PC_D=PC_F_reg;
assign InstrD=InstrF_reg;

endmodule
