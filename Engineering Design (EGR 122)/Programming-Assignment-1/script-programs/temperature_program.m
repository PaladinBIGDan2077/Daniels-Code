%                                                                                                       
%   Title: Temperature Converter
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
%   Last Successful Compile: 19:34 3/7/2023
%
%   Programming Language: MATLAB 9.13.0.2126072 (R2022b) Update 3
%   Compiler: MATLAB IDE
%
%   Description:  Converts from celsius to fahrenheit via input from user.
%
clc;
fprintf("Welcome to the Temperature Converter Program!\nWrtitten by Daniel J. Lomis\n\n");
pause(2);
starting_temperature = input("Please enter the temperature (celsius): ");
final_temperature = (((starting_temperature)*(9/5))+32);
clc;
fprintf("Welcome to the Temperature Converter Program!\nWrtitten by Daniel J. Lomis\n\n");
fprintf("The value, %g°C, in Fahrenheit is %g degrees. \n",starting_temperature, final_temperature);
pause(1);
fprintf("\nGoodbye! Exiting...\n")
pause(2);
%END OF FILE