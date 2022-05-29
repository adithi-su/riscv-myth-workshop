To-be covered: 

* Pseudo Instructions
* Basic integer instructions RV64I 
* Multiply extension RV64M 
* Single and double precision floating point extension RV64F & RV64D
* Application binary interface (ABI)
* Memory allocation and stack pointer

<h2>Compiler toolchain: </h2>

To use the Risc V gcc compiler - 
```
riscv64-unknown-elf-gcc -<compiler options> -mabi=<ABI options> -march=<Architecture options> -o <filename.o> <filename.c> 
```
Options: 
* compiler options : O1, Ofast
* ABI options : lp64, lp32
* Architecture options : rv64i, rv32i

More details on compiler options can be obtained <a href="https://www.sifive.com/blog/all-aboard-part-1-compiler-args"> here </a>

To view the assembly language code -
```
riscv64-unknown-elf-objdump -d <object filename>
```
d - disassemble 

To shorten the output - 
```
riscv64-unknown-elf-objdump -d <object filename> | less
```
  
: /main to view the conversion of int main()

To find number of instructions, subtract the hex locations, then divide by 4

To simulate the object file using spike simulator -  
```
spike pk <object filename>
```
To debug the object file using spike -
```
spike -d pk <object Filename>
: until pc 0 <to-location>
: reg 0 a2 
(To find the contents of register a2)
:q 
(To quit)
```
 
To install complete risc-v toolchain locally on linux -

<a href = "http://hdlexpress.com/RisKy1/How2/toolchain/toolchain.html"> RISC-V GNU Toolchain </a> <br>
<a href = "https://github.com/kunalg123/riscv_workshop_collaterals"> RISC-V ISA SImulator - Spike </a>
