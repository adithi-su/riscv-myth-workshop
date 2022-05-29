# Digital Logic with TL-Verilog and Makerchip
<a href="https://makerchip.com/">Makerchip</a> is a free online environment for developing high-quality integrated circuits. You can code, compile, simulate, and debug Verilog designs, 
all from your browser. Your code, block diagrams, and waveforms are tightly integrated.

All the examples and code-files in this directory have been coded on Makerchip IDE using TL-verilog.
## Combinational Logic

* Inverter using TL-verilog (logic) -
```
$out = ! $in;
```
There is no need to declare $out and $in unlike Verilog. There is also no need to assign $in. Random stimulus is provided, and a warning is produced.

* <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/calculator_combinational.tlv">Calculator using combinational logic </a>

## Sequential Logic

* Fibonacci Series with reset using TL-Verilog (logic) - 
```
$num[31:0] = $reset ? 1 : (>>1$num + >>2$num)
```
The operator >> in `>>1$num` and `>>2$num` gives the value of that signal 1 cycle before and 2 cycles before respectively.

* <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/calculator_sequential.tlv">Calculator using sequential logic </a>

## Pipelined Logic

Code is written under `|pipe` scope with stages defined as `@1`,`@2` and so on.
* <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/calculator_with_counter.tlv">Counter and calculator in pipeline</a>

## Validity

Validity in TL-verilog - signal indicates validity of transaction and described as "when" scope else it will work as don't care. Denoted as `?$valid`. 
Validity provides easier debug, cleaner design, better error checking, automated clock gating.
```
|calc
@1
$valid = ...;
  ?$valid
    @1 
    ...
  @2
    ...
```
* <a href = "https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/calculator_validity.tlv"> 2 cycle calculator with validity </a> 
# Basic RISC-V CPU Microarchitecture 
Aim: To design a basic 3 stage (fetch, decode and execute) processor based on RISC-V ISA.

<a href="https://drive.google.com/file/d/1tqvXmFru31-tezDX30jTNJoLcQk308UM/view">Slides</a> (source: @<a href="https://github.com/stevehoover">stevehoover</a>)

### <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/fetch.tlv">Fetch</a> 

Processor fetches the instruction from the IM pointed by address given by PC.

Program Counter (PC): Holds the address of next Instruction

Instruction Memory (IM): Holds the set of instructions to be executed

### <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/decode.tlv">Decode </a>

Instruction Format includes Opcode, immediate value, source address, destination address. During Decode Stage, processor decodes the instruction based on instruction format and type of instruction.

Types of Instructions(6):

* R-type - Register
* I-type - Immediate
* S-type - Store
* B-type - Branch (Conditional Jump)
* U-type - Upper Immediate
* J-type - Jump (Unconditional Jump)

### <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/RF_read_write.tlv">Register file read and write </a>

Here the Register file is 2 read, 1 write i.e 2 read and 1 write operation(s) can happen simultanously.

Inputs:

* Read_Enable - Enable signal to perform read operation
* Read_Address1 - Address1 from where data has to be read
* Read_Address2 - Address2 from where data has to be read
* Write_Enable - Enable signal to perform write operation
* Write_Address - Address where data has to be written
* Write_Data - Data to be written at Write_Address

Outputs:

* Read_Data1 - Data from Read_Address1
* Read_Data2 - Data from Read_Address2

### <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/execute.tlv">Execute</a>

During the Execute Stage, both the operands perform the operation based on Opcode.

### <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/control_logic.tlv">Control logic</a>

During Decode Stage, branch target address is calculated and fed into the PC mux. Before Execute Stage, once the operands are ready branch condition is checked.

### <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/pipelined_cpu.tlv">Pipelined RISC-V CPU</a>
Refer: <a href="https://ieeexplore.ieee.org/document/8119264"> Timing-Abstract Circuit Design in Transaction-Level Verilog </a>

Pipelining the CPU with branches having 3 cycle delay, rest all instructions are pipelined. Pipelining the CPU in TL-Verilog can be done in following manner:
```
|<pipe-name>
    @<pipe stage>
       Instructions present in this stage
       
    @<pipe_stage>
       Instructions present in this stage
```      
Below is snapshot of pipelined CPU with a test case of assembly program which does summation from 1 to 9 then stores to r10 of register file. In snapshot r10 = 45. Test case:
```
*passed = |cpu/xreg[10]>>5$value == (1+2+3+4+5+6+7+8+9);
```

### <a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/ld_str.tlv">Load and store instructions, memory</a>

Similar to branch, load has 3 cycle delay. So, add Data Memory 1 write/read memory.

Inputs:

* Read_Enable - Enable signal to perform read operation
* Write_Enable - Enable signal to perform write operation
* Address - Address specified whether to read/write from
* Write_Data - Data to be written on Address (Store Instruction)

Output:

* Read_Data - Data to be read from Address (Load Instruction)

Add test case to check fucntionality of load/store. Store the summation of 1 to 9 on address 4 of Data Memory and load that value from Data Memory to r17.
```
*passed = |cpu/xreg[17]>>5$value == (1+2+3+4+5+6+7+8+9);
```

Further: Add Jumps and complete Instruction Decode and ALU for all instructions present in RV32I base integer instruction set.

<a href="https://github.com/RISCV-MYTH-WORKSHOP/riscv_myth_workshop_may22-adithi-su/blob/master/Day3_5/riscv_cpu.tlv">Complete architecture </a>
