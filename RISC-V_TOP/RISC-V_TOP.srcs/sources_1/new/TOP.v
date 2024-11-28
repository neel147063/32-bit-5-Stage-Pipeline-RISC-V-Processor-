`timescale 1ns / 1ps
module TOP(clk,reset);
input clk,reset;
//FC
wire [31:0]PCplus1D,PC_D,InstrD;
//DC
wire regwrite_E,memwrite_E,resultsrc_E,branch_E,jump_E,AUIPC_E;
wire [1:0]ALUsrc_E;
wire [5:0]alu_control_E;
wire [4:0]RD_E;//rd address
wire [31:0]RD1_E,RD2_E,imm_b_j_E,imm_l_i_E,imm_s_E,imm_u_E,
             PCD_E,PCplus1_E,sh_E,sb_E,lh_E,lb_E;
//EC
wire regwrite_M,memwrite_M,resultsrc_M,PCSrcE,sh_M,sb_M,lh_M,lb_M;
wire [4:0]RD_M;
wire [31:0]WriteData_M,PCplus1_M,ALUresult_M;
wire [31:0]PCTargetE;
//MC
wire RegWrite_W,ResultSrc_W;
wire [4:0]RD_W;
wire [31:0]ALUResult_W,ReadData_M;
//WBC
wire [31:0]ResultW;

F_C fc(.clk(clk),
       .reset(reset),
       .PCSrcE(PCSrcE),
       .PCTargetE(PCTargetE),
       .PCplus1D(PCplus1D),
       .PC_D(PC_D),
       .InstrD(InstrD));
D_C dc(.clk(clk),
       .reset(reset),
       .InstrD(InstrD),
       .PCD(PC_D),
       .PCplus1D(PCplus1D),
       .WE3(RegWrite_W),
       .RdW(RD_W),
       .ResultW(ResultW),
       .regwrite_E(regwrite_E),
       .ALUsrc_E(ALUsrc_E),
       .memwrite_E(memwrite_E),
       .resultsrc_E(resultsrc_E),
       .branch_E(branch_E),
       .jump_E(jump_E),
       .AUIPC_E(AUIPC_E),
       .alu_control_E(alu_control_E),
       .RD_E(RD_E),
       .RD1_E(RD1_E),
       .RD2_E(RD2_E),
       .imm_b_j_E(imm_b_j_E),
       .imm_l_i_E(imm_l_i_E),
       .imm_s_E(imm_s_E),
       .imm_u_E(imm_u_E),
       .PCD_E(PCD_E),
       .sh_E(sh_E),
       .sb_E(sb_E),
       .lh_E(lh_E),
       .lb_E(lb_E));

E_C ec(.clk(clk),
       .reset(reset),
       .regwrite_E(regwrite_E),
       .ALUsrc_E(ALUsrc_E),
       .sh_E(sh_E),
       .sb_E(sb_E),
       .lh_E(lh_E),
       .lb_E(lb_E),
       .memwrite_E(memwrite_E),
       .resultsrc_E(resultsrc_E),
       .branch_E(branch_E),
       .jump_E(jump_E),
       .AUIPC_E(AUIPC_E),
       .alu_control_E(alu_control_E),
       .RD_E(RD_E),
       .RD1_E(RD1_E),
       .RD2_E(RD2_E),
       .imm_b_j_E(imm_b_j_E),
       .imm_l_i_E(imm_l_i_E),
       .imm_s_E(imm_s_E),
       .imm_u_E(imm_u_E),
       .PCD_E(PCD_E),
       .regwrite_M(regwrite_M),
       .memwrite_M(memwrite_M),
       .resultsrc_M(resultsrc_M),
       .RD_M(RD_M),
       .WriteData_M(WriteData_M),
       .ALUresult_M(ALUresult_M),
       .PCTargetE(PCTargetE),
       .PCSrcE(PCSrcE),
       .sh_M(sh_M),
       .sb_M(sb_M),
       .lh_M(lh_M),
       .lb_M(lb_M));
       
M_C mc(.clk(clk),
       .reset(reset),
       .ALUResult_M(ALUresult_M),
       .WriteData_M(WriteData_M),
       .MemWrite_M(memwrite_M),
       .RD_M(RD_M),
       .RegWrite_M(regwrite_M),
       .ResultSrc_M(resultsrc_M),
       .sh_M(sh_M),
       .sb_M(sb_M),
       .lh_M(lh_M),
       .lb_M(lb_M),
       .RegWrite_W(RegWrite_W),
       .ResultSrc_W(ResultSrc_W),
       .RD_W(RD_W),
       .ALUResult_W(ALUResult_W),
       .ReadData_M(ReadData_M));
       
W_B_C wbc(.ResultSrc_W(ResultSrc_W),
          .ALUResult_W(ALUResult_W),
          .ReadData_W(ReadData_M),
          .ResultW(ResultW));

endmodule
