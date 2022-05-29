.section .text 
.global load
.type load, @function

load: 
      add a4,a0,zero //initialize sum register a4 with 0x0
      add a2,a0,a1 //store count = 10 in register a2. reg a1 is loaded with 0xa(dec=10) from main 
      add a3,a0,zero //initialize intermediate sum register a3 by 0
loop: add a4,a3,a4 //incremental addition
      addi a3,a3,1 //increment intermediate register by 1
      blt a3,a2,loop // if a3<a2, branch to label loop 
      add a0,a4,zero // store final result in reg a0 to be read by main program 
      ret 
