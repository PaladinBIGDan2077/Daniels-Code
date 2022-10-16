;
;   Title: Memory Wiper (WIP)
;   Developer: Daniel J. Lomis
;   Date Written: October 13, 2022
;   Location: McLean, Virginia
;   Company: The Lomis Company of Virginia, R&D
;
;   Last Date Successfully Compiled: 10/15/2022
;
;   Programming Language: Assembly
;   Instruction Code Language: ASM80
;   Programming Syntax: CP/M Assembler Mnemonics (Intel-based)
;   System Architecture: Intel 8080 Microprocessor
;   Compiler: CP/M ASSEMBLER - VER 2.0
;
;   Target Computer: Altair 8800
;
;   Description:  A memory eraser program. It essentially clears the entire system of
;                 memory. It will perform either one or all of the erasures, as defined,
;                 up to 16 times. Supports writing zeros, ones, alternating zeros and ones,
;                 alternating ones and zeros, and custom value.
;
;VARIABLE|      |MNEMONIC   |OPERAND        |COMMENT(S)
  REGVARI:      EQU         01FFH           ; Global variable, indicates which register to write the memory pattern with at memory address 01FF
                MVI         B,0011H         ; Writes the value 0055 [01010101, base-2] to register B
                MVI         C,00AAH         ; Writes the value 00AA [10101010, base-2] to register C
                MVI         D,0000H         ; Writes the value 0000 [00000000, base-2] to register D
                MVI         E,00FFH         ; Writes the value 00FF [11111111, base-2] to register E
                LDA         0F00H           ; Writes the value contained at at memory address 0F00 to register A, designed for custom bit writing
                LXI         H,0000H         ; Writes the value 0000 [0000000000000000, base-2] to register pair HL
                INR         M               ; Increment the H-L register by 1, forcing the pair to point at the adjacent memory address
                JMP         0010H           ; Jumps the program counter to memory address 0010.
                ORG         0040H           ; Sets the CPU's program counter to 40. Programming will be entered from memory address 0040 onward.
                HLT                         ; Halt the CPU
                END                         ; End of Assembly Instruction
