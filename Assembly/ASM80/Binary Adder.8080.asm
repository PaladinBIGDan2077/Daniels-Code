;
;   Title: Simple 8-Bit Binary Adder
;   Developer: Daniel J. Lomis
;   Date Written: October 6, 2022
;   Location: McLean, Virginia
;   Company: The Lomis Company of Virginia, R&D
;
;   Last Date Successfully Compiled: 10/15/20222
;
;   Programming Language: Assembly
;   Instruction Code Language: ASM80
;   Programming Syntax: CP/M Assembler Mnemonics (Intel-based)
;   System Processor: Intel 8080, i8080-based
;   Compiler: CP/M ASSEMBLER - VER 2.0
;
;   Target Computer: Altair 8800
;
;   Description: A front panel program for adding two words (8-Bits each), A and B, yielding 
;                an output, C. My first program written in Assembly. Runs on any Intel 8080-based computer.
;                System can be reset with lifting STOP and RESET together, this will cause the Program Counter
;                to reset  back to Memory Address 0c000000, revealing the answer to the operator.
;
;       Mathematical Formula: A + B = C
;
;       Input Memory Address  A, B: 0x0100, 0x0102
;       Output Memory Address C: 0x0104
;
;VARIABLE|      |MNEMONIC   |OPERAND        |COMMENT(S)
;   OUT-C:      EQU         000000Q         | OUTPUT C - Result of Register A is outputted here (answer)
;    IN-A:      EQU         000001Q         | INPUT A - First word (binary/decimal)
;    IN-B:      EQU         000002Q         | INPUT B - Second word (binary/decimal)
                ORG         000007Q         ; Sets the 8080's Program Counter to 0o000007. Programming will be entered from memory address 0o000007 onward
                LHLD        000001Q         ; Writes the value located at memory address 0o000001 to Register L (IN-A)
                LDA         000002Q         ; Writes the value located at memory address 0o000002 to Register A (IN-B)
                ADD         L               ; Performs binary/decimal addition of Register A and L, replacing its answer back into Register A
                STA         000000Q         ; Copies Register A's contents and writes it to memory address 0o000000 (OUT-C)
                HLT                         ; Halt the 8080
                END                         ; End of Assembly Instruction
