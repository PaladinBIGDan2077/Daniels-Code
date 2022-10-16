;                                                                                                       <
;   Title: Simple 8-Bit Binary Adder
;   Developer: Daniel J. Lomis
;   Date Written: October 15, 2022
;   Location: McLean, Virginia
;   Company: The Lomis Company of Virginia, R&D
;
;   Last Successful Compile: 5:21PM 10/16/20222
;
;   Programming Language: Assembly
;   Instruction Code Language: ASM80
;   Programming Syntax: CP/M Assembler
;   System Processor (Instruction Set): Intel 8080 (i8080)
;   Compiler: CP/M ASSEMBLER - VER 2.0
;
;   Target Computer: Altair 8800
;
;   Description: A front panel program for adding two words (8-Bits each), A and B, yielding 
;                an output, C. My first program written in Assembly. When HALT state is reached
;                after Full Reset, the operator will be able to see the result at Address 
;                0c000000. Makes use of Registers A (Accumulator) and L (Lower Memory Pointer). 
;                After inputting A and B, run the program from Address 0c000010. Written in Octal.
;
;       Mathematical Formula: A + B = C
;
;       Input Memory Address  A, B: 0c000001, 0c000002
;       Output Memory Address C: 0c000000   
;
;VARIABLE|      |MNEMONIC   |OPERAND        |COMMENT(S)
;   OUT-C:      EQU         000000Q         | OUTPUT C - Result from Register A is outputted
;    IN-A:      EQU         000001Q         | INPUT A - First word (binary/decimal)
;    IN-B:      EQU         000002Q         | INPUT B - Second word (binary/decimal)
                ORG         000005Q         ; Sets 8080's Program Counter to 0o000010
                JMP         000022Q         ; Jump to Halt
                LHLD        000001Q         ; Writes value at Address 0o000001 to Reg. L
                LDA         000002Q         ; Writes value at Address 0o000002 to Reg. A
                ADD         L               ; Adds Reg. A and L, answer placed into Reg. A
                STA         000000Q         ; Copies Register A to Address 0o000000
                HLT                         ; Halts the 8080
                END                         ; End of Assembly Instruction
