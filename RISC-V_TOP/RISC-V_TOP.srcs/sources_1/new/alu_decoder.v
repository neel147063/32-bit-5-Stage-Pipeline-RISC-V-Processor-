`timescale 1ns / 1ps
module alu_decoder(op,
                   fun3,
                   fun7,
                   alu_control);                 
input [6:0]op,
           fun7;
input [2:0]fun3;
output [5:0]alu_control;

assign alu_control = 
    // R-type instructions
    (op == 7'b0110011 && fun7 == 7'b0000000 && fun3 == 3'b000) ? 6'b000001 : // ADD
    (op == 7'b0110011 && fun7 == 7'b0100000 && fun3 == 3'b000) ? 6'b000010 : // SUB
    (op == 7'b0110011 && fun7 == 7'b0000000 && fun3 == 3'b111) ? 6'b000011 : // AND
    (op == 7'b0110011 && fun7 == 7'b0000000 && fun3 == 3'b110) ? 6'b000100 : // OR
    (op == 7'b0110011 && fun7 == 7'b0000000 && fun3 == 3'b100) ? 6'b000101 : // XOR
    (op == 7'b0110011 && fun7 == 7'b0000000 && fun3 == 3'b001) ? 6'b000110 : // SLL
    (op == 7'b0110011 && fun7 == 7'b0000000 && fun3 == 3'b101) ? 6'b000111 : // SRL
    (op == 7'b0110011 && fun7 == 7'b0100000 && fun3 == 3'b101) ? 6'b001000 : // SRA

    // I-type instructions (e.g., Load instructions and immediate ALU operations)
    (op == 7'b0000011 & fun3 == 3'b000) ? 6'b001001 : // LB
    (op == 7'b0000011 && fun3 == 3'b001) ? 6'b001010 : // LH
    (op == 7'b0000011 && fun3 == 3'b010) ? 6'b001011 : // LW
    (op == 7'b0000011 && fun3 == 3'b100) ? 6'b001100 : // LBU
    (op == 7'b0000011 && fun3 == 3'b101) ? 6'b001101 : // LHU
    (op == 7'b0010011 & fun3 == 3'b000) ? 6'b001110 : // ADDI
    (op == 7'b0010011 && fun3 == 3'b010) ? 6'b001111 : // SLTI
    (op == 7'b0010011 && fun3 == 3'b011) ? 6'b010000 : // SLTIU
    (op == 7'b0010011 && fun3 == 3'b100) ? 6'b010001 : // XORI
    (op == 7'b0010011 && fun3 == 3'b110) ? 6'b010010 : // ORI
    (op == 7'b0010011 && fun3 == 3'b111) ? 6'b010011 : // ANDI

    // S-type instructions (e.g., Store instructions)
    (op == 7'b0100011 && fun3 == 3'b000) ? 6'b010100 : // SB
    (op == 7'b0100011 && fun3 == 3'b001) ? 6'b010101 : // SH
    (op == 7'b0100011 && fun3 == 3'b010) ? 6'b010110 : // SW

    // B-type instructions (e.g., Branch instructions)
    (op == 7'b1100011 && fun3 == 3'b000) ? 6'b010111 : // BEQ
    (op == 7'b1100011 && fun3 == 3'b001) ? 6'b011000 : // BNE
    (op == 7'b1100011 && fun3 == 3'b100) ? 6'b011001 : // BLT
    (op == 7'b1100011 && fun3 == 3'b101) ? 6'b011010 : // BGE
    (op == 7'b1100011 && fun3 == 3'b110) ? 6'b011011 : // BLTU
    (op == 7'b1100011 && fun3 == 3'b111) ? 6'b011100 : // BGEU

    // J-type instructions (e.g., JAL)
    (op == 7'b1101111) ? 6'b011101 : // JAL

    // U-type instructions (e.g., LUI and AUIPC)
    (op == 7'b0110111) ? 6'b011110 : // LUI
    (op == 7'b0010111) ? 6'b011111 :6'b000000; // AUIPC

     // Default case if no match                   
endmodule
