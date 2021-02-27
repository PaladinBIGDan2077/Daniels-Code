"""
Developed specifically for Programming Assignment #3
Under Supervision of Professor David Lin
Northern Virginia Community College - Annandale Campus
Introduction to Engineering Methods (EGR125)
Completed 2/26/2021 at 10:40PM EST

Description:
The Matrix Percolator is a multifunction Matrix calculator that processes the determinate (square matrices), cross product (3D or 2D matrices), and dot product (3D or 2D matrices) 
of one and/or two given matrices. The Matrix Percolator also includes a system of equations calculator, which by a given set of coefficients and constants, calculates the necessary 
set of solutions needed to solve the system. Rather than incorporating the program along with a separate library of functions, I will be writing the entire program under one file 
while incorporating functions. 

The Matrix Percolator - v1.1 for Python 3.9.1 -- Written by Daniel J. Lomis
This program is protected under the GNU General Public License GPL v3.0.
"""
import numpy

def Determinate():
    x = 3
    print("Your are percolating the determinate of a square matrix.")
    while(x == 3):
        size = int(input("Please enter the size of your square matrix: "))
        matrix = numpy.zeros([size, size], dtype=float)
        print()
        for i in range(size):
            print("Please respectively list the values of row", i + 1)
            square = input(": ").split()
            square[i] = float(square[i])
            matrix[i] = square
            print()
        print(matrix)
        print()
        question = input("Does the matrix look accurate? (y/n) ")
        if question == "n":
            continue
        if question == "y":
            determinate = numpy.linalg.det(matrix)
            print()
            print("The determinate of your", size,"x", size,"square matrix is", determinate)
            x = 4

def SystemOfEquations():
    exit_freedom = 1
    freedom = 1
    print("Your are percolating the solution(s) of a linear system of equations.")
    print("For easier entry, please rework your linear equation(s) into standard form and simplify.")
    print("Leave the constant on the right side.")
    print("For Example: 2x - 3x + 5y + 6z - 7z - 90 = 0 >>> -1x + 5y - 1z = 90")
    print()
    size = int(input("How many equations or variables do you need to percolate? "))
    while(exit_freedom == 1):
        var_matrix = numpy.zeros([size, size], dtype=float)
        print()
        for i in range(size):
            print("Please respectively list the coefficients of equation #", i + 1)
            coefficients = input(": ").split()
            coefficients[i] = float(coefficients[i])
            var_matrix[i] = coefficients
            print()
        print(var_matrix)
        print()
        question = input("Does the coefficients matrix look accurate? (y/n) ")
        if question == "n":
            continue
        if question == "y":
            while(freedom == 1):
                print()
                print("Please respectively list the constants")
                const_matrix = input(": ").split()
                for k in range(size):
                    const_matrix[k] = float(const_matrix[k])
                print()
                print(const_matrix)
                print()
                question2 = input("Does the constants matrix look accurate? (y/n) ")
                if question2 == "y":
                    sysofequations = numpy.linalg.solve(var_matrix, const_matrix)
                    print()
                    print("The solution set of your system of equations is", sysofequations)
                    exit_freedom = 0
                    freedom = 0
                else:
                    continue

def Dot():
    print("Your are percolating the dot product of two two/three dimension matrices.")
    freedom = 1
    array = [[0]*3]*2
    while(freedom == 1):
        for i in range(2):
            print("What is the x-variable of Vector ", i + 1, "?")
            x = input(": ")
            print("What is the y-variable of Vector ", i + 1, "?")
            y = input(": ")
            print("What is the z-variable of Vector ", i + 1, "?")
            z = input(": ")
            x = float(x)
            y = float(y)
            z = float(z)
            array[i] = x, y, z
            print()
        matrix = numpy.asarray(array)
        for i in range(2):
            print("Vector #", i + 1,"=", array[i])
        print()
        question = input("Do the vectors look accurate? (y/n) ")
        if question == "y":
            freedom = 0
        if question == "n":
            continue
    dot = matrix[0] @ matrix[1]
    print()
    print("The result of the dot product is", dot)
    
def Cross():
    print("Your are percolating the cross product of two two/three dimension matrices.")
    freedom = 1
    array = [[0]*3]*2
    while(freedom == 1):
        for i in range(2):
            print("What is the x-variable of Vector ", i + 1, "?")
            x = input(": ")
            print("What is the y-variable of Vector ", i + 1, "?")
            y = input(": ")
            print("What is the z-variable of Vector ", i + 1, "?")
            z = input(": ")
            x = float(x)
            y = float(y)
            z = float(z)
            array[i] = x, y, z
            print()
        matrix = numpy.asarray(array)
        for i in range(2):
            print("Vector #", i + 1,"=", array[i])
        print()
        question = input("Do the vectors look accurate? (y/n) ")
        if question == "y":
            freedom = 0
        if question == "n":
            continue
    cross = numpy.cross(matrix[0], matrix[1])
    print()
    print("The result of", matrix[0],"X", matrix[1],"is", cross)

print("Welcome to The Matrix Percolator - v1.1")
print("Written by Daniel J. Lomis in Python v3.9.1")
print("NOTE: When respectively listing values, place a space between each real number.")
while(1):
    print()
    print()
    print("Please make the following selection...")
    print("a. Percolate the determinate of a square matrix")
    print("b. Percolate the solution set(s) of a linear system of equations")
    print("c. Percolate the dot product of two two/three dimension matrices")
    print("d. Percolate the cross product of two two/three dimension matrices")
    print("e. Quit The Matrix Percolator")
    question_main = input(": ")
    print()
    if (question_main == "a"):
        Determinate()
        Delta = input("Press Enter to continue...")
    elif (question_main == "b"):
        SystemOfEquations()
        Delta = input("Press Enter to continue...")
    elif (question_main == "c"):
        Dot()
        Delta = input("Press Enter to continue...")
    elif (question_main == "d"):
        Cross()
        Delta = input("Press Enter to continue...")
    elif (question_main == "e"):
        print("Thank you for using The Matrix Percolator - v1.1!")
        print("Try some percolated coffee sometime; it ain't half bad! Goodbye!")
        print()
        print("END OF LINE")
        break
    else:
        continue
"END OF FILE"