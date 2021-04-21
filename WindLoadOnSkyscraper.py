"""
Developed specifically for Programming Project #3
Under Supervision of Professor David Lin
Northern Virginia Community College - Annandale Campus
Introduction to Engineering Methods (EGR125)
Completed 4/21/2021 at 7:48PM EST

Description:
For my third and final assignment for Engineering 125, I was required to model uniform 
and nonuniform wind loading on a skyscraper and calculate the total force exerted on 
the side of the building and the maximum deflection of the tip. For uniform wind forces,
we were given a constant wind force of 500,000 N/m. For non uniform wind forces, I used a
curve of best fit to calculate a linearly negative sloping force from the top to bottom of the 
skyscraper. Basically, the tip has 1,000,000 N/m being blasted while the bottom has zero N/m,
using SciPy's optimize.curve_fit function to calculate a highly accurate slope from (0, 0) to 
(1000000, 425). Lastly, to assist with the simulated data values and produce a more accurate
result, I used SciPy's integrate.trapz function to model the data. This allows a area under the
curve calculation using the Trapezoidal Rule. Overall, a fun way to end the semester. These data
calculations are based on the professor's given simulation building of 432 Park Ave, New York City,
New York 10022.

The Building Wind Load Calculator - v1.2 for Python 3.9.1 -- Written by Daniel J. Lomis
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
import scipy.integrate as integrate
from statistics import mean
# Begin program
print("\nWelcome to The Building Wind Load Calculator - v1.2!")
print("Written by Daniel J. Lomis\n")
# Establishing our Assumptions
H = 425 #m (height of skyscraper)
L = H # For sake of code updating
I = 1805 #m⁴ (moment of inertia)
E = 200000000000 #N/m² (Young's Modulus)
uniform = 500000 #N/m (Uniform load)
linear = 1000000 #N/m (Linearly varying load, starting from tip)
# Mechanics of Materials, the derived deflection formula for an uniform load
def uniform_load(w, L, E, I):
        d = (((w)*((L)**4))/(8*(E)*(I)))
        return d
# Mechanics of Materials, the derived deflection formula for a linearly varying load
def linearly_varying_load(w0, L, E, I):
        d = ((11*(w0)*((L)**4))/(120*(E)*(I)))
        return d
# Height Data Point Generation from 0 to 425m in steps of 25
height = np.arange(0, 426, 25)
# Linearly decreasing height value best fit curve approximations
def best_fit_linear(x, a, b):
        return (a*x + b)
x_axis_cbf = np.linspace(0, linear, 18, dtype = int)
coeff, cov = opt.curve_fit(best_fit_linear, height, x_axis_cbf)
# Noise script for dataset's uniform load, used for calculating simulated data
noise = (2000*(np.random.normal(size = height.size)))
uniform_array = (uniform*(np.ones(len(height))))
uniform_N = uniform_array + noise
# Averaging of noisy uniform dataset, used for calculating total max -- Deprecated
w_avg = mean(uniform_N)
# Noise script for dataset's linear load, used for calculating simulated data
a = coeff[0]
b = coeff[1]
linear_array = []
for i in range(0, 426, 25):
        y = best_fit_linear(i, a, b)
        linear_array.append(y)
linear_array = np.asarray(linear_array)
linear_N = linear_array + noise
# Calculating the analytical total force for each data set
total_a_force_uniform = ((H)*(uniform))
total_a_force_linear = ((0.5)*(linear)*(H))
# Calculating the analytical max deflection for each data set
max_a_deflection_uniform = uniform_load(uniform, L, E, I)
max_a_deflection_linear = linearly_varying_load(linear, L, E, I)
# Integrating the discrete (incorporating noise) uniform data set to calculate total force
total_d_force_uniform = integrate.trapz(uniform_N, height)
# Integrating the discrete (incorporating noise) linear data set to calculate total force
total_d_force_linear = integrate.trapz(linear_N, height)
# averaging the discrete (incorporating noise) uniform data set to determine the max deflection
uniform_N_A = (total_d_force_uniform / 425)
max_d_deflection_uniform = uniform_load(uniform_N_A, L, E, I)
# averaging the discrete (incorporating noise) linear data set to determine the max deflection
linear_N_A = linear_N[-1]
max_d_deflection_linear = linearly_varying_load(linear_N_A, L, E, I)
# Outputting the measurements to console
print("The following has been calculated...")
print()
print("Uniform Load Data:")
print("The Maximum Deflection from the analytical data: ", max_a_deflection_uniform)
print("The Total Force acting against the skyscraper from analytical data: ", total_a_force_uniform)
print()
print("The Maximum Deflection from the discrete data: ", max_d_deflection_uniform)
print("The Total Force acting against the skyscraper from the discrete data: ", total_d_force_uniform)
print()
print("Linearly Varying Load Data:")
print("The Maximum Deflection from analytical data: ", max_a_deflection_linear)
print("The Total Force acting against the skyscraper from analytical data: ", total_a_force_linear)
print()
print("The Maximum Deflection from the discrete data: ", max_d_deflection_linear)
print("The Total Force acting against the skyscraper from the discrete data: ", total_d_force_linear)
print()
stopwatch_end = (time() - stopwatch_start)
print("Program completed in", round(stopwatch_end, 4),"seconds!\n")
print("END OF LINE.")
"END OF FILE"