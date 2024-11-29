
---

# Fetch Cycle  

### Block Diagram  
*(Add the block diagram image here)*  

### Theory  
The Fetch Cycle is the first stage of the RISC-V processor pipeline. Its primary function is to retrieve the next instruction from memory and update the program counter (PC). The fetched instruction is passed to the subsequent stages for decoding and execution.  

The key components of the Fetch Cycle are:  

1. **MUX**:  
*![MUX](https://github.com/user-attachments/assets/a9ef6c3f-b106-419a-8480-6ce13dd56275)*  

The MUX selects between the next sequential program counter (`PCPlus1F`) and the branch target address (`PCTargetE`) based on the control signal `PCSrcE`.  
- **Inputs:**  
  - `PCTargetE` and `PCSrcE`: These signals are generated in the Execution Cycle.  
  - `PCPlus1F`: This is generated in the Fetch Cycle itself.  
- **Output:**  
  - `PC_F_next`: The next program counter value.  

2. **PC (Program Counter)**:  
*![PC](https://github.com/user-attachments/assets/0411bda6-c393-4487-90a1-98fd7f8eb827)*  

The Program Counter holds the address of the current instruction and updates to the next instruction address during every clock cycle.  
- **Inputs:**  
  - `PC_F_next`: Provided by the MUX.  
- **Output:**  
  - `PC_F`: The current program counter value used to fetch the instruction.  

3. **IM (Instruction Memory)**:  
*![IM](https://github.com/user-attachments/assets/b0908b9d-6cdd-4715-a4bc-0a0bb55b5f17)*  

This module stores the instruction set of the processor. Based on the current `PC_F`, it outputs the instruction (`InstrF`) to be executed.  
- **Inputs:**  
  - `PC_F`: Current program counter value.  
- **Output:**  
  - `InstrF`: The instruction fetched for execution.  

4. **PC_ADDER**:  
*![PC_ADDER](https://github.com/user-attachments/assets/edd22453-3e34-44f1-9761-c5e14a4874bc)*  

This unit computes the next sequential program counter address by adding `1` to the current value of the `PC`.  
- **Inputs:**  
  - `PC_F`: Current program counter value.  
- **Output:**  
  - `PCPlus1F`: The next sequential program counter value.  

### Interactions Between Cycles  
- The signals `PCTargetE` and `PCSrcE` used by the MUX are generated in the **Execution Cycle**.  
- The `PCPlus1F` and `InstrF` signals are generated within the Fetch Cycle and are used in subsequent pipeline stages.  

--- 

# Decoder Cycle  

### Block Diagram  
*(Add the block diagram image here)*  

### Theory  
The Decoder Cycle is the second stage of the RISC-V processor pipeline. Its primary function is to decode the fetched instruction (`InstrD`) and generate control signals for the subsequent stages, including register reads and ALU control. The decoded instruction is used to determine the operation and data required for execution.

The key components of the Decoder Cycle are:

1. **Instruction Register (IR)**:    

The Instruction Register holds the fetched instruction passed from the Fetch Cycle. This instruction is then split into its constituent fields for decoding.
- **Inputs:**  
  - `InstrF`: The fetched instruction passed from the Fetch Cycle.
- **Outputs:**  
  - `InstrD`: The instruction in decoded form, ready for processing.

2. **Control Unit (CU)**:  
*![Screenshot 2024-11-29 132427](https://github.com/user-attachments/assets/4ea58382-8fd2-41bf-abc9-01a8a40d4710)*  

The Control Unit decodes the instruction fields (`InstrD`) and generates control signals that guide the operations in the Execution and Memory cycles.

Here's the description of the **Control Unit (CU)** block in the format you requested:

- **Inputs:**  
  - `op`: 7-bit opcode of the instruction (`InstrD[6:0]`).
  - `fun7`: 7-bit function field (`InstrD[31:25]`).
  - `fun3`: 3-bit function field (`InstrD[14:12]`).

- **Outputs:**  
  - `alu_control`: 6-bit ALU control signal that determines the operation (addition, subtraction, etc.).
  - `regwrite`: Control signal to enable or disable writing to a register.
  - `ALUsrc`: 2-bit signal to select the second operand for the ALU (either a register value or an immediate value).
  - `memwrite`: Control signal to enable or disable writing to memory.
  - `resultsrc`: Signal to select the result source (ALU result or memory data).
  - `branch`: Control signal to indicate whether a branch operation is to be executed.
  - `jump`: Control signal to indicate whether a jump operation is to be executed.
  - `immsrc`: 3-bit signal to select the immediate value source for the operation.
  - `AUIPC`: Signal indicating if the instruction is AUIPC (Add Upper Immediate to PC).
  - `sh_D`: Control signal indicating if the instruction is a `SH` (store halfword).
  - `sb_D`: Control signal indicating if the instruction is a `SB` (store byte).
  - `lh_D`: Control signal indicating if the instruction is a `LH` (load halfword).
  - `lb_D`: Control signal indicating if the instruction is a `LB` (load byte).

3. **Register File**:  
*![Screenshot 2024-11-29 132309](https://github.com/user-attachments/assets/4afdf15c-6cbd-4d6e-b031-40d3bce9efef)*  

The Register File holds the general-purpose registers. The Register File is accessed to read values for the source registers (`rs1`, `rs2`) based on the instruction type.
- **Inputs:**  
  - `rs1`: Source register 1 (from instruction `InstrD[19:15]`).
  - `rs2`: Source register 2 (from instruction `InstrD[24:20]`).
  - `RegWrite`: Control signal from the Control Unit indicating whether to write data to the register file.
  - `WriteData`: Data to be written to the register file.
- **Outputs:**  
  - `Data1`: The value from the register file for source register `rs1`.
  - `Data2`: The value from the register file for source register `rs2`.

4. **Immediate Generator**:  
*![Screenshot 2024-11-29 132401](https://github.com/user-attachments/assets/1e2cf90f-7df1-47a4-b43d-5ada5956c6b0)*  

The Immediate Generator extracts and sign-extends the immediate value from the instruction fields for use in operations that require an immediate value. The immediate value is decoded differently for each instruction type:

- **I-type (Immediate-type)**:  
  - Immediate is extracted from `InstrD[31:20]`.
  - The value is sign-extended to 32 bits.
  
- **S-type (Store-type)**:  
  - Immediate is formed by concatenating `InstrD[31:25]` and `InstrD[11:7]`.
  - The value is sign-extended to 32 bits.
  
- **B-type (Branch-type)**:  
  - Immediate is formed by concatenating `InstrD[31]`, `InstrD[7]`, `InstrD[30:25]`, and `InstrD[11:8]` (using bitwise operations to construct the immediate value).
  - The value is sign-extended to 32 bits.
  
- **U-type (Upper immediate-type)**:  
  - Immediate is extracted from `InstrD[31:12]`, and it is shifted left by 12 bits (to make space for the lower 12 bits set to 0).
  - The value is zero-extended to 32 bits.

- **J-type (Jump-type)**:  
  - Immediate is formed by concatenating `InstrD[31]`, `InstrD[19:12]`, `InstrD[20]`, `InstrD[30:21]` (using bitwise operations).
  - The value is sign-extended to 32 bits.

- **R-type (Register-type)**:  
  - No immediate value is used in R-type instructions, so the Immediate Generator outputs a zero value for these types.

- **LUI-type (Load Upper Immediate)**:  
  - Immediate is extracted from `InstrD[31:12]`, and it is shifted left by 12 bits (to set the upper 20 bits) with the lower 12 bits set to 0.
  - The value is zero-extended to 32 bits.

- **AUIPC-type (Add Upper Immediate to PC)**:  
  - Similar to LUI, the immediate is extracted from `InstrD[31:12]` and shifted left by 12 bits.
  - The value is zero-extended to 32 bits.

- **Load-type (I-type)**:  
  - Immediate is extracted from `InstrD[31:20]`, similar to other I-type instructions.
  - The value is sign-extended to 32 bits.

### Interactions Between Cycles  
- The `InstrF` signal is passed from the Fetch Cycle, and once decoded, it becomes `InstrD`.  
- The control signals generated by the Control Unit (`ALUSrc`, `MemRead`, `MemWrite`, etc.) are used to guide the next cycle's operations.  
- The values `Data1`, `Data2`, and `Immediate` are passed to the Execution Cycle for use in the ALU and Memory operations.

---
