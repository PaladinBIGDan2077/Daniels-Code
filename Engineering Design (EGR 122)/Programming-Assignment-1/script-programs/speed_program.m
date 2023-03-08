%                                                                                                       
%   Title: Speed Converter
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
%   Last Successful Compile: 19:46 3/7/2023
%
%   Programming Language: MATLAB 9.13.0.2126072 (R2022b) Update 3
%   Compiler: MATLAB IDE
%
%   Description:  Converts from meters/second to miles/hour via input from user.
%
clc;
fprintf("Welcome to the Speed Converter Program!\nWrtitten by Daniel J. Lomis\n\n");
pause(2);
start_speed = input("Please enter the speed (m/s): ");
final_speed = ((start_speed)*(2.237));
clc;
fprintf("Welcome to the Speed Converter Program!\nWrtitten by Daniel J. Lomis\n\n");
fprintf("The value, %g m/s, in MPH is %g. \n",start_speed, final_speed);
pause(1);
fprintf("\nGoodbye! Exiting...\n")
pause(2);
%END OF FILE