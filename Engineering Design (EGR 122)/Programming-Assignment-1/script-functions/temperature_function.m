%                                                                                                       
%   Title: Temperature Converter - Function
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
%   Last Successful Compile: 20:04 3/7/2023
%
%   Programming Language: MATLAB 9.13.0.2126072 (R2022b) Update 3
%   Compiler: MATLAB IDE
%
%   Description:  Converts from celsius to fahrenheit. Requires input from
%   a master program.
%
function final_temperature = temperature_function(starting_temperature)
    final_temperature = (((starting_temperature)*(9/5))+32);
end
%   END OF FILE