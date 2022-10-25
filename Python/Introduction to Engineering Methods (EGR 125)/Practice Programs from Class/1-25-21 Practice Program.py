"""
This program calculates the distance between two points.
The points have coordinates (x1, y1) and (x2, y2), and the
distance formula is used to calculate the distance. DL - THIS HAS BEEN 
MODIFIED FROM ITS ORIGINAL VERSION TO INCLUDE AN INPUT COMMAND AS WELL AS A SIG FIG 
LIMIT!
"""

import math
import time
# Define and initialize coordinates

x1 = float(input('What is your first x coordinate: '))
y1 = float(input('What is your first y coordinate: '))
x2 = float(input('What is your second x coordinate: '))
y2 = float(input('What is your second x coordinate: '))
"""
x1, x2, y1, y2 = float(input('Enter the values of x1, y1, x2, and y2: ').split()
"""
# Calculate sides
side1 = y2 - y1
side2 = x2 - x1
dat = time.strftime('%A %B %d %I:%M:%S %Y')
epc = time.strftime('%s')
# Calculate the distance or hypotenuse.
distance = math.sqrt(side1**2 + side2**2)

# Output or display the result.
print('The distance between the two points is %.2f'% distance)
print('The current time is', dat)
print('Current EPOCH Time is', epc)