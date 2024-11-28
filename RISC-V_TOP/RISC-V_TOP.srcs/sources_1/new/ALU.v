`timescale 1ns / 1ps
module ALU(srcAE,srcBE,alu_control_E,zero_E,result_E);
input [31:0]srcAE,srcBE;
input [5:0]alu_control_E;
output zero_E;
output [31:0]result_E;

assign result_E = 
    // R-type instructions
    (alu_control_E == 6'b000001) ? srcAE + srcBE :           // ADD
    (alu_control_E == 6'b000010) ? srcAE - srcBE :           // SUB
    (alu_control_E == 6'b000011) ? srcAE & srcBE :           // AND
    (alu_control_E == 6'b000100) ? srcAE | srcBE :           // OR
    (alu_control_E == 6'b000101) ? srcAE ^ srcBE :           // XOR
    (alu_control_E == 6'b000110) ? srcAE << srcBE[4:0] :     // SLL
    (alu_control_E == 6'b000111) ? srcAE >> srcBE[4:0] :     // SRL
    (alu_control_E == 6'b001000) ? $signed(srcAE) >>> srcBE[4:0] : // SRA

    // I-type instructions
    (alu_control_E == 6'b001001) ? srcAE + srcBE :           // LB (address calculation)
    (alu_control_E == 6'b001010) ? srcAE + srcBE :           // LH (address calculation)
    (alu_control_E == 6'b001011) ? srcAE + srcBE :           // LW (address calculation)
    (alu_control_E == 6'b001100) ? srcAE + srcBE :           // LBU (address calculation)
    (alu_control_E == 6'b001101) ? srcAE + srcBE :           // LHU (address calculation)
    (alu_control_E == 6'b001110) ? srcAE + srcBE :           // ADDI
    (alu_control_E == 6'b001111) ? ((srcAE < srcBE) ? 1 : 0) : // SLTI
    (alu_control_E == 6'b010000) ? ((srcAE < srcBE) ? 1 : 0) : // SLTIU (unsigned comparison)
    (alu_control_E == 6'b010001) ? srcAE ^ srcBE :           // XORI
    (alu_control_E == 6'b010010) ? srcAE | srcBE :           // ORI
    (alu_control_E == 6'b010011) ? srcAE & srcBE :           // ANDI

    // S-type instructions (stores)
    (alu_control_E == 6'b010100) ? srcAE + srcBE :           // SB (address calculation)
    (alu_control_E == 6'b010101) ? srcAE + srcBE :           // SH (address calculation)
    (alu_control_E == 6'b010110) ? srcAE + srcBE :           // SW (address calculation)

    // U-type instructions
    (alu_control_E == 6'b011110) ? srcBE :    // LUI (load upper immediate)
    
    // Default case if no match
    32'b0;
assign zero_E=// B-type instructions (branches)
    (alu_control_E == 6'b010111) ? ((srcAE == srcBE) ? 1 : 0) : // BEQ
    (alu_control_E == 6'b011000) ? ((srcAE != srcBE) ? 1 : 0) : // BNE
    (alu_control_E == 6'b011001) ? (($signed(srcAE) < $signed(srcBE)) ? 1 : 0) : // BLT
    (alu_control_E == 6'b011010) ? (($signed(srcAE) >= $signed(srcBE)) ? 1 : 0) : // BGE
    (alu_control_E == 6'b011011) ? ((srcAE < srcBE) ? 1 : 0) : // BLTU
    (alu_control_E == 6'b011100) ? ((srcAE >= srcBE) ? 1 : 0) :0; // BGEU
    
endmodule
