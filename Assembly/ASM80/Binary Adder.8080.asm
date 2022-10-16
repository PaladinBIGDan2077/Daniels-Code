;
;   Title: Simple 8-Bit Binary Adder
;   Developer: Daniel J. Lomis
;   Date Written: October 6, 2022
;   Location: McLean, Virginia
;   Company: The Lomis Company of Virginia, R&D
;
;   Date Successfully Compiled on the Altair: 10/15/20222
;
;   Programming Language: Assembly
;   Intruction Code Language: ASM80
;   Programming Syntax: CP/M Assembler Mnemonics (Intel-based)
;   System Architecture: Intel 8080
;   Compiler: CP/M ASSEMBLER - VER 2.0
;
;   Target Comuter: Altair 8800
;
;   Description: A front panel program for adding two 8-Bit words, A and B, yielding 
;                an output, C. My first program written in Assembly. Runs on any Intel 8080-based computer.
;
;       Mathematical Formula: A + B = C
;
;       Input Memory Address  A, B: 0x0100, 0x0102
;       Output Memory Address C: 0x0104
;
;VARIABLE       |MNEMONIC   |OPERAND         |COMMENT(S)
                LHLD        000001Q          ; Writes the value located at memory address 0x0100 to register L
                LDA         000002Q          ; Writes the value located at memory address 0x0101 to register A
                ORG         000007Q          ; Sets the CPU's program counter to 0. Programming will be entered from memory address 0x0000 onward.
                ADD         L                ; Performs binary or decimal addition of register A and L. Writes the output to register A.
                STA         000000Q          ; Copies the contents of register A and writes it to memory address 0x0104  (0104)
                ORG         000017Q          ; Sets the CPU's program counter to 40. Programming will be entered from memory address 0x0040 onward.
                HLT                          ; Halt the CPU
                END                          ; End of Assembly Intruction
