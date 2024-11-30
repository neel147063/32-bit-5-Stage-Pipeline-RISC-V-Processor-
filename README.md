### How to Run the Project in Vivado 2023.2 ML Edition 🚀  

If you're not familiar with the underlying theory, don't worry! Just follow these simple steps to run the project and see the results:  

1. **Install Vivado 2023.2 ML Edition** 🖥️  
   - Ensure you have the software installed on your system to use this project.

2. **Download the Project Files** 📁  
   - Download the project folder and locate the file named **`RISC-V_TOP.xpr`**.

3. **Open the Project in Vivado** ✨  
   - Launch **Vivado 2023.2 ML Edition**.  
   - Click on **Open Project** and select the **`RISC-V_TOP.xpr`** file.

4. **Run the Simulation** 🎬  
   - Once the project opens, go to **Run Simulation** and choose **Run Behavioral Simulation**.  
   - Wait for the simulation window to open.

5. **Set Clock and Reset Signals** 🔄  
   - **For Clock (clk)**:  
     - Right-click on **clk**, select **Force Clock**, and set up a clock pulse.  
   - **For Reset (rst)**:  
     - First, set it to **0** for **100 ns**, and then to **1** for **15000 ns**.

6. **View the Output in the Register File** 📊  
   - In the **Scope** window:  
     - Open **D_C** and then **rf**.  
   - In the **Object** window:  
     - Expand **reg_mem[31:0][31:0]**.  
   - Boom! 🎉 You’ll see the output of all instructions in your **Register File (rf)**.  

Enjoy exploring the results of your RISC-V processor simulation! 🚀

#### For those who want to dive deeper into the theory behind this project, a detailed explanation is provided below. 📖✨

---

### RISC-V 32-bit 5-Stage Pipelined Architecture

#### **Introduction**  
RISC-V is an open-source instruction set architecture (ISA) designed for flexibility, simplicity, and efficiency. The 32-bit RISC-V ISA supports multiple instruction types, making it suitable for various applications. A 5-stage pipelined architecture enhances instruction throughput by breaking down instruction execution into distinct stages, ensuring efficient parallel processing.

### **Instruction Types and Field Addresses**  

1. **R-Type**:  
   - **Purpose**: Register-to-register operations (e.g., addition, subtraction).  
   - **Fields**:  
     - `opcode` (0–6): Specifies the operation type.  
     - `rd` (7–11): Destination register.  
     - `funct3` (12–14): Encodes the specific operation within the opcode.  
     - `rs1` (15–19): First source register.  
     - `rs2` (20–24): Second source register.  
     - `funct7` (25–31): Extends operation encoding.

2. **I-Type**:  
   - **Purpose**: Handles immediate values for arithmetic, logical, and load operations.  
   - **Fields**:  
     - `opcode` (0–6): Specifies the operation type.  
     - `rd` (7–11): Destination register.  
     - `funct3` (12–14): Encodes the specific operation within the opcode.  
     - `rs1` (15–19): Source register.  
     - `imm` (20–31): Immediate value.

3. **S-Type**:  
   - **Purpose**: Used for store operations.  
   - **Fields**:  
     - `opcode` (0–6): Specifies the operation type.  
     - `imm[11:5]` (7–11, 25–31): Immediate value (split across fields).  
     - `funct3` (12–14): Encodes the specific operation within the opcode.  
     - `rs1` (15–19): Base address register.  
     - `rs2` (20–24): Source register for the value to store.  

4. **B-Type**:  
   - **Purpose**: Facilitates branch instructions based on conditions.  
   - **Fields**:  
     - `opcode` (0–6): Specifies the operation type.  
     - `imm[12]` (31): Sign bit of immediate value.  
     - `imm[10:5]` (25–30): Middle bits of the immediate value.  
     - `funct3` (12–14): Encodes the specific operation within the opcode.  
     - `rs1` (15–19): First source register.  
     - `rs2` (20–24): Second source register.  
     - `imm[4:1]` (8–11), `imm[11]` (7): Remaining immediate bits.

5. **U-Type**:  
   - **Purpose**: Supports upper immediate values for large constants (e.g., LUI).  
   - **Fields**:  
     - `opcode` (0–6): Specifies the operation type.  
     - `rd` (7–11): Destination register.  
     - `imm[31:12]` (12–31): Upper immediate value.

6. **J-Type**:  
   - **Purpose**: Used for jump instructions (e.g., JAL).  
   - **Fields**:  
     - `opcode` (0–6): Specifies the operation type.  
     - `rd` (7–11): Destination register.  
     - `imm[20]` (31): Sign bit of the immediate value.  
     - `imm[10:1]` (21–30): Middle bits of the immediate value.  
     - `imm[11]` (20): Immediate bit.  
     - `imm[19:12]` (12–19): Upper bits of the immediate value.

### **Pipeline Stages**

1. **Instruction Fetch (IF)**:  
   - Retrieves the next instruction from memory.

2. **Instruction Decode (ID)**:  
   - Decodes the instruction and fetches operands.

3. **Execution (EX)**:  
   - Performs the required operation (e.g., arithmetic, logical).

4. **Memory Access (MEM)**:  
   - Reads from or writes to memory if needed.

5. **Write Back (WB)**:  
   - Writes the result back to the destination register.

---

*![image](https://github.com/user-attachments/assets/5d551ea2-bf34-41a5-b542-7fad25a1c958)*

---

# Fetch Cycle  

### Block Diagram  
*![Screenshot 2024-11-30 062808](https://github.com/user-attachments/assets/733bef95-19fb-44a5-b680-a83a6185272e)*  

### Theory  
The Fetch Cycle is the first stage of the RISC-V processor pipeline. Its primary function is to retrieve the next instruction from memory and update the program counter (PC). The fetched instruction is passed to the subsequent stages for decoding and execution.  

The key components of the Fetch Cycle are:  

1. **MUX**:  
**![MUX](https://github.com/user-attachments/assets/a9ef6c3f-b106-419a-8480-6ce13dd56275)**  

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

#### **1. Fetch Cycle:**
- Registers: `PC`, `Instruction_F`, `BranchTarget_F`
- Output to Decode: `Instruction_F`

--- 

# Decoder Cycle  

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

#### **2. Decode Cycle:**
- Registers: `regwrite_D_r`, `memwrite_D_r`, `resultsrc_D_r`, `RD_D_r`, `WriteData_D_r`, `ALUOp_D_r`, `rs1_D_r`, `rs2_D_r`, `imm_D_r`
- Output to Execute: `regwrite_E`, `memwrite_E`, `resultsrc_E`, `RD_E`, `WriteData_E`, `ALUOp_E`, `rs1_E`, `rs2_E`, `imm_E`

---

# Execution Cycle 
*![Screenshot 2024-11-30 061335](https://github.com/user-attachments/assets/91915a9f-f10a-4c8f-adb7-6464eb0e5efc)*
**Inputs:**
- **clk**: Clock signal to synchronize the operations.
- **reset**: Reset signal to reset all registers in the cycle.
- **sh_E, sb_E, lh_E, lb_E**: Store/load signals for different data types (halfword, byte).
- **regwrite_E**: Control signal for register write in the execution stage.
- **memwrite_E**: Control signal for memory write in the execution stage.
- **resultsrc_E**: Signal to select whether the result is from the ALU or memory.
- **branch_E**: Control signal for branch operation.
- **jump_E**: Control signal for jump operation.
- **AUIPC_E**: Control signal for the AUIPC instruction.
- **ALUsrc_E (2 bits)**: ALU operand selection control.
- **alu_control_E (6 bits)**: ALU operation control signal.
- **RD_E (5 bits)**: Destination register (used for memory operations).
- **RD1_E, RD2_E (32 bits)**: Register data read from registers.
- **imm_b_j_E, imm_l_i_E, imm_s_E, imm_u_E (32 bits)**: Immediate values for different instruction types.
- **PCD_E (32 bits)**: Current program counter value in the execution stage.
- **PCpluse1D_E (32 bits)**: Program counter incremented by 1.
  
**Outputs:**
- **regwrite_M**: Register write control signal passed to the memory stage.
- **memwrite_M**: Memory write control signal passed to the memory stage.
- **resultsrc_M**: Result source control signal passed to the memory stage.
- **PCSrcE**: Program counter source for branching or jumping.
- **sh_M, sb_M, lh_M, lb_M**: Store/load signals passed to the memory stage.
- **RD_M (5 bits)**: Destination register for memory operations.
- **WriteData_M (32 bits)**: Data to be written to memory.
- **ALUresult_M (32 bits)**: ALU result passed to the memory stage.
- **PCTargetE (32 bits)**: Target address for branch or jump.

### **MUX_IMM Module**
*![MUX_IMM](https://github.com/user-attachments/assets/7358009d-6e9c-45ff-bdab-b920264634f4)*  
**Inputs:**
- **imm_b_j_E (32 bits)**: Immediate value for branch/jump.
- **imm_u_E (32 bits)**: Upper immediate value for AUIPC.
- **AUIPC_E**: Control signal for AUIPC instruction.

**Outputs:**
- **imm_E (32 bits)**: Selected immediate value based on AUIPC control signal.

### **ADDER_E Module**
*![ADDER](https://github.com/user-attachments/assets/a1f93322-ec27-41db-a5b9-002040663926)*  
**Inputs:**
- **PCD_E (32 bits)**: Program counter value in the execution stage.
- **imm_E (32 bits)**: Immediate value selected by the MUX_IMM.

**Outputs:**
- **PCTargetE (32 bits)**: Program counter target address for branch or jump.

### **MUX_SRCBE Module**
*![srcB](https://github.com/user-attachments/assets/d14d5110-ff8c-44da-9ee3-c20208483b53)*  
**Inputs:**
- **RD2_E (32 bits)**: Register data read from register file.
- **imm_u_E (32 bits)**: Immediate value for U-type instructions.
- **imm_l_i_E (32 bits)**: Immediate value for I-type instructions.
- **imm_s_E (32 bits)**: Immediate value for S-type instructions.
- **ALUsrc_E (2 bits)**: ALU operand selection control signal.

**Outputs:**
- **srcBE (32 bits)**: Selected source operand for the ALU.

### **ALU Module**
*![ALU](https://github.com/user-attachments/assets/bec8d05a-83c0-4a8b-a3a1-56771f846210)*  
**Inputs:**
- **srcAE (32 bits)**: First operand for ALU (from the register file).
- **srcBE (32 bits)**: Second operand for ALU (from the selected MUX_SRCBE).
- **alu_control_E (6 bits)**: ALU control signal to determine the operation.

**Outputs:**
- **zero_E**: Flag indicating if the ALU result is zero (used for branches).
- **result_E (32 bits)**: ALU operation result.

### **AND/OR Gate for Branch Control**

**Inputs:**
- **zero_E**: Zero flag from the ALU.
- **branch_E**: Branch control signal.

**Outputs:**
- **PCSrcE**: Control signal for the program counter source (used to choose between next instruction or branch target).

#### **3. Execute Cycle:**
- Registers: `regwrite_E_r`, `memwrite_E_r`, `resultsrc_E_r`, `RD_E_r`, `WriteData_E_r`, `ALUresult_E_r`, `sh_E_r`, `sb_E_r`, `lh_E_r`, `lb_E_r`
- Output to Memory: `regwrite_M`, `memwrite_M`, `resultsrc_M`, `RD_M`, `WriteData_M`, `ALUresult_M`, `sh_M`, `sb_M`, `lh_M`, `lb_M`

---

# Memory Cycle
*![image](https://github.com/user-attachments/assets/027e9a87-2d42-4671-a603-50e016c5c67a)*

The `M_C` module is used to pass control signals and data between the Memory and Writeback stages of a pipelined processor. It interacts with the `DM` module for memory operations. Here's an overview:

- **Inputs**:
  - `clk`, `reset`: Control signals for the clock and reset.
  - `MemWrite_M`: Memory write signal.
  - `RegWrite_M`, `ResultSrc_M`: Control signals for register write and result source.
  - `sh_M`, `sb_M`, `lh_M`, `lb_M`: Specific memory operation flags (e.g., shift and load operations).
  - `RD_M`: Destination register address from the Memory stage.
  - `ALUResult_M`, `WriteData_M`: ALU result and write data passed to the memory.

- **Outputs**:
  - `RegWrite_W`, `ResultSrc_W`: Forwarded control signals for the Writeback stage.
  - `RD_W`: Destination register address forwarded to the Writeback stage.
  - `ALUResult_W`, `ReadData_M`: Forwarded ALU result and read data for the Writeback stage.

- **Internal Registers**:
  - The `RegWrite_M_r`, `ResultSrc_M_r`, `RD_M_r`, `ALUResult_M_r` registers store the values for control signals and ALU results to be passed to the next stage.

- **Functionality**:
  - It stores and forwards control and data signals between stages in the processor pipeline.
  - The `DM` module is instantiated here for memory operations.

### `DM` Module (Data Memory)
*![DM](https://github.com/user-attachments/assets/6b8500cc-f137-4c27-89ff-57eb79bee78c)* 
The `DM` module is a simple memory block that simulates a data memory for your processor. It handles both memory reads and writes, with support for byte, half-word, and word operations.

- **Inputs**:
  - `clk`, `reset`: Control signals for clock and reset.
  - `MemWrite_M`: Memory write signal.
  - `sh_M`, `sb_M`, `lh_M`, `lb_M`: Flags for specific memory operations.
  - `ALUResult_M`, `WriteData_M`: Address and data for memory operations.

- **Outputs**:
  - `ReadData_M`: The data read from memory.

- **Internal Memory**:
  - A 64-entry memory array (`dm`) holds 32-bit data. It is initialized to zero on reset.

- **Functionality**:
  - On reset, all memory entries are cleared.
  - When `MemWrite_M` is active, data is written to memory:
    - If `sh_M` is set, it stores a 16-bit word.
    - If `sb_M` is set, it stores an 8-bit byte.
    - If neither is set, it stores a 32-bit word.
  - When `MemWrite_M` is inactive, data is read from memory:
    - If `lh_M` is set, it loads a half-word.
    - If `lb_M` is set, it loads a byte.
    - Otherwise, it reads the full 32-bit data.

---

# Write Back Cycle
*![MUX](https://github.com/user-attachments/assets/dcecd4c3-7a5d-4336-a7ce-dac8216ea8a1)* 
The `W_B_C` module is part of the **Writeback** cycle in a pipelined processor. It is responsible for selecting the appropriate result (either from the ALU or memory) and forwarding it to the register file for updating the destination register. This operation is critical for completing the execution of instructions that involve writing results back to registers.

#### **Inputs**:
- **ResultSrc_W**: Control signal indicating whether the result to be written back comes from the ALU or the memory.
- **ALUResult_W**: The result from the ALU, which can be written back to the register file.
- **ReadData_W**: The data read from memory, which can be written back to the register file.

#### **Outputs**:
- **ResultW**: The final result (either ALU result or memory data) that is written back to the register file.

#### **Functionality**:
- The `W_B_C` module uses a multiplexer (implemented in the `MUX1` module) to select between the ALU result and the memory data based on the value of `ResultSrc_W`.
- If `ResultSrc_W` is `1`, the result comes from the memory (i.e., `ReadData_W`).
- If `ResultSrc_W` is `0`, the result comes from the ALU (i.e., `ALUResult_W`).
- The selected result (`ResultW`) is forwarded to the register file to be written back into the destination register.

### `MUX1` Module (Multiplexer)
*![image](https://github.com/user-attachments/assets/0feea1ff-31f2-433a-8680-7e7494a519f0)*
The `MUX1` module is a simple **2-to-1 multiplexer** that selects between two 32-bit inputs based on the `ResultSrc_W` control signal. It is used to choose the result to be written back to the register file in the **Writeback** cycle.

#### **Inputs**:
- **ResultSrc_W**: Control signal that determines which input to select.
- **ALUResult_W**: The result from the ALU.
- **ReadData_W**: The data read from memory.

#### **Outputs**:
- **ResultW**: The selected result, either from the ALU (`ALUResult_W`) or from memory (`ReadData_W`).

#### **Functionality**:
- If **ResultSrc_W** is `1`, the multiplexer outputs the value of **ReadData_W** (memory result).
- If **ResultSrc_W** is `0`, the multiplexer outputs the value of **ALUResult_W** (ALU result).
- This allows the **Writeback** cycle to select the correct data to be written back to the register file.

---
