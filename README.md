
---

# Fetch Cycle  

### Block Diagram  
*(Add the block diagram image here)*  

### Theory  
The Fetch Cycle is the first stage of the RISC-V processor pipeline. Its primary function is to retrieve the next instruction from memory and update the program counter (PC). The fetched instruction is passed to the subsequent stages for decoding and execution.  

The key components of the Fetch Cycle are:  

1. **MUX**:  
   *(Add image here)*  
   The MUX selects between the next sequential program counter (`PCPlus1F`) and the branch target address (`PCTargetE`) based on the control signal `PCSrcE`.  
   - **Inputs:**  
     - `PCTargetE` and `PCSrcE`: These signals are generated in the Execution Cycle.  
     - `PCPlus1F`: This is generated in the Fetch Cycle itself.  
   - **Output:**  
     - `PC_F_next`: The next program counter value.  

2. **PC (Program Counter)**:  
   *(Add image here)*  
   The Program Counter holds the address of the current instruction and updates to the next instruction address during every clock cycle.  
   - **Inputs:**  
     - `PC_F_next`: Provided by the MUX.  
   - **Output:**  
     - `PC_F`: The current program counter value used to fetch the instruction.  

3. **IM (Instruction Memory)**:  
   *(Add image here)*  
   This module stores the instruction set of the processor. Based on the current `PC_F`, it outputs the instruction (`InstrF`) to be executed.  
   - **Inputs:**  
     - `PC_F`: Current program counter value.  
   - **Output:**  
     - `InstrF`: The instruction fetched for execution.  

4. **PC_ADDER**:  
   *(Add image here)*  
   This unit computes the next sequential program counter address by adding `1` to the current value of the `PC`.  
   - **Inputs:**  
     - `PC_F`: Current program counter value.  
   - **Output:**  
     - `PCPlus1F`: The next sequential program counter value.  

### Interactions Between Cycles  
- The signals `PCTargetE` and `PCSrcE` used by the MUX are generated in the **Execution Cycle**.  
- The `PCPlus1F` and `InstrF` signals are generated within the Fetch Cycle and are used in subsequent pipeline stages.  

---

