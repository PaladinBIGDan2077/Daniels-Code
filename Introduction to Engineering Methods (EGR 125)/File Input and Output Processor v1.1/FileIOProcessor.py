"""
Developed specifically for Programming Assignment #5
Under Supervision of Professor David Lin
Northern Virginia Community College - Annandale Campus
Introduction to Engineering Methods (EGR125)
Completed 3/5/2021 at 6:04PM EST

Description:
The File Input/Output Processor incorporates the use of reading and writing to text files outside of python. This allows for the reading and writing of data gathered from surveys, measurements, etc.
This program in particular reads data from two text files: 'trucks.txt' and 'unformatted.txt.' 'trucks.txt' is a formatted dataset with headings, ordered columns and rows, and titles containing data gathered from the
daily production of trucks manufactured during the month of February. The dataset is processed to be stripped of the 'Day' column, headings, and strings, keeping the order and real numbers. This is placed into a new list
that python can use to calculate the total produced and mean from each manufacturer. The results are outputted to a text file, 'output.txt.'

For the 'unformatted.txt' file, the data is unformatted (obviously), containing only a title and a set of numbers separated by tabs and a few new lines. This dataset is processed by the program, which removes the title and organizes all
real numbers into a comma-separated list. Python then takes care of calculating the mean and standard deviation of the list. The results are appended to the text file, 'output.txt,' along with a newly formatted version
of the dataset, which is equally separated into five columns.

The File Input/Output Processor - v1.1 for Python 3.9.1 -- Written by Daniel J. Lomis
This program is protected under the GNU General Public License GPL v3.0.
"""
import statistics
import math
print('Welcome to The File Input/Output Processor - v1.1 for Python 3.9.1')
print('Written by Daniel J. Lomis')
print()
print('Processing datasets from unformatted.txt and trucks.txt.....')
print()
# Data processing for 'unformatted.txt'
# Importing the numerical values from the 'unformatted.txt' file.
dataset = []
WWW = open('D:\\Users\Danie\\OneDrive\\Documents\\College\\NVCC\\4. Spring 2021\\EGR 125\\Assignments\\Data Analysis of Various Vehicles and Random Numbers with Input and Output of Text Files\\unformatted.txt', 'r')
WWW.readline()
numerical_data = WWW.readlines()
for line in numerical_data:
    for iterator_variable in line.split():
        dataset.append(float(iterator_variable))
WWW.close()
# Calculating statistical data
stdev = statistics.stdev(dataset)
mean = statistics.mean(dataset)
# Reformatting and outputting dataset and calculated statistical data to 'output.txt'
MMM = open('D:\\Users\Danie\\OneDrive\\Documents\\College\\NVCC\\4. Spring 2021\\EGR 125\\Assignments\\Data Analysis of Various Vehicles and Random Numbers with Input and Output of Text Files\\output.txt', 'w')
number_vals = len(dataset)
number_cols = 5
number_rows = math.ceil(number_vals/number_cols)
index = 0
MMM.write('\t\tCalculated data from unformatted.txt\n')
for row in range(number_rows):
    for col in range(number_cols):
        MMM.write ('%11.4f' %(dataset[index]))
        index += 1
        if index >= number_vals:   
            break
    MMM.write('\n')
MMM.write('\n')
MMM.write('The standard deviation of this dataset is {}.\n'.format(stdev))
MMM.write('The average of this dataset is {}.\n'.format(mean))
MMM. write('\n\n')  
MMM.close()
# Data processing for 'trucks.txt'
# Importing the numerical values from the 'trucks.txt' file.
F150 = []
Silverado = []
RAM = []
Truck_Month = open('D:\\Users\Danie\\OneDrive\\Documents\\College\\NVCC\\4. Spring 2021\\EGR 125\\Assignments\\Data Analysis of Various Vehicles and Random Numbers with Input and Output of Text Files\\trucks.txt', 'r')
Truck_Month.readline()
Truck_Month.readline()
for line in Truck_Month:
    dataset2 = line.split()
    if dataset2 != []:
        F150.append(float(dataset2[1]))
        Silverado.append(float(dataset2[2]))
        RAM.append(float(dataset2[3]))
    else:
        break
Truck_Month.close()
# Adding up each of the datasets together
Total_F150 = 0
for i in range(len(F150)):
    Total_F150 = F150[i] + Total_F150
Total_Silverado = 0
for i in range(len(Silverado)):
    Total_Silverado = Silverado[i] + Total_Silverado    
Total_RAM = 0
for i in range(len(RAM)):
    Total_RAM = RAM[i] + Total_RAM
# Calculating the average value for each data list
Avg_F150 = statistics.mean(F150)
Avg_Silverado = statistics.mean(Silverado)
Avg_RAM = statistics.mean(RAM)
# Outputting the total and average values from each list on to 'output.txt'
Truck_Month_Output = open('D:\\Users\Danie\\OneDrive\\Documents\\College\\NVCC\\4. Spring 2021\\EGR 125\\Assignments\\Data Analysis of Various Vehicles and Random Numbers with Input and Output of Text Files\\output.txt', 'a')
Truck_Month_Output.write('\t\tCalculated data from trucks.txt\n')
Truck_Month_Output.write('During the month of February...\n')
Truck_Month_Output.write('Ford produced a total of {} F-150 pickup trucks.\n'.format(Total_F150))
Truck_Month_Output.write('Chevrolet produced a total of {} Silverado pickup trucks.\n'.format(Total_Silverado))
Truck_Month_Output.write('Chrysler produced a total of {} RAM pickup trucks.\n\n'.format(Total_RAM))
Truck_Month_Output.write('Ford produced an average of {} F-150 pickup trucks each day.\n'.format(Avg_F150))
Truck_Month_Output.write('Chevrolet produced an average of {} Silverado pickup trucks each day.\n'.format(Avg_Silverado))
Truck_Month_Output.write('Chrysler produced an average of {} RAM pickup trucks each day.\n\n'.format(Avg_RAM))
Truck_Month_Output.write('END OF FILE')
Truck_Month_Output.close()
# Verbose confirmation that the program completed successfully
print('Script completed successfully without errors!')
print('Please see the output.txt file for results.')
print()
print("END OF LINE.")

"END OF FILE"