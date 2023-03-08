%                                                                                                       
%   Title: Length Converter
%   Developer: Daniel J. Lomis
%   Date Written: March 7, 2023
%   Location: McLean, Virginia
%   Company: The Lomis Company of Virginia, R&D
%
%   Developed specifically for Programming Assignment #1
%   Under Supervision of Doctor David Lin
%   Northern Virginia Community College - Manassas Campus
%   Engineering Design (EGR 122)
%
%   Last Successful Compile: 19:26 3/7/2023
%
%   Programming Language: MATLAB 9.13.0.2126072 (R2022b) Update 3
%   Compiler: MATLAB IDE
%
%   Description:  Converts from centimeters to inches via input from user.
%
clc;
fprintf("Welcome to the Length Converter Program!\nWrtitten by Daniel J. Lomis\n\n");
pause(2);
starting_length = input("Please enter the length (centimeters): ");
final_length = starting_length/2.54;
clc;
fprintf("Welcome to the Length Converter Program!\nWrtitten by Daniel J. Lomis\n\n");
fprintf("The value, %g cm, in inches is %g. \n",starting_length, final_length);
pause(1);
fprintf("\nGoodbye! Exiting...\n")
pause(2);
%END OF FILE