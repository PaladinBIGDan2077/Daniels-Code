#   Title: Adder (Functions, Variables, Console Interaction) Program
#   Filename: a.mipsI.asm
#   Developer: Daniel J. Lomis
#   Date Written: February 17, 2025
#   Location: Blacksburg, Virginia
#   Organization: Virginia Polytechnic Institute and State University, Bradley Department of Electrical and Computer Engineering
#	Course: ECE 3504 - Principles of Computer Architecture
#   Instructor: Dr. Scot Ransbottom
#
#   Last Successful Compile: 02/06/2025 @ 14:55
#
#   Programming Language: Assembly
#   Instruction Code Language: ASM MIPS I
#   Programming Syntax: QtSpim Assembler
#   System Processor (Instruction Set): MIPS R2000 (MIPS I)
#   Compiler: QtSpim Compiler v9.1.24
#
#   Target Computer: QtSpim Program Simulator
#
#   Description: My first program written in MIPS Assembly. Using the given
#                input values, A, B, and C, the program will add A and B, then
#                store the result in t4. It will then add B and C, storing the
#                result in t5. Finally, it will add t4 and t5, storing the result
#                in s0, which in turn will store it in the OUTPUT variable.
#				 The program will then halt using the halt subroutine.
#
#       Mathematical Formula: (A + B) => t4, (B + C) => t5 | (t4 + t5) => OUTPUT
#
#       Input Register File (A, B, C):  t1, t2, t3
#       ALU Register File:  t4, t5
#       Output Register File (OUTPUT): s0  
#
#VARIABLE|      |MNEMONIC   	|OPERAND    			        |COMMENT(S)
	 .data          									        # Data declaration section
        X:   	.word           0           			        # INPUT X - First  word
        Y:      .word           0           			        # INPUT Y - Second  word
   OUTPUT:      .word           1     					        # OUTPUT - Result 
                                                                #
  prmptin:      .asciiz         "Enter an integer for "         # Prompt for integer
 prmptout:      .asciiz         "You entered "                  # Resulting input
   answer:      .asciiz         "The answer... "                # Answer output
     XVAR:      .asciiz         "X = "                          # X variable placeholder
     YVAR:      .asciiz         "Y = "                          # Y variable placeholder

	.globl 		main									        # Global directive assertion main
	.globl 		halt									        # Global directive assertion halt
    .globl      print                                           # Global directive assertion print
    .globl      input                                           # Global directive assertion input
    .globl      varstr                                          # Global directive assertion varstr
    .globl      varint                                          # Global directive assertion varint
												                #
	 .text												        # Begin Code Section
   varint:
                sw              $t0, X($zero)                  # Load system call for read integer
                sw              $t1, Y($zero)                   # Load system call for read integer
                sw              $s0, OUTPUT($zero)               # Load system call for read integer
                jr		        $ra					             # return to main   
	 halt:
	 			li				$v0, 10 				        # Load system call for exit
				syscall
 printstr:
	 			li				$v0, 4  				        # Load system call for print string				
                syscall
                jr		        $ra					             # return to main
 printint:
	 			li				$v0, 1  				        # Load system call for print string				
                syscall
                jr		        $ra					             # return to main
    input:
	 			li				$v0, 5  				        # Load system call for read integer				
                syscall
                jr		        $ra					             # return to main
   varstr:                                                      # Start of variable retrieval
                add             $t7, $zero, $ra                  # zero v0 register
                la              $a0, prmptin($zero)             # Load system call for print integer
                jal		        printstr				            # jump to target and save position to $ra
                la              $a0, XVAR($zero)                # Load system call for print integer
                jal		        printstr				            # jump to target and save position to $ra
                jal             input                           # jump to target and save position to $ra
                add             $t0, $zero, $v0                   # Load system call for read integer
                jal             varint
                addi            $v0, $zero, 0                   # zero v0 register
                la              $a0, prmptin($zero)             # Load system call for print integer
                jal		        printstr				            # jump to target and save position to $ra
                la              $a0, YVAR($zero)                # Load system call for print integer
                jal		        printstr				            # jump to target and save position to $ra
                jal             input                           # jump to target and save position to $ra
                add              $t1, $zero, $v0                      # Load system call for read integer
                jal             varint
                addi            $v0, $zero, 0                   # zero v0 register
                add             $ra, $zero, $t7                   # zero v0 register
                j		        $ra					             # return to main
     main:												        # Start of main section
                jal             varint                          # jump to target and save position to $ra
                jal             varstr                          # jump to target and save position to $ra
				add			    $s0, $t0, $t1                    # Add INPUT C to the sum of INPUT A and INPUT B
                jal             varint
                la              $a0, answer($zero)              # Load system call for print integer
                jal		        printstr				            # jump to target and save position to $ra
                lw              $a0, OUTPUT($zero)              # Load system call for print integer
                jal             varint                          # jump to target and save position to $ra
                jal             printint				            # jump to target and save position to $ra
                jal				halt					        # jump to halt subroutine
# END OF PROGRAM