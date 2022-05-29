#include <stdio.h>
extern int load(int x, int y);

int main(){
int result = 0, count = 9;
result = load(0x0,count+1);
printf("sum of %d numbers is %d", count, result);
}

// while compiling in RISC V, use riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o <object filename> <C Program filename> <assemby lang file>
