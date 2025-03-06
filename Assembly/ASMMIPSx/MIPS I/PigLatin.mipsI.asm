#   Title: Pig-Latin Translator Program
#   Developer: Deepseek, Daniel J. Lomis
#   Date Written: March 5, 2025
#   Location: McLean, Virginia
#   Organization: Virginia Polytechnic Institute and State University, Bradley Department of Electrical and Computer Engineering
#   Course: ECE 3504 - Principles of Computer Architecture
#   Instructor: Dr. Scot Ransbottom
#
#   Last Successful Compile: 03/05/2025 @ 10:10
#
#   Programming Language: Assembly
#   Instruction Code Language: ASM MIPS I
#   Programming Syntax: QtSpim Assembler
#   System Processor (Instruction Set): MIPS R3000 (MIPS I)
#   Compiler: QtSpim Compiler v9.1.24
#
#   Target Computer: QtSpim Program Simulator
#
#   Description: A basic Pig-Latin translator program that takes an input string
#                and converts it to Pig-Latin. The program will prompt the user
#                to enter an alphabetic character string. It will then process the
#                input, validate it, and convert it to Pig-Latin. The program will
#                continue to prompt the user for input until the user enters "QUIT".
#                The program will then display the translated string and exit.
#                The program also handles backspace characters and invalid input.
#
#   Register Usage:
#                $v0 - System call parameter
#                $a0 - Argument for system calls (string addresses)
#                $t0-$t8 - Temporary registers for character operations and comparisons
#                $s0 - Input buffer address pointer
#                $s1 - Output buffer address pointer
#                $ra - Return address storage
#                $sp - Stack pointer for function call preservation
#
#   Pseudo-code Description:
#                1. Display input prompt
#                2. Read user input into buffer
#                3. Process backspace characters in input
#                4. Validate input contains only alphabetic characters
#                5. If input is "QUIT", display exit message and terminate
#                6. Else convert to Pig Latin:
#                   a. If word starts with vowel, append "way"
#                   b. If word starts with consonant cluster:
#                      i. Move cluster to end
#                      ii. Append "ay"
#                   c. If single consonant, move to end and append "ay"
#                7. Display translated result
#                8. Repeat until user enters "QUIT"
#
#               VARIABLE|       |MNEMONIC           |OPERAND                          |COMMENT(S)
                                .globl              main
                                .globl              process_backspace
                                .globl              validate_input
                                .globl              transform_to_pig_latin
                                .globl              main_loop
                                .globl              quit_program
                                .globl              transform_input
                                .globl              check_quit
                                .globl              check_quit2
                                .globl              check_quit3
                                .globl              remove_newline
                                .globl              end_remove_newline
                                .globl              append_way
                                .globl              append_sh_ay
                                .globl              append_ch_ay
                                .globl              append_th_ay
                                .globl              append_bl_ay
                                .globl              append_fl_ay
                                .globl              append_cl_ay
                                .globl              append_gl_ay
                                .globl              append_pl_ay
                                .globl              append_sl_ay
                                .globl              append_br_ay
                                .globl              append_cr_ay
                                .globl              append_dr_ay
                                .globl              append_fr_ay
                                .globl              append_gr_ay
                                .globl              append_pr_ay
                                .globl              append_tr_ay
                                .globl              append_sc_ay
                                .globl              append_sk_ay
                                .globl              append_sm_ay
                                .globl              append_sn_ay
                                .globl              append_sp_ay
                                .globl              append_st_ay
                                .globl              append_sw_ay
                                .globl              append_wh_ay
                                .globl              append_ph_ay
                                .globl              append_gh_ay
                                .globl              append_ay
                                .globl              handle_consonant
                                .globl              handle_single_consonant
                                .globl              is_sh
                                .globl              is_bl
                                .globl              is_fl
                                .globl              is_cl
                                .globl              is_th
                                .globl              is_ch
                                .globl              is_wh
                                .globl              is_ph
                                .globl              is_gh
                                .globl              is_gl
                                .globl              is_pl
                                .globl              is_sl
                                .globl              is_br
                                .globl              is_cr
                                .globl              is_dr
                                .globl              is_fr
                                .globl              is_gr
                                .globl              is_pr
                                .globl              is_tr
                                .globl              is_sc
                                .globl              is_sk
                                .globl              is_sm
                                .globl              is_sn
                                .globl              is_sp
                                .globl              is_st
                                .globl              is_sw
                                .globl              check_wh
                                .globl              check_ph
                                .globl              check_gh
                                .globl              check_sh
                                .globl              check_ch
                                .globl              check_th
                                .globl              check_bl
                                .globl              check_fl
                                .globl              check_cl
                                .globl              check_gl
                                .globl              check_pl
                                .globl              check_sl
                                .globl              check_br
                                .globl              check_cr
                                .globl              check_dr
                                .globl              check_fr
                                .globl              check_gr
                                .globl              check_pr
                                .globl              check_tr
                                .globl              check_sc
                                .globl              check_sk
                                .globl              check_sm
                                .globl              check_sn
                                .globl              check_sp
                                .globl              check_st
                                .globl              check_sw
                                .globl              check_vowel
                                .globl              is_vowel
                                .globl              check_sh
                                .globl              check_lowercase
                                .globl              convert_to_upper
                                .globl              copy_input_vowel
                                .globl              copy_input_sh
                                .globl              copy_input_ch
                                .globl              copy_input_th
                                .globl              copy_input_bl
                                .globl              copy_input_fl
                                .globl              copy_input_cl
                                .globl              copy_input_gl
                                .globl              copy_input_pl
                                .globl              copy_input_sl
                                .globl              copy_input_br
                                .globl              copy_input_cr
                                .globl              copy_input_dr
                                .globl              copy_input_fr
                                .globl              copy_input_gr
                                .globl              copy_input_pr
                                .globl              copy_input_tr
                                .globl              copy_input_sc
                                .globl              copy_input_sk
                                .globl              copy_input_sm
                                .globl              copy_input_sn
                                .globl              copy_input_sp
                                .globl              copy_input_st
                                .globl              copy_input_sw
                                .globl              copy_input_wh
                                .globl              copy_input_ph
                                .globl              copy_input_gh
                                .globl              copy_input_ay
                                .globl              return_cl
                                .globl              return_gl
                                .globl              return_pl
                                .globl              return_sl
                                .globl              return_br
                                .globl              return_cr
                                .globl              return_fr
                                .globl              return_gr
                                .globl              return_pr
                                .globl              return_tr
                                .globl              return_sc
                                .globl              return_sk
                                .globl              return_sm
                                .globl              return_sn
                                .globl              return_sp
                                .globl              return_st
                                .globl              return_sw
                                .globl              return_wh
                                .globl              return_ph
                                .globl              return_gh
                                .globl              return_sh
                                .globl              return_ch
                                .globl              return_th
                                .globl              return_bl
                                .globl              return_fl
                                .globl              return_ay
                                .globl              copy_input_consonant
                                .globl              transform_done
                                .globl              handle_backspace
                                .globl              skip_backspace
                                .globl              end_process

                                .data                                                   # Program data section
                   input:       .space              100                                 # Buffer to store user input
                  output:       .space              100                                 # Buffer to store Pig-Latin output
                  prompt:       .asciiz             "Enter an alphabetic character string (QUIT to exit): "
               error_msg:       .asciiz             "Invalid input. Please enter only alphabetic characters.\n"
                quit_msg:       .asciiz             "Thank You! QUIT translates to: UITQay. Good Bye!\n"
          translated_msg:       .asciiz             " translates to: "
                 newline:       .asciiz             "\n"

                                .text                                                   # Program code section
                    main:                                                               # Main program entry point  
               main_loop:                                               
                                li                  $v0, 4                              # Print prompt
                                la                  $a0, prompt                         # Load address of prompt
                                syscall                                
                                li                  $v0, 8                              # Read input
                                la                  $a0, input                          # Load address of input buffer
                                li                  $a1, 100                            # Maximum number of characters to read
                                syscall                           
                                la                  $t0, input                          # Remove newline character from input
          remove_newline:
                                lb                  $t1, 0($t0)                         # Load byte from input
                                beq                 $t1, '\n', replace_newline          # If newline, replace with null terminator
                                beqz                $t1, end_remove_newline             # If null terminator, end removal
                                addiu               $t0, $t0, 1                         # Move to next character
                                j                   remove_newline
         replace_newline:
                                sb                  $zero, 0($t0)                       # Replace newline with null terminator
      end_remove_newline:                                                               # Process backspace characters
                                jal                 process_backspace
                        
                                jal                 validate_input                      # Validate input

                                la                  $t0, input                          # Check for QUIT
                                lb                  $t1, 0($t0)                         # Load first character
                                lb                  $t2, 1($t0)                         # Load second character
                                lb                  $t3, 2($t0)                         # Load third character
                                lb                  $t4, 3($t0)                         # Load fourth character
                                beq                 $t1, 'Q', check_quit                # If first character is 'Q', check for QUIT
                                j                   transform_input
              check_quit:
                                beq                 $t2, 'U', check_quit2               # If second character is 'U', continue checking
                                j                   transform_input
             check_quit2:
                                beq                 $t3, 'I', check_quit3               # If third character is 'I', continue checking
                                j                   transform_input
             check_quit3:
                                beq                 $t4, 'T', quit_program              # If fourth character is 'T', quit program
                                j                   transform_input
            quit_program:
                                li                  $v0, 4                              # Print quit message
                                la                  $a0, quit_msg                       # Load address of quit message
                                syscall
                                li                  $v0, 10                             # Exit program
                                syscall
         transform_input:                                                               # Call transformation function
                                jal                 transform_to_pig_latin              # Transform input to Pig-Latin
                                li                  $v0, 4                              # Print transformed string
                                la                  $a0, input                          # Load address of input
                                syscall
                                la                  $a0, translated_msg                 # Load address of translated message
                                syscall
                                la                  $a0, output                         # Load address of output
                                syscall
                                la                  $a0, newline                        # Load address of newline
                                syscall                                                 # Repeat loop
                                j                   main_loop
          validate_input:                                                               # Input validation logic
                                la                  $t0, input                          # Load address of input
           validate_loop:
                                lb                  $t1, 0($t0)                         # Load byte from input
                                beqz                $t1, end_validate                   # If null terminator, end validation
                                blt                 $t1, 'A', invalid_input             # If character is less than 'A', invalid
                                bgt                 $t1, 'Z', check_lowercase           # If character is greater than 'Z', check lowercase
                                addiu               $t0, $t0, 1                         # Move to next character
                                j                   validate_loop
         check_lowercase:
                                blt                 $t1, 'a', invalid_input             # If character is less than 'a', invalid
                                bgt                 $t1, 'z', invalid_input             # If character is greater than 'z', invalid
                                addiu               $t0, $t0, 1                         # Move to next character
                                j                   validate_loop
           invalid_input:                                                               # Print error message
                                li                  $v0, 4                              # Print error message
                                la                  $a0, error_msg                      # Load address of error message
                                syscall
                                j                   main_loop                           # Repeat main loop
            end_validate:
                                jr                  $ra                                 # Return to caller
  transform_to_pig_latin:                                                               # Save registers to the stack
                                addiu               $sp, $sp, -12                       # Allocate space on stack
                                sw                  $ra, 0($sp)                         # Save return address
                                sw                  $s0, 4($sp)                         # Save $s0
                                sw                  $s1, 8($sp)                         # Save $s1
                                la                  $s0, input                          # Load address of input string
                                la                  $s1, output                         # Load address of output buffer
                                nop                                                     # Check if the first character is a vowel
                                lb                  $t0, 0($s0)                         # Load the first character of the input
                                li                  $t1, 'A'                            # Load 'A' for comparison
                                li                  $t2, 'E'                            # Load 'E' for comparison
                                li                  $t3, 'I'                            # Load 'I' for comparison
                                li                  $t4, 'O'                            # Load 'O' for comparison
                                li                  $t5, 'U'                            # Load 'U' for comparison
                                nop                                                     # Convert to uppercase for comparison
                                bge                 $t0, 'a', convert_to_upper          # If lowercase, convert to uppercase
                                j                   check_vowel
        convert_to_upper:
                                sub                 $t0, $t0, 32                        # Convert lowercase to uppercase
             check_vowel:
                                beq                 $t0, $t1, is_vowel                  # Check if first character is 'A'
                                beq                 $t0, $t2, is_vowel                  # Check if first character is 'E'
                                beq                 $t0, $t3, is_vowel                  # Check if first character is 'I'
                                beq                 $t0, $t4, is_vowel                  # Check if first character is 'O'
                                beq                 $t0, $t5, is_vowel                  # Check if first character is 'U'
                                nop                                                     # If not a vowel, handle consonant case
                                j                   handle_consonant
                is_vowel:                                                               # If the first character is a vowel, append "way" to the input
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7

        copy_input_vowel:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_way                     # If null terminator, append "way"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_vowel
              append_way:
                                li                  $t8, 'w'                            # Append 'w'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
        handle_consonant:
                                lb                  $t0, 0($s0)                         # Load first character
                                lb                  $t1, 1($s0)                         # Load second character
                                nop                                                     # Check for consonant clusters
                                la                  $ra, return_sh
                                li                  $t2, 's'                            # Check for 's'
                                li                  $t3, 'h'                            # Check for 'h'
                                beq                 $t0, $t2, check_sh                  # If first character is 's', check for 'h'
               return_sh:                                                               # Return to caller
                                la                  $ra, return_ch                      # Load return address for 'ch'
                                li                  $t2, 'c'                            # Check for 'c'
                                beq                 $t0, $t2, check_ch                  # If first character is 'c', check for 'h'
               return_ch:                                                               # Return to caller
                                la                  $ra, return_th                      # Load return address for 'th'
                                li                  $t2, 't'                            # Check for 't'     
                                beq                 $t0, $t2, check_th                  # If first character is 't', check for 'h'
               return_th:                                                               # Return to caller
                                la                  $ra, return_wh                      # Load return address for 'wh'
                                li                  $t2, 'w'                            # Check for 'w'
                                beq                 $t0, $t2, check_wh                  # If first character is 'w', check for 'h'
               return_wh:                                                               # Return to caller
                                la                  $ra, return_ph                      # Load return address for 'ph'
                                li                  $t2, 'p'                            # Check for 'p'
                                beq                 $t0, $t2, check_ph                  # If first character is 'p', check for 'h'
               return_ph:                                                               # Return to caller
                                la                  $ra, return_gh                      # Load return address for 'gh'
                                li                  $t2, 'g'                            # Check for 'g'
                                beq                 $t0, $t2, check_gh                  # If first character is 'g', check for 'h'
               return_gh:                                                               # Return to caller
                                la                  $ra, return_bl                      # Load return address for 'bl'
                                li                  $t2, 'b'                            # Check for 'b'
                                li                  $t3, 'l'                            # Check for 'l'
                                beq                 $t0, $t2, check_bl                  # If first character is 'b', check for 'l'
               return_bl:                                                               # Return to caller
                                la                  $ra, return_cl                      # Load return address for 'cl'
                                li                  $t2, 'c'                            # Check for 'c'
                                beq                 $t0, $t2, check_cl                  # If first character is 'c', check for 'l'
               return_cl:                                                               # Return to caller
                                la                  $ra, return_fl                      # Load return address for 'fl'
                                li                  $t2, 'f'                            # Check for 'f'
                                beq                 $t0, $t2, check_fl                  # If first character is 'f', check for 'l'
               return_fl:                                                               # Return to caller
                                la                  $ra, return_gl                      # Load return address for 'gl'
                                li                  $t2, 'g'                            # Check for 'g'
                                beq                 $t0, $t2, check_gl                  # If first character is 'g', check for 'l'
               return_gl:                                                               # Return to caller
                                la                  $ra, return_pl                      # Load return address for 'pl'
                                li                  $t2, 'p'                            # Check for 'p'
                                beq                 $t0, $t2, check_pl                  # If first character is 'p', check for 'l'
               return_pl:                                                               # Return to caller
                                la                  $ra, return_sl                      # Load return address for 'sl'
                                li                  $t2, 's'                            # Check for 's'
                                beq                 $t0, $t2, check_sl                  # If first character is 's', check for 'l'
               return_sl:                                                               # Return to caller
                                la                  $ra, return_br                      # Load return address for 'br'
                                li                  $t2, 'b'                            # Check for 'b'
                                li                  $t3, 'r'                            # Check for 'r'
                                beq                 $t0, $t2, check_br                  # If first character is 'b', check for 'r'
               return_br:                                                               # Return to caller
                                la                  $ra, return_cr                      # Load return address for 'cr'
                                li                  $t2, 'c'                            # Check for 'c'
                                beq                 $t0, $t2, check_cr                  # If first character is 'c', check for 'r'
               return_cr:                                                               # Return to caller
                                la                  $ra, return_dr                      # Load return address for 'dr'
                                li                  $t2, 'd'                            # Check for 'd'
                                beq                 $t0, $t2, check_dr                  # If first character is 'd', check for 'r'
               return_dr:                                                               # Return to caller
                                la                  $ra, return_fr                      # Load return address for 'fr'
                                li                  $t2, 'f'                            # Check for 'f'
                                beq                 $t0, $t2, check_fr                  # If first character is 'f', check for 'r'
               return_fr:                                                               # Return to caller
                                la                  $ra, return_gr                      # Load return address for 'gr'
                                li                  $t2, 'g'                            # Check for 'g'
                                beq                 $t0, $t2, check_gr                  # If first character is 'g', check for 'r'
               return_gr:                                                               # Return to caller
                                la                  $ra, return_pr                      # Load return address for 'pr'
                                li                  $t2, 'p'                            # Check for 'p'
                                beq                 $t0, $t2, check_pr                  # If first character is 'p', check for 'r'    
               return_pr:                                                               # Return to caller
                                la                  $ra, return_tr                      # Load return address for 'tr'
                                li                  $t2, 't'                            # Check for 't'
                                beq                 $t0, $t2, check_tr                  # If first character is 't', check for 'r'
               return_tr:                                                               # Return to caller
                                la                  $ra, return_sc                      # Load return address for 'sc'
                                li                  $t2, 's'                            # Check for 's'
                                li                  $t3, 'c'                            # Check for 'c'
                                beq                 $t0, $t2, check_sc                  # If first character is 's', check for 'c'
               return_sc:                                                               # Return to caller
                                la                  $ra, return_sk                      # Load return address for 'sk'
                                li                  $t3, 'k'                            # Check for 'k'
                                beq                 $t0, $t2, check_sk                  # If first character is 's', check for 'k'
               return_sk:                                                               # Return to caller
                                la                  $ra, return_sm                      # Load return address for 'sm'
                                li                  $t3, 'm'                            # Check for 'm'
                                beq                 $t0, $t2, check_sm                  # If first character is 's', check for 'm'
               return_sm:                                                               # Return to caller
                                la                  $ra, return_sn                      # Load return address for 'sn'
                                li                  $t3, 'n'                            # Check for 'n'
                                beq                 $t0, $t2, check_sn                  # If first character is 's', check for 'n'
               return_sn:                                                               # Return to caller
                                la                  $ra, return_sp                      # Load return address for 'sp'
                                li                  $t3, 'p'                            # Check for 'p'
                                beq                 $t0, $t2, check_sp                  # If first character is 's', check for 'p'
               return_sp:                                                               # Return to caller
                                la                  $ra, return_st                      # Load return address for 'st'
                                li                  $t3, 't'                            # Check for 't'
                                beq                 $t0, $t2, check_st                  # If first character is 's', check for 't'
               return_st:                                                               # Return to caller
                                la                  $ra, return_sw                      # Load return address for 'sw'
                                li                  $t3, 'w'                            # Check for 'w'
                                beq                 $t0, $t2, check_sw                  # If first character is 's', check for 'w'
               return_sw:                                                               # Return to caller
                                j                   handle_single_consonant             # If no consonant cluster matches, handle single consonant
                check_sh:
                                beq                 $t1, $t3, is_sh                     # Check if second character is 'h'
                                j                   $ra
                   is_sh:                                                               # Handle "sh" pair
                                addiu               $s0, $s0, 2                         # Move input pointer past "sh"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_sh:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_sh_ay                   # If null terminator, append "shay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_sh
            append_sh_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)                         # Store 's'            
                                addiu               $t7, $t7, 1                         # Increment output pointer    
                                li                  $t8, 'h'                            # Append 'h'
                                sb                  $t8, 0($t7)                         # Store 'h'
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)                         # Store 'a'    
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)                         # Store 'y'
                                addiu               $t7, $t7, 1                         # Increment output pointer    
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done                      # Return to caller    
                check_th:
                                beq                 $t1, $t3, is_th                     # Check if second character is 'h'
                                j                   $ra                                 # Return to caller
                   is_th:                                                               # Handle "th" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "th"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_th:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_th_ay                   # If null terminator, append "thay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_th                       # Repeat loop
            append_th_ay:
                                li                  $t8, 't'                            # Append 't'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'h'                            # Append 'h'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                 check_bl:
                                beq                 $t1, $t3, is_bl                     # Check if second character is 'l'
                                j                   $ra
                   is_bl:                                                               # Handle "bl" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "bl"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_bl:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_bl_ay                   # If null terminator, append "blay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_bl
            append_bl_ay:
                                li                  $t8, 'b'                            # Append 'b'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'l'                            # Append 'l'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_fl:
                                beq                 $t1, $t3, is_fl                     # Check if second character is 'l'
                                j                   $ra
                   is_fl:                                                               # Handle "fl" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "fl"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_fl:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_fl_ay                   # If null terminator, append "flay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_fl
            append_fl_ay:
                                li                  $t8, 'f'                            # Append 'f'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'l'                            # Append 'l'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_cl:
                                beq                 $t1, $t3, is_cl                     # Check if second character is 'l'
                                j                   $ra
                   is_cl:                                                               # Handle "cl" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "bl"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_cl:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_cl_ay                   # If null terminator, append "clay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_cl
            append_cl_ay:
                                li                  $t8, 'c'                            # Append 'c'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'l'                            # Append 'l'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_gl:
                                beq                 $t1, $t3, is_gl                     # Check if second character is 'l'
                                j                   $ra
                   is_gl:                                                               # Handle "gl" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "gl"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_gl:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_gl_ay                   # If null terminator, append "glay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_gl
            append_gl_ay:
                                li                  $t8, 'g'                            # Append 'g'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'l'                            # Append 'l'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_pl:
                                beq                 $t1, $t3, is_pl                     # Check if second character is 'l'
                                j                   $ra
                   is_pl:                                                               # Handle "pl" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "pl"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_pl:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_pl_ay                   # If null terminator, append "play"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_pl
            append_pl_ay:
                                li                  $t8, 'p'                            # Append 'p'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'l'                            # Append 'l'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_sl:
                                beq                 $t1, $t3, is_sl                     # Check if second character is 'l'
                                j                   $ra
                   is_sl:                                                               # Handle "sl" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "sl"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_sl:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_sl_ay                   # If null terminator, append "slay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_sl
            append_sl_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'l'                            # Append 'l'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_br:
                                beq                 $t1, $t3, is_br                     # Check if second character is 'r'
                                j                   $ra
                   is_br:                                                               # Handle "br" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "br"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_br:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_br_ay                   # If null terminator, append "bray"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_br
            append_br_ay:
                                li                  $t8, 'b'                            # Append 'b'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'r'                            # Append 'r'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_cr:
                                beq                 $t1, $t3, is_cr                     # Check if second character is 'r'
                                j                   $ra
                   is_cr:                                                               # Handle "cr" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "cr"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_cr:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_cr_ay                   # If null terminator, append "cray"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_cr
            append_cr_ay:
                                li                  $t8, 'c'                            # Append 'c'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'r'                            # Append 'r'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_dr:
                                beq                 $t1, $t3, is_dr                     # Check if second character is 'r'
                                j                   $ra
                   is_dr:                                                               # Handle "dr" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "dr"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_dr:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_dr_ay                   # If null terminator, append "dray"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_dr
            append_dr_ay:
                                li                  $t8, 'd'                            # Append 'd'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'r'                            # Append 'r'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_fr:
                                beq                 $t1, $t3, is_fr                     # Check if second character is 'r'
                                j                   $ra
                   is_fr:                                                               # Handle "fr" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "fr"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_fr:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_fr_ay                   # If null terminator, append "fray"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_fr
            append_fr_ay:
                                li                  $t8, 'f'                            # Append 'f'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'r'                            # Append 'r'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_gr:
                                beq                 $t1, $t3, is_gr                     # Check if second character is 'r'
                                j                   $ra
                   is_gr:                                                               # Handle "gr" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "gr"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_gr:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_gr_ay                   # If null terminator, append "gray"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_gr
            append_gr_ay:
                                li                  $t8, 'g'                            # Append 'g'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'r'                            # Append 'r'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_pr:
                                beq                 $t1, $t3, is_pr                     # Check if second character is 'r'
                                j                   $ra
                   is_pr:                                                               # Handle "pr" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "pr"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_pr:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_pr_ay                   # If null terminator, append "pray"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_pr
            append_pr_ay:
                                li                  $t8, 'p'                            # Append 'p'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'r'                            # Append 'r'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done               
                check_tr:
                                beq                 $t1, $t3, is_tr                     # Check if second character is 'r'
                                j                   $ra
                   is_tr:                                                               # Handle "tr" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "tr"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_tr:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_tr_ay                   # If null terminator, append "tray"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_tr
            append_tr_ay:
                                li                  $t8, 't'                            # Append 't'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'r'                            # Append 'r'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_sc:
                                beq                 $t1, $t3, is_sc                     # Check if second character is 'r'
                                j                   $ra
                   is_sc:                                                               # Handle "sc" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "sc"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_sc:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_sc_ay                   # If null terminator, append "scay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_sc
            append_sc_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'c'                            # Append 'c'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_sk:
                                beq                 $t1, $t3, is_sk                     # Check if second character is 'k'
                                j                   $ra
                   is_sk:                                                               # Handle "sk" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "sk"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_sk:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_sk_ay                   # If null terminator, append "skay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_sk
            append_sk_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'k'                            # Append 'k'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done                                         
                check_sm:
                                beq                 $t1, $t3, is_sm                     # Check if second character is 'm'
                                j                   $ra
                   is_sm:                                                               # Handle "sm" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "sm"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_sm:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_sm_ay                   # If null terminator, append "smay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_sm
            append_sm_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'm'                            # Append 'm'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done                                   
                check_sn:
                                beq                 $t1, $t3, is_sn                     # Check if second character is 'n'
                                j                   $ra
                   is_sn:                                                               # Handle "sn" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "sn"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_sn:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_sn_ay                   # If null terminator, append "snay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_sn
            append_sn_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'n'                            # Append 'n'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
                check_sp:
                                beq                 $t1, $t3, is_sp                     # Check if second character is 'p'
                                j                   $ra
                   is_sp:                                                               # Handle "sp" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "sp"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_sp:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_sp_ay                   # If null terminator, append "spay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_sp
            append_sp_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'p'                            # Append 'p'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done 
                check_st:
                                beq                 $t1, $t3, is_st                     # Check if second character is 't'
                                j                   $ra
                   is_st:                                                               # Handle "st" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "st"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_st:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_st_ay                   # If null terminator, append "stay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_st
            append_st_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 't'                            # Append 't'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done                    
                check_sw:
                                beq                 $t1, $t3, is_sw                     # Check if second character is 'w'
                                j                   $ra
                   is_sw:                                                               # Handle "sw" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "sw"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_sw:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_sw_ay                   # If null terminator, append "sway"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_sw
            append_sw_ay:
                                li                  $t8, 's'                            # Append 's'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'w'                            # Append 'w'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done              
                check_ch:
                                beq                 $t1, $t3, is_ch                     # Check if second character is 'h'
                                j                   $ra
                   is_ch:                                                               # Handle "ch" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "ch"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_ch:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_ch_ay                   # If null terminator, append "chay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_ch
            append_ch_ay:
                                li                  $t8, 'c'                            # Append 'c'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'h'                            # Append 'h'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done       
                check_wh:
                                beq                 $t1, $t3, is_wh                     # Check if second character is 'h'
                                j                   $ra
                   is_wh:                                                               # Handle "wh" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "wh"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_wh:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_wh_ay                   # If null terminator, append "whay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_wh
            append_wh_ay:
                                li                  $t8, 'w'                            # Append 'w'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'h'                            # Append 'h'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done       
                check_ph:
                                beq                 $t1, $t3, is_ph                     # Check if second character is 'h'
                                j                   $ra
                   is_ph:                                                               # Handle "ph" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "ph"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_ph:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_ph_ay                   # If null terminator, append "phay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_ph
            append_ph_ay:
                                li                  $t8, 'p'                            # Append 'p'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'h'                            # Append 'h'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done       
                check_gh:
                                beq                 $t1, $t3, is_gh                     # Check if second character is 'h'
                                j                   $ra
                   is_gh:                                                               # Handle "gh" cluster
                                addiu               $s0, $s0, 2                         # Move input pointer past "gh"
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
           copy_input_gh:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_gh_ay                   # If null terminator, append "ghay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_gh
            append_gh_ay:
                                li                  $t8, 'g'                            # Append 'g'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'h'                            # Append 'h'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
 handle_single_consonant:                                                               # Handle single consonant case
                                lb                  $t0, 0($s0)                         # Load first character
                                addiu               $s0, $s0, 1                         # Move input pointer past first character
                                move                $t6, $s0                            # Copy input address to $t6
                                move                $t7, $s1                            # Copy output address to $t7
    copy_input_consonant:
                                lb                  $t8, 0($t6)                         # Load byte from input
                                beqz                $t8, append_ay                      # If null terminator, append consonant and "ay"
                                sb                  $t8, 0($t7)                         # Store byte in output
                                addiu               $t6, $t6, 1                         # Increment input pointer
                                addiu               $t7, $t7, 1                         # Increment output pointer
                                j                   copy_input_consonant
               append_ay:
                                sb                  $t0, 0($t7)                         # Append the first consonant
                                addiu               $t7, $t7, 1
                                li                  $t8, 'a'                            # Append 'a'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                li                  $t8, 'y'                            # Append 'y'
                                sb                  $t8, 0($t7)
                                addiu               $t7, $t7, 1
                                sb                  $zero, 0($t7)                       # Null-terminate the output
                                j                   transform_done
          transform_done:                                                               # Restore registers from the stack
                                lw                  $ra, 0($sp)                         # Restore return address
                                lw                  $s0, 4($sp)                         # Restore $s0
                                lw                  $s1, 8($sp)                         # Restore $s1
                                addiu               $sp, $sp, 12                        # Deallocate stack space
                                jr                  $ra                                 # Return to caller

       process_backspace:                                                               # Process backspace characters in the input string
                                la                  $t0, input                          # Load address of input buffer
                                la                  $t1, input                          # Load address of input buffer (for writing)
                                la                  $t3, input                          # Load address of input buffer for comparison
            process_loop:
                                lb                  $t2, 0($t0)                         # Load byte from input
                                beqz                $t2, end_process                    # If null terminator, end processing
                                beq                 $t2, 8, handle_backspace            # If backspace character, handle it
                                sb                  $t2, 0($t1)                         # Store byte in output
                                addiu               $t0, $t0, 1                         # Move to next character in input
                                addiu               $t1, $t1, 1                         # Move to next position in output
                                j                   process_loop
        handle_backspace:
                                beq                 $t1, $t3, skip_backspace            # If at start of string, skip backspace
                                addiu               $t1, $t1, -1                        # Move back one position in output
                                addiu               $t0, $t0, 1                         # Move to next character in input
                                j                   process_loop
          skip_backspace:
                                addiu               $t0, $t0, 1                         # Move to next character in input
                                j                   process_loop
             end_process:
                                sb                  $zero, 0($t1)                       # Null-terminate the processed string
                                jr                  $ra                                 # Return to caller
# END OF PROGRAM