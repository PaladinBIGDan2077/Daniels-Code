"""
Developed specifically for Programming Assignment #3
Under Supervision of Professor David Lin
Northern Virginia Community College - Annandale Campus
Introduction to Engineering Methods (EGR125)
Completed 2/19/2021 at 6:45PM EST

Description:
This is the Fallout Data Cruncher, which produces the maximum and minimum values of a given list. It also produces the amount of values within a given tolerance.
This module is designed to work with the Ballpoint Data Processor - v1.1.

The Fallout Data Cruncher v1.1 for Python 3.9.1 -- Written by Daniel J. Lomis 
This program is protected under the GNU General Public License GPL v3.0.
"""
def megaton(balls):
    balls.sort()
    e = balls[0]
    return e

def sanctuary(balls):
    balls.sort(reverse=True)
    f = balls[0]
    balls.sort()
    return f

def diamondcity(balls):
    count = 0
    g = len(balls)
    for i in range(g):
        if (792 <= balls[i] <= 808):
            count += 1
    return count