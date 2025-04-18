#   Title: Adder (Add Immediate) Program
#   Developer: Daniel J. Lomis
#   Date Written: February 6, 2025
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
#   System Processor (Instruction Set): MIPS R3000 (MIPS I)
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
   OUTPUT:      .space         	0     					        # OUTPUT - Result 
														        #	
	.globl 		main									        # Global directive assertion main
	.globl 		halt									        # Global directive assertion halt
												                #
	 .text												        # Begin Code Section
	 halt:
	 			li				$v0, 10 				        # Load system call for exit
				syscall
				.end 			halt					        # end of halt subroutine
	 main:												        # Start of main section
				addi			$t4, $zero, 123		            # Add INPUT A and zero
				addi			$t5, $t4, 2400                  # Add INPUT C to the sum of INPUT A and INPUT B
				addi 			$s0, $t5, 42	    	        # Add the sum of INPUT A and INPUT B to the sum of INPUT A, INPUT B, and INPUT C
				sw 				$s0, OUTPUT				        # Store the result in OUTPUT
				j				halt					        # jump to halt subroutine
				.end 			main					        # End of main program
# END OF PROGRAM