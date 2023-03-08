%                                                                                                       
%   Title: Force Converter
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
%   Last Successful Compile: 19:40 3/7/2023
%
%   Programming Language: MATLAB 9.13.0.2126072 (R2022b) Update 3
%   Compiler: MATLAB IDE
%
%   Description:  Converts from newtons to pounds (LBS) via input from user.
%
clc;
fprintf("Welcome to the Force Converter Program!\nWrtitten by Daniel J. Lomis\n\n");
pause(2);
start_weight = input("Please enter the force (newtons): ");
final_weight = ((start_weight)/(4.448));
clc;
fprintf("Welcome to the Force Converter Program!\nWrtitten by Daniel J. Lomis\n\n");
fprintf("The value, %g N, in Pounds is %g. \n",start_weight, final_weight);
pause(1);
fprintf("\nGoodbye! Exiting...\n")
pause(2);
%END OF FILE