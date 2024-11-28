`timescale 1ns / 1ps
module E_C(clk,reset,regwrite_E,ALUsrc_E,memwrite_E,resultsrc_E,branch_E,jump_E,AUIPC_E,
           alu_control_E,RD_E,RD1_E,RD2_E,imm_b_j_E,imm_l_i_E,imm_s_E,imm_u_E,
           PCD_E,PCpluse1D_E,sh_E,sb_E,lh_E,lb_E,
           regwrite_M,memwrite_M,resultsrc_M,RD_M,WriteData_M,ALUresult_M,
           PCTargetE,PCSrcE,sh_M,sb_M,lh_M,lb_M);
//INPUT           
input clk,reset,sh_E,sb_E,lh_E,lb_E,
      regwrite_E,memwrite_E,resultsrc_E,//GO FOR MEMORY UNIT
      branch_E,jump_E,//GO FOR FETCH UNIT
      AUIPC_E;//GO IN THIS UNIT IN MUX_2_1 FOR IMM VALUE SELECTION 
input [1:0]ALUsrc_E;//GO IN THIS UNIT IN MUX_4_1 FOR IMM VALUE SELECTION
input [5:0]alu_control_E;//GO IN ALU 
input [4:0]RD_E;//GO FOR MEMORY UNIT
input [31:0]RD1_E,//GO FOR MUX_2_1
            RD2_E,imm_l_i_E,imm_s_E,//GO FOR MUX_4_1
            imm_u_E,//GO FOR MUX_4,2_1
            PCD_E,//GO FOR ADDER
            imm_b_j_E,//GO FOR MUX_2_1
            PCpluse1D_E;////GO FOR MEMORY UNIT
//OUTPUT
output regwrite_M,memwrite_M,resultsrc_M,PCSrcE,sh_M,sb_M,lh_M,lb_M;
output [4:0]RD_M;
output [31:0]WriteData_M,ALUresult_M;
output [31:0]PCTargetE;
//WIRE
wire zero_E,w0,PCSrcE;
wire [31:0]imm_E,srcBE,ALUresult_E;
//reg
reg regwrite_E_r,memwrite_E_r,resultsrc_E_r,sh_E_r,sb_E_r,lh_E_r,lb_E_r;
reg [4:0]RD_E_r;
reg [31:0]ALUresult_E_r,WriteData_E_r;

MUX_IMM mux_imm_2_1(.imm_b_j_E(imm_b_j_E),
                    .imm_u_E(imm_u_E),
                    .AUIPC_E(AUIPC_E),
                    .imm_E(imm_E));
ADDER_E adder_e(.PCD_E(PCD_E),
        .imm_E(imm_E),
        .PCTargetE(PCTargetE));
MUX_SRCBE srcbE(.RD2_E(RD2_E),
          .imm_u_E(imm_u_E),
          .imm_l_i_E(imm_l_i_E),
          .imm_s_E(imm_s_E),
          .ALUsrc_E(ALUsrc_E),
          .srcBE(srcBE));
ALU alu(.srcAE(RD1_E),
        .srcBE(srcBE),
        .alu_control_E(alu_control_E),
        .zero_E(zero_E),
        .result_E(ALUresult_E)); 
and a0(w0,zero_E,branch_E);
or o0(PCSrcE,w0,jump_E);
always @(posedge clk)begin
    if(reset==0)begin
        regwrite_E_r<=0;
        memwrite_E_r<=0;
        resultsrc_E_r<=0;
        RD_E_r<=0;
        WriteData_E_r<=0;
        ALUresult_E_r<=0;
        sh_E_r<=0;
        sb_E_r<=0;
        lh_E_r<=0;
        lb_E_r<=0;
    end
    else begin
        regwrite_E_r<=regwrite_E;
        memwrite_E_r<=memwrite_E;
        resultsrc_E_r<=resultsrc_E;
        RD_E_r<=RD_E;
        WriteData_E_r<=RD2_E;
        ALUresult_E_r<=ALUresult_E;
        sh_E_r<=sh_E;
        sb_E_r<=sb_E;
        lh_E_r<=lh_E;
        lb_E_r<=lb_E;
    end
end
assign regwrite_M=regwrite_E_r;
assign memwrite_M=memwrite_E_r;
assign resultsrc_M=resultsrc_E_r;
assign RD_M=RD_E_r;
assign WriteData_M=WriteData_E_r;
assign ALUresult_M=ALUresult_E_r; 
assign sh_M=sh_E_r;
assign lh_M=lh_E_r;
assign sb_M=sb_E_r;
assign lb_M=lb_E_r;               
endmodule
