%                                                                                                       
%   Title: The MEGA Converter!
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
%   Last Successful Compile: 21:20 3/7/2023
%
%   Programming Language: MATLAB 9.13.0.2126072 (R2022b) Update 3
%   Compiler: MATLAB IDE
%
%   Description: Performs various conversions at once: Centimeters to 
%   Inches, Celsius to Fahrenheit, Newtons to Pound-force, and meters per
%   second to miles per hour. Data is based on assignment's parameters. See
%   Requested Variables.
%
clc;
fprintf("The MEGA Converter!\nWritten by Daniel J. Lomis\n\n");
pause(2);
fprintf("Calculating assignment data...");
pause(1);
%   Requested Variables
starting_length = 5;
starting_temp   = 10;
starting_force  = 100;
starting_speed  = 100;
%   function execution
a = length_function(starting_length);
b = temperature_function(starting_temp);
c = force_function(starting_force);
d = speed_function(starting_speed);
%   print function
clc;
fprintf("The MEGA Converter!\nWritten by Daniel J. Lomis\n\n");
fprintf("The length result is %g In.\nThe temperature result is %g°F.\nThe force result is %g LBS.\nThe speed result is %g MPH.\n\n",a,b,c,d);
pause(2);
fprintf("Goodbye! Exiting...\n");
%   END OF FILE