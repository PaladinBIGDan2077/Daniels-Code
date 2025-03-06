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
                .globl          INT
                .globl          main
                .globl          FIB_CALC
                .globl          PRNT_PREP
                .globl          PRINT
                .globl          PRINT_NXT
                .globl          HALT

                .data 
      fib:      .word           0 : 10                          # "array" of 12 words to contain fib values
    chonk:      .word           10                              # size of "array 
    space:      .asciiz         " "                             # space to insert between numbers
     head:      .asciiz         "\nThe Fibnums is:\n"

                .text
      INT:  
                la              $t0, fib                        # load address of array
                la              $t5, chonk                      # load address of size variable
                lw              $t5, 0($t5)                     # load array size
                li              $t2, 1                          # 1 is first and second Fib. number
                sw              $t2, 0($t0)                     # F[0] = 1
                sw              $t2, 4($t0)                     # F[1] = F[0] = 1
                addi            $t1, $t5, -2                    # Counter for loop, will execute (size-2) times
                sw              $sp, 4($t0)                      # store loop counter
                sw              $sp, 0($t0)                      # store loop counter
                jr              $ra                             # return
 FIB_CALC:
                lw              $t3, 0($sp)                        # Get value from array F[n] 
                lw              $t4, 4($sp)                        # Get value from array F[n+1]
                add             $t2, $t3, $t4                   # $t2 = F[n] + F[n+1]
                sw              $sp, 8($t0)
                addi            $t0, $t0, 4                     # increment address of Fib. number source
                addi            $t1, $t1, -1                    # decrement loop counter
                sw              $sp, 0($t3)                        # store new Fib. number
                sw              $sp, 4($t2)                        # store new Fib. number   
                jr              $ra                             # return
PRNT_PREP:
                la              $a0, fib                        # first argument for print (array)
                add             $a1, $zero, $t5                 # second argument for print (size)
                jr		        $ra					            # jump to $ra

    PRINT:
                add             $t0, $zero, $a0                 # starting address of array
                add             $t1, $zero, $a1                 # initialize loop counter to array size
                la              $a0, head                       # load address of print heading
                li              $v0, 4                          # specify Print String service
                syscall                                         # print heading
                jr              $ra                             # return
PRINT_NXT:
                lw              $a0, 0($t0)                     # load fibonacci number for syscall   
                li              $v0, 1                          # specify Print Integer service
                syscall                                         # print fibonacci number
                la              $a0, space                      # load address of spacer for syscall
                li              $v0, 4                          # specify Print String service
                syscall                                         # output string
                addi            $t0, $t0, 4                     # increment address
                addi            $t1, $t1, -1                    # decrement loop counter
                jr              $ra                             # return
     
     HALT:
	 			li				$v0, 10 				        # Load system call for exit
				syscall
     
     main:
                jal             INT                             # initialize the array
                jal             FIB_CALC                        # calculate the Fibonacci numbers
                bgtz            $t1, FIB_CALC                   # repeat if not finished yet.
                jal             PRNT_PREP                       # prepare for printing
                jal             PRINT                           # print the first two numbers
                bgtz            $t1, PRINT_NXT                  # repeat if not finished
                j               HALT                            # end program