`timescale 1ns / 1ps
module D_C(clk,reset,InstrD,PCD,PCplus1D,WE3,RdW,ResultW,
           regwrite_E,ALUsrc_E,memwrite_E,resultsrc_E,branch_E,jump_E,AUIPC_E,
           alu_control_E,RD_E,RD1_E,RD2_E,imm_b_j_E,imm_l_i_E,imm_s_E,imm_u_E,
           PCD_E,sh_E,sb_E,lh_E,lb_E);
//input 
input [31:0]InstrD,PCD,PCplus1D,ResultW;
input [4:0]RdW;
input WE3,clk,reset;
//output
output regwrite_E,memwrite_E,resultsrc_E,branch_E,jump_E,AUIPC_E,sh_E,sb_E,lh_E,lb_E;
output [1:0]ALUsrc_E;
output [5:0]alu_control_E;
output [4:0]RD_E;//rd address
output [31:0]RD1_E,RD2_E,imm_b_j_E,imm_l_i_E,imm_s_E,imm_u_E,
             PCD_E; 
//wire
wire regwrite,memwrite,resultsrc,branch,jump,AUIPC,sh_D,
     sb_D,lh_D,lb_D;
wire [1:0]ALUsrc;
wire [2:0]immsrc;
wire [5:0]alu_control;
wire [31:0]RD1,RD2,imm_b_j,imm_l_i,imm_s,imm_u,PCplus1_D;
//register
reg regwrite_r,memwrite_r,resultsrc_r,branch_r,jump_r,AUIPC_r,sh_D_r,
    sb_D_r,lh_D_r,lb_D_r;
reg [5:0]alu_control_r;
reg [1:0]ALUsrc_r;
reg [4:0] RD_r;//rd address
reg [31:0]RD1_r,RD2_r,imm_b_j_r,imm_l_i_r,imm_s_r,imm_u_r,
          PCD_r;

CU cu(.op(InstrD[6:0]),
      .fun7(InstrD[31:25]),
      .fun3(InstrD[14:12]),
      .alu_control(alu_control),
      .regwrite(regwrite),
      .ALUsrc(ALUsrc),
      .memwrite(memwrite),
      .resultsrc(resultsrc),
      .branch(branch),
      .jump(jump),
      .immsrc(immsrc),
      .AUIPC(AUIPC),
      .sh_D(sh_D),
      .sb_D(sb_D),
      .lh_D(lh_D),
      .lb_D(lb_D));
      
RF rf(.clk(clk),
      .reset(reset),
      .a1(InstrD[19:15]),
      .a2(InstrD[24:20]),
      .a3(RdW),
      .WD3(ResultW),
      .RD1(RD1),
      .RD2(RD2),
      .WE3(WE3));
EXTEND extend(.i_c(InstrD),
              .immsrc(immsrc),
              .imm_b_j(imm_b_j),
              .imm_l_i(imm_l_i),
              .imm_s(imm_s),
              .imm_u(imm_u));
always @(posedge clk)begin
    if(reset==0)begin
       regwrite_r<=0;
       ALUsrc_r<=0;
       memwrite_r<=0;
       resultsrc_r<=0;
       branch_r<=0;
       jump_r<=0;
       AUIPC_r<=0; 
       alu_control_r<=0;
       RD_r<=0;
       RD1_r=0;
       RD2_r=0;
       imm_b_j_r=0;
       imm_l_i_r=0;
       imm_s_r<=0;
       imm_u_r<=0;
       PCD_r<=0;
       sh_D_r<=0;
       sb_D_r<=0;
       lh_D_r<=0;
       lb_D_r<=0;
    end
    else begin
       regwrite_r<=regwrite;
       ALUsrc_r<=ALUsrc;
       memwrite_r<=memwrite;
       resultsrc_r<=resultsrc;
       branch_r<=branch;
       jump_r<=jump;
       AUIPC_r<=AUIPC; 
       alu_control_r<=alu_control[5:0];
       RD_r<=InstrD[11:7];
       RD1_r=RD1;
       RD2_r=RD2;
       imm_b_j_r=imm_b_j;
       imm_l_i_r=imm_l_i;
       imm_s_r<=imm_s;
       imm_u_r<=imm_u;
       PCD_r<=PCD;
       sh_D_r<=sh_D;
       sb_D_r<=sb_D;
       lh_D_r<=lh_D;
       lb_D_r<=lb_D;
    end
end
assign regwrite_E=regwrite_r;
assign ALUsrc_E=ALUsrc_r;
assign memwrite_E=memwrite_r;
assign resultsrc_E=resultsrc_r;
assign branch_E=branch_r;
assign jump_E=jump_r;
assign AUIPC_E=AUIPC_r;
assign alu_control_E=alu_control_r;
assign RD_E=RD_r;
assign RD1_E=RD1_r;
assign RD2_E=RD2_r;
assign imm_b_j_E=imm_b_j_r;
assign imm_l_i_E=imm_l_i_r;
assign imm_s_E=imm_s_r;
assign imm_u_E=imm_u_r;
assign PCD_E=PCD_r;
assign sh_E=sh_D_r;
assign sb_E=sb_D_r;
assign lh_E=lh_D_r;
assign lb_E=lb_D_r;
endmodule
