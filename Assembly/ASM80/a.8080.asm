; Title: Adder (Add Immediate) Program
; Filename: a.intel8080.asm
; Developer: Daniel J. Lomis
; Date Written: February 6, 2025
; Location: Blacksburg, Virginia
; Organization: Virginia Polytechnic Institute and State University, Bradley Department of Electrical and Computer Engineering
; Course: ECE 3504 - Principles of Computer Architecture
; Instructor: Dr. Scot Ransbottom

; Last Successful Compile: 02/06/2025 @ 14:55

; Programming Language: Assembly
; Instruction Code Language: ASM Intel 8080
; Programming Syntax: TASM Assembler
; System Processor (Instruction Set): Intel 8080
; Compiler: TASM Compiler v3.2.1

; Target Computer: Intel 8080 Program Simulator

; Description: My first program written in Intel 8080 Assembly. Using the given
;              input values, A, B, and C, the program will add A and B, then
;              store the result in temp. It will then add B and C, storing the
;              result in another temp. Finally, it will add both temps, storing
;              the result in the OUTPUT variable.
;              The program will then halt using the halt instruction.

; Mathematical Formula: (A + B) => temp, (B + C) => temp2 | (temp + temp2) => OUTPUT

;VARIABLES
X:       DB      0         ; INPUT X - First byte
Y:       DB      0         ; INPUT Y - Second byte
OUTPUT:  DB      0         ; OUTPUT - Result

; Prompt messages
prmptin: DB      'Enter an integer for $'
prmptout: DB     'You entered $'
answer:  DB      'The answer... $'
XVAR:    DB      'X = $'
YVAR:    DB      'Y = $'

org      0000H

; Start of main section
start:
         MVI     A, 0        ; Initialize A
         STA     X           ; Store A in X
         MVI     A, 0        ; Initialize A
         STA     Y           ; Store A in Y
         MVI     A, 0        ; Initialize A
         STA     OUTPUT      ; Store A in OUTPUT

         ; Addition of A and B
         MOV     A, X        ; Load X into A
         ADD     Y           ; Add Y to A
         STA     OUTPUT      ; Store result in OUTPUT

         ; Print answer
         LXI     H, answer   ; Load the answer message
         CALL    printstr    ; Call print subroutine
         MOV     A, OUTPUT   ; Load OUTPUT into A
         CALL    printint    ; Call print integer subroutine
         
         HLT                 ; Halt the program

printstr:
         ; Implement subroutine for printing a string
         RET

printint:
         ; Implement subroutine for printing an integer
         RET

input:
         ; Implement subroutine for input
         RET

end start

; END OF PROGRAM
