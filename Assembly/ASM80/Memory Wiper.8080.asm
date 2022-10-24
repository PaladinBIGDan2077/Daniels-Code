;                                                                                                       
;   Title: Memory Wiper (WIP)
;   Developer: Daniel J. Lomis
;   Date Written: October 13, 2022
;   Location: McLean, Virginia
;   Company: The Lomis Company of Virginia, R&D
;
;   Last Successful Compile: 10/16/20222
;
;   Programming Language: Assembly
;   Instruction Code Language: ASM80
;   Programming Syntax: CP/M Assembler
;   System Processor (Instruction Set): Intel 8080 (i8080)
;   Compiler: CP/M ASSEMBLER - VER 2.0
;
;   Target Computer: Altair 8800
;
;   Description:  A memory eraser program. It essentially clears the entire system of
;                 memory. It will perform either one or all of the erasures, as defined,
;                 up to 16 times. Supports writing zeros, ones, alternating zeros and ones,
;                 alternating ones and zeros, and custom value.
;
;  VARIABLE|      |MNEMONIC   |OPERAND        |COMMENT(S)
     REGVAR:      EQU         0000H           ; Global Var, indicates where to write Register val.
                  ORG         0001H           ; Sets the CPU's program counter to 40. Programming will be entered from memory address 0040 onward.
                  MVI         B,0011H         ; Writes value 0055 [01010101, base-2] to Register B
                  MVI         C,00AAH         ; Writes value 00AA [10101010, base-2] to Register C
                  MVI         D,0000H         ; Writes value 0000 [00000000, base-2] to Register D
                  MVI         E,00FFH         ; Writes value 00FF [11111111, base-2] to Register E
                  LXI         H,0000H         ; Writes value 0000 to register pair HL
                  JMP         SUBROUTINE      ; Jumps Program Counter to Subroutine function.
                  IN          
   CHECKREG:      IF          REGVAR
 
 
       LOOP:
                  MOV         
                  LDA         0001H           ; Writes value at Address 0x0001 to Register A
                  INR         M               ; Increment the H-L register by 1, forcing the pair to point at the adjacent memory address
                  JMP         0010H           ; Jumps the program counter to memory address 0010.
                  ORG         0040H           ; Sets the CPU's program counter to 40. Programming will be entered from memory address 0040 onward.
                  HLT                         ; Halt the CPU
                  END                         ; End of Assembly Instruction
