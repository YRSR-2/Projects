# RISCV-SINGLE-CYCLE-PROCESSOR
<h2>A simple 32-bit RISC-V processor design that executes instructions in a single clock cycle. Ideal for educational purposes and understanding basic processor architecture.</h2>

![128730771-560da5b6-f33b-410c-bc03-2dc68f2c748e](https://github.com/user-attachments/assets/ce3e23c8-26fd-49f3-a971-2d1ee70c365a)
## Instruction Type Summary

| **Instruction Type** | **All Possible Instructions**                                   | **Instructions Implemented**                                         |
|----------------------|----------------------------------------------------------------|------------------------------------------------------------------|
| **R-type**           | ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, MUL, DIV, REM | ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND                 |
| **I-type**           | ADDI, SLLI, SLTI, SLTIU, XORI, SRLI, SRAI, ORI, ANDI, LB, LH, LW, LBU, LHU, LUI, AUIPC | ADDI, SLLI, SLTI, SLTIU, XORI, SRLI, SRAI, ORI, ANDI, LB, LH, LW, LBU, LHU, LUI, AUIPC |
| **S-type**           | SB, SH, SW                                                     | SB, SH, SW                                                       |
| **B-type**           | BEQ, BNE, BLT, BGE, BLTU, BGEU                                 | BEQ, BNE, BLT, BGE, BLTU, BGEU                                 |
| **J-type**           | JAL, JALR                                                     | JAL, JALR                                                       |

## How to run the code

1. Clone the repository.

2. Open it in any RTL design suite, such as Xilinx Vivado or ModelSim.

3. Instantiate `riscv_cpu_main` as the top module.

4. Configure `tb.v` to be used as the testbench file.

5. Run the simulation.

## Keep Growing,Happy Learning :smile:
