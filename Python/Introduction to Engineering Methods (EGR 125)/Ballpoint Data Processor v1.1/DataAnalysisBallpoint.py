"""
Developed specifically for Programming Assignment #3
Under Supervision of Professor David Lin
Northern Virginia Community College - Annandale Campus
Introduction to Engineering Methods (EGR125)
Completed 2/19/2021 at 6:44PM EST

Description:
This is the Ballpoint Data Processor, which produces the mean, mode, median, standard deviation, minimum, maximum, and amount of data that falls 
within ±1% of 800μm of the dataset. This program simulates the gathering and processing of data from a ballpoint pen manufacturer, specifically the ball itself.
Rather than using an actual set of ballpoint diameters, this program automatically generates the dataset upon execution using the seed: 5000.

The Ballpoint Data Processor v1.1 for Python 3.9.1 -- Written by Daniel J. Lomis
This program is protected under the GNU General Public License GPL v3.0.
"""
import statistics
import random
import fallout

print("Welcome to the Ballpoint Data Processor - v1.1!")
print("Written by Daniel J. Lomis")
print()
print("Generating dataset values...")
# "Provides" the painstaking 1,000,000 measurements, between 780μm and 820μm, that were taken from physical data collecting at the factory (just kidding, these were generated out of thin air!)
random.seed(5000)
balls = []
for i in range(0, 1000000):
    x = random.randrange(780, 820)
    balls.append(x)
balls.sort()
print("Done!")
print()
print("Calculating statistics...")
# The statistical calculating bits
a = statistics.mean(balls)
b = statistics.mode(balls)
c = statistics.median(balls)
d = statistics.stdev(balls)
# Data processing from the fallout module: min, max, and tolerance
e = fallout.megaton(balls)
f = fallout.sanctuary(balls)
g = fallout.diamondcity(balls)
print("Done!")
print()
# Spits calculated data here...
print("Given the dataset seed of 5000, which generated over 1,000,000 data values between 780μm and 820μm. The following data has been produced:")
print()
print("The mean is", a)
print("The mode is", b)
print("The median is", c)
print("The standard deviation is", d)
print("The lower bound is", e)
print("The upper bound is", f)
print("There are", g ,"data values between ±1% of 800μm")
print("END OF LINE.")
"END OF FILE"


