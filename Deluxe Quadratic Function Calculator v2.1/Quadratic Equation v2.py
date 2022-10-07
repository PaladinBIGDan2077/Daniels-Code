""" 
The Quadraditc Equation Formula for Python 3.9.1 -- Written by Daniel J. Lomis
This program protected under the General Public License GPL v3.0.
"""
import CompUSA

print("Welcome to the Deluxe Quadratic Function Calculator - v2.1!")
print("Now supporting complex numbers!")
print("Written by Daniel J. Lomis for Python 3.9.1")
print("NOTE: this program is case-sensitive!")
print()
while(1):
    a = float(input("What is the coefficient of the x² term? "))
    if (a == 0):
        print()
        print("The coefficient 'a' cannot equal 0! Please try again.")
        print()
        continue
    b = float(input("What is the coefficient of the x term? "))
    c = float(input("What is the value of the constant term? "))
    question1 = input("Would you like to calculate an x variable for the function, f(x)? (y or n) ")
    print()
    question2 = input("You have entered: f(x) = %0.2fx² + %0.2fx + %0.2f. Does everything look good? (y or n) " %(a,b,c))
    if (question2 == 'y'):
        CompUSA.CompuServe(a, b, c)
        CompUSA.AOL(a, b, c)
        CompUSA.EarthLink(question1, a, b, c)
    elif (question2 == 'n'):
        print()
        continue
"END OF FILE"