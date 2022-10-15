;
;   Title: Simple 8-Bit Binary Adder
;   Developer: Daniel J. Lomis
;   Date Written: October 6, 2022
;   Location: McLean, Virginia
;   Company: The Lomis Company of Virginia, R&D
;
;   Date Successfully Compiled on the Altair:
;
;   Programming Language: Assembly
;   Intruction Code Language: ASM80
;   Programming Syntax: INTEL MNEUMONICS
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
;|LABEL     |MNEMONIC   |OPERAND    |COMMENTS
            ORG         00FFH       ;  Sets the CPU's program counter to 0. Programming will be entered from memory address 0x0000 onward.
            LHLD        0100H	    ;  Writes the value located at memory address 0x0100 to register L
	        LDA         0102H       ;  Writes the value located at memory address 0x0101 to register A
            ADD         L           ;  Performs binary or decimal addition of register A and L. Writes the output to register A.
            STA         0104H       ;  Copies the contents of register A and writes it to memory address 0x0104  (0104)
            JMP         0010H       ;  Jumps the program counter to memory address 0x0010.
            ORG         0040H       ;  Sets the CPU's program counter to 40. Programming will be entered from memory address 0x0040 onward.
            HLT                     ;  halt the CPU
            END                     ;  End of Assembly Intruction
