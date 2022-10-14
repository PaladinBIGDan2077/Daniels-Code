;
;   Title: Memory Wiper (WIP)
;   Developer: Daniel J. Lomis
;   Date Written: October 13, 2022
;   Company: The Lomis Company of Virginia, Research and Development 
;
;   Date Sucessfully Compiled:
;
;   Programming Language: Assembly
;   Intruction Code Language: ASM80
;   System Architecture: Intel 8080
;
;   Target Computer: Altair 8800
;
;   Description: A basic Memry Erase Program. It essentially clears the entire system of 
;                memory. Whether it either a one pass of 0's and 1's, write all 0's, write
;                all 1's, or finally write all , unconfusing envitomrny 
;
;       Mathematical Formula: A + B = C 
;
;       Input Memory Address  A, B: 0x0100, 0x0102
;       Output Memory Address C: 0x0104
;
;   |LABEL      |MNEMONIC   |OPERAND    |COMMENTS
                .ORG        $FF00       ;   Sets the CPU's program counter to FF00. Programming will be entered from memory address 0xFF00 onward.
    REGVAR      .EQU        $0001       ;   Global variable, indicates which register to write the memory pattern with
                MVI         B,0055h	    ;   Writes the value 0x55 [01010101, base-2] to register B
	            MVI         C,00AAh       ;   Writes the value 0xAA [10101010, base-2] to register C
	            MVI         D,0000h       ;   Writes the value 0x00 [00000000, base-2] to register D
	            MVI         E,00FFh       ;   Writes the value 0xFF [11111111, base-2] to register E
	            LXI         H,0000h     ;   Writes the value 0x0000 [0000000000000000, base-2] to register pair HL    
	            MOV         M,          ;   
	            INR         M,1         ;   Increment the H-L register by 1, forcing the pair to point at the adjacent memory address
	            JMP         0010h       ;   Jumps the program counter to memory address 0x0010.
	            .ORG        $0040       ;   Sets the CPU's program counter to 40. Programming will be entered from memory address 0x0040 onward.
	            HLT                     ;   Halt the CPU
	            .END                    ;   End of Assembly Intruction
