"""
Developed specifically for Programming Project #2
Under Supervision of Professor David Lin
Northern Virginia Community College - Annandale Campus
Introduction to Engineering Methods (EGR125)
Completed 4/9/2021 at 5:54PM EST

Description:
For my second project, the goal was to write a program that locates the roots of a given function. In this case, one was locating the height of water from within a tank based on 8 different volumes
(in a real world scenario, this would be used to draw evenly spaced lines to indicate the water level from empty to full). The other was to identify what values of time the make the electrical current
equal to 3.5 amperes. To determine these roots, I incorporated the SciPy Module, specifically the bisection method for both scenarios.

The Hydro-Electric Modeler - v1.1 for Python 3.9.1 -- Written by Daniel J. Lomis
This program is protected under the GNU General Public License GPL v3.0.
"""
from time import time as time
# Start program stopwatch
stopwatch_start = time()
# Libraries
from time import sleep as sleep
import numpy as np
import matplotlib.pyplot as plot
import scipy.optimize as opt
import math
# Begin program
print("\nWelcome to The Hydro-Electric Modeler - v1.1!")
print("Written by Daniel J. Lomis\n")
# Establishing our Assumptions
r = 1 #m
TankVolume = 8 #m³
# Solving for the cylinder length. Rather than give the value, it calculates the length to a very high precision due to pi
def length(r, TankVolume):
        L = (TankVolume/((r**2)*(math.pi)))
        return L
# Establishing the Volume function
def vol(L, r, h, V):
        f = (((((r**2)*(math.acos((r-h)/(r))))-((r-h)*(((2*r*h)-(h**2))**0.5)))*L)-V)
        return f
# Circuit analysis function
def current(t):
        I = (9*(math.exp((-1*t))*math.sin(2*math.pi*t))-3.5)
        return I
# Calculation of water height given each volume
L = length(r, TankVolume)
height_marker = []
for i in range(1, 9):
        V = i
        root = opt.bisect(lambda h: vol(L, r, h, V), 0.0, 2.0)
        height_marker.append(root)
# Outputting the measurements to console
print("Since the tank measures 2 meters in diameter, measurements will be given from 0m (ground level) to 2m (max)\n")
print("At 0 m³, the tank will be 0.0 m full")
for i in range(0, 8):
        mark = round(height_marker[i], 3)
        i = i + 1
        print("At",i,"m³, the tank will be",mark,"m full")
print()
stopwatch_end = (time() - stopwatch_start)
print("Sub-process completed in", round(stopwatch_end, 4),"seconds!\n")
stopwatch2_start = time()
# END OF TANK CALCULATIONS, BEGIN CURRENT CALCULATION
print("Program will pause for 5 seconds to allow for collection of data...\n")
sleep(5)
current_roots = []
seconds = [0, 0.25, 0.4, 0.75]
inf = 2
i = 0
while(inf > 0):
        t1 = seconds[i]
        i = i + 1
        t0 = seconds[i]
        t1 = float(t1)
        t0 = float(t0)
        roots = opt.bisect(lambda t: current(t), t1, t0)
        current_roots.append(roots)
        i = i + 1
        inf = inf - 1
print("Given the formula: current = (9/e^t)sin(2πt). When the current is 3.5 amperes, time is equal to...")
for i in range(len(current_roots)):
        print(round(current_roots[i], 8))
print()
stopwatch_end = (time() - stopwatch2_start)
print("Sub-process completed in", round(stopwatch_end, 4),"seconds!")        
stopwatch_end = (time() - stopwatch_start)
print("Program completed in", round(stopwatch_end, 4),"seconds!\n")
print("END OF LINE.")
"END OF FILE"