
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
