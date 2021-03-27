"""
Developed specifically for Programming Project #1
Under Supervision of Professor David Lin
Northern Virginia Community College - Annandale Campus
Introduction to Engineering Methods (EGR125)
Completed 3/27/2021 at 12:29AM EST

Description:
For my first ever project, I was required to write a program which calculates the approximate human population
for every ten years since 10,000 BCE until 2100 AD. Using the logistic population equation, my program calculates the
population based on six different growth rate values: 0.07%, 0.08%, 0.09%, 0.10%, 0.11%, and 0.12%. In addition to
growth rate, it also had to calculate for  three different limiting populations (8,000,000,000, 10,900,000,000, 
and 12,000,000,000), yielding 18 separate data sets. After the data is successfully processed, each of the 18 population
data sets are placed on a three graphs, each separated by the limiting population. This is saved as a jpeg within the present
working directory of the python interpreter. Lastly, I was required to locate a specific combination of the limiting population
and growth rate that approximates the 2020 world population (~7,800,000,000). I assume that the closest value will yield
the best represented growth rate based on the recommend population limit.

Overall, what I have here is nice. I am proud of the technique I used to generate the 18 data sets. Its a clever use
of FOR loops, the first represents the changing growth rates, the second represents the changing population limits, and the
last represents each population counted from t = 0 (10,000 BCE) to t = 12101 (2100 AD) based on increments of one decade. Each time
the population set is calculated, it is appended to a list as an element. By the end of the loop's run it would total 21,798 separate decades.
All of it condensed into on list: population. While some parts definitely can be streamlined, I am satisfied with what I have created.
This programs marks the first use of a program stopwatch. While it is unimportant for the goal, I find it useful in determining how long the program takes to complete the process.

The Population Modeler - v2.1 for Python 3.9.1 -- Written by Daniel J. Lomis
This program is protected under the GNU General Public License GPL v3.0.
"""
from time import time_ns
# Start program stopwatch
stopwatch_start = time_ns() 
import numpy as np
import matplotlib.pyplot as plot
from math import exp
print("\nWelcome to The Population Modeler - v2.1!")
print("Written by Daniel J. Lomis\n")
print("Processing...\n")
# Assuming 4 million for the initial population
Po = 4000000
# Creation of the Four 1D arrays
# Array 1, Time from t = 0 and t = 12,100 in steps of 10 years
calender = []
for i in range(-10000, 2101, 10):
    calender.append(i)
time = []
for i in range(0, 12101, 10):
    time.append(i)
# Population for each year in the time array
population = []
percent_range = [0.07, 0.08, 0.09, 0.1, 0.11, 0.12]
finalval_range = [8000000000, 10900000000, 12000000000]
pop_index = 0
pop_list = []
for j in range(0, 6):
    # For loop that changes the growth rate
    percent = percent_range[j]
    for k in range(0, 3):
        # For loop that changes the limiting population
        K = finalval_range[k]
        for i in range(0, 12101, 10):
            # For loop that calculates the population for every decade, appending to the pop_list.
            r = percent * 0.01
            x = r*i
            pop_numerator = (K*Po*(exp(x)))
            pop_denominator = (K+Po*((exp(x))-1))
            pop_divided = pop_numerator/pop_denominator
            pop_list.append(pop_divided)
        # Each combination of limiting population and growth rate is appended as an element to the population list, which evolves into a 18D array with 1,210 values in each demension
        population.insert(pop_index, pop_list)
        pop_list = []
        pop_index = pop_index + 1
# Conversion of all 1D lists into 1D arrays. Datasets plot better in this configuration with matplotlib
time_array = np.asarray(time)
x = np.asarray(calender)
y0 = np.asarray(population[0])
y1 = np.asarray(population[1])
y2 = np.asarray(population[2])
y3 = np.asarray(population[3])
y4 = np.asarray(population[4])
y5 = np.asarray(population[5])
y6 = np.asarray(population[6])
y7 = np.asarray(population[7])
y8 = np.asarray(population[8])
y9 = np.asarray(population[9])
y10 = np.asarray(population[10])
y11 = np.asarray(population[11])
y12 = np.asarray(population[12])
y13 = np.asarray(population[13])
y14 = np.asarray(population[14])
y15 = np.asarray(population[15])
y16 = np.asarray(population[16])
y17 = np.asarray(population[17])
# Plotting the 8 Billion growth chart
fig1 = plot.figure()
plot.plot(x, y0, label = '0.07%')
plot.plot(x, y3, label = '0.08%')
plot.plot(x, y6, label = '0.09%')
plot.plot(x, y9, label = '0.10%')
plot.plot(x, y12, label = '0.11%')
plot.plot(x, y15, label = '0.12%')
plot.title("Population Growth Model (Limiting Population of 8,000,000,000)\n")
plot.xlabel("Time (Year x10)")
plot.ylabel("Population (x1,000,000,000)")
plot.legend()
# Plotting the 10.9 Billion growth chart
fig2 = plot.figure()
plot.plot(x, y1, label = '0.07%')
plot.plot(x, y4, label = '0.08%')
plot.plot(x, y7, label = '0.09%')
plot.plot(x, y10, label = '0.10%')
plot.plot(x, y13, label = '0.11%')
plot.plot(x, y16, label = '0.12%')
plot.title("Population Growth Model (Limiting Population of 10,900,000,000)\n")
plot.xlabel("Time (Year x10)")
plot.ylabel("Population (x10,000,000,000)")
plot.legend()
# Plotting the 12 Billion growth chart
fig3 = plot.figure()
plot.plot(x, y2, label = '0.07%')
plot.plot(x, y5, label = '0.08%')
plot.plot(x, y8, label = '0.09%')
plot.plot(x, y11, label = '0.10%')
plot.plot(x, y14, label = '0.11%')
plot.plot(x, y17, label = '0.12%')
plot.title("Population Growth Model (Limiting Population of 12,000,000,000)\n")
plot.xlabel("Time (Year x10)")
plot.ylabel("Population (x10,000,000,000)")
plot.legend()
# Saving the charts as jpegs with verbose confirmation
fig1.savefig("8-Billion.jpeg")
fig2.savefig("10_9-Billion.jpeg")
fig3.savefig("12-Billion.jpeg")
print("Charts have been saved to the present working directory: 8-Billion.jpeg, 10_9-Billion.jpeg, and 12-Billion.jpeg\n")
# Locating the correct combination of population limit and growth rate that best aligns with the 2020 world population
y_list_2020 = [y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17]
list = []
for i in range(0, 18):
    yi = y_list_2020[i]
    y = yi[1202]
    list.append(y)
estimate = []
crossref = []
for i in range(0, 18):
    test = list[i]
    if (7800000000*0.999 <= test <= 7800000000*1.111):
        estimate.append(test)
        crossref.append(i)
    else:
        continue
print("The following models have reported populations that are equivalent to the current population of about 7,800,000,000 (±0.1% error)...\n")    
for i in range(0, len(crossref)):
    if (crossref[i] == 0):
            pop = "8 Billion"
            rate = "0.07%"
    elif (crossref[i] == 3):
            pop = "8 Billion"
            rate = "0.08%"
    elif (crossref[i] == 6):
            pop = "8 Billion"
            rate = "0.09%"
    elif (crossref[i] == 9):
            pop = "8 Billion"
            rate = "0.10%"
    elif (crossref[i] == 12):
            pop = "8 Billion"
            rate = "0.11%"
    elif (crossref[i] == 15):
            pop = "8 Billion"
            rate = "0.12%"
    elif (crossref[i] == 1):
            pop = "10.9 Billion"
            rate = "0.07%"
    elif (crossref[i] == 4):
            pop = "10.9 Billion"
            rate = "0.08%"
    elif (crossref[i] == 7):
            pop = "10.9 Billion"
            rate = "0.09%"
    elif (crossref[i] == 10):
            pop = "10.9 Billion"
            rate = "0.10%"
    elif (crossref[i] == 13):
            pop = "10.9 Billion"
            rate = "0.11%"
    elif (crossref[i] == 16):
            pop = "10.9 Billion"
            rate = "0.12%"
    elif (crossref[i] == 2):
            pop = "12 Billion"
            rate = "0.07%"
    elif (crossref[i] == 5):
            pop = "12 Billion"
            rate = "0.08%"
    elif (crossref[i] == 8):
            pop = "12 Billion"
            rate = "0.09%"
    elif (crossref[i] == 11):
            pop = "12 Billion"
            rate = "0.10%"
    elif (crossref[i] == 14):
            pop = "12 Billion"
            rate = "0.11%"
    elif (crossref[i] == 17):
            pop = "12 Billion"
            rate = "0.12%"
    print("This Population Growth Model, with a(n)", pop,"person limit and a growth rate of",rate,", produced an approximate estimation of %.1f" %estimate[i])
print()
stopwatch_end = (time_ns()) - stopwatch_start
print("Process completed in", stopwatch_end,"nanoseconds!\n")
print("END OF LINE.")
"END OF FILE"