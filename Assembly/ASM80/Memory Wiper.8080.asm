;                                                                                                       
;   Title: Memory Wiper (WIP)
;   Developer: Daniel J. Lomis
;   Date Written: October 24, 2022
;   Location: McLean, Virginia
;   Company: The Lomis Company of Virginia, R&D
;
;   Last Successful Compile: 12:12AM 10/25/20222
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
;                 Usable Register Codes (Set at address 0x0000)
;                 B [000] => [01010101]
;                 C [001] => [10101010]
;                 D [010] => [00000000]
;                 E [011] => [11111111]
;
;  VARIABLE|    |MNEMONIC   |OPERAND        |COMMENT(S)
     REGVAR:    DS          0000H           ; Global Var, indicates where to write Register val.
                ORG         0FFFFH          ;
                STC                         ;
                ORG         0003H           ; Sets the CPU's program counter to 1       
                MVI         B,0011H         ; Writes value 0055 [01010101, base-2] to Register B
                MVI         C,00AAH         ; Writes value 00AA [10101010, base-2] to Register C
                MVI         D,0000H         ; Writes value 0000 [00000000, base-2] to Register D
                MVI         E,00FFH         ; Writes value 00FF [11111111, base-2] to Register E
                LXI         H,0020H         ; Writes value 0020 to register pair HL
                MOV         A,E             ; TEMP SOLN. DEBUG, E REPLACES 0000H
                JMP         WRITER          ; Jumps Program Counter to WRITER function.
                HLT                         ; Halt the CPU
;
      WRITER                                
                MOV         M,A             ; Writes value at Address 0x0001 to Register A
                INR         M               ; Increment the H-L register by 1, forcing the pair to point at the adjacent memory address                          
                RC                          ; Jumps the program counter to memory address 0010.
                JMP         WRITER
;
                END                         ; End of Assembly Instruction
