""" 
Welcome to the Quadratic Equation Computer Library: CompUSA
This library is designed to be used with the 'Deluxe Quadratic Equation Calculator - v2.1,'
which I can proudly say supports imagenary numbers! All contents within this library 
are protected under the General Public License v3.0 (GPL v3). Written in Python 3.9.1 by Daniel Lomis
"""
def CompuServe(a, b, c):
    """ This function checks whether the inputed coefficients are real (1999) or complex (1974) """
    radicand = (b**2-4*a*c)
    if (radicand < 0):
        return 0
    else:
        return 1

def AOL(a, b, c):
    radicand = (b**2-4*a*c)
    if (CompuServe(a, b, c) == 0):
        """ Computing the quadratic as imagenary """
        imagenary = abs(radicand)
        radical = (imagenary ** 0.5)
        numerator_b = ((-1 * b) / (2 * a))
        x1 = (radical / (2 * a))
        x2 = (-1 * x1)
        print()
        print("The first x-intercept is %0.9f + %0.9fi" %(numerator_b,x1))
        print("The second x-intercept is %0.9f + %0.9fi" %(numerator_b,x2))
        return
    elif (CompuServe(a, b, c) == 1):
        """ Computing the quadratic as real """
        numerator_b = 0
        radical = (radicand ** 0.5)
        postive_numerator = ((-1 * b) + radical)
        negative_numerator = ((-1 * b) - radical)
        denominator = ( 2 * a)
        x1 = (postive_numerator / denominator)
        x2 = (negative_numerator / denominator)
        print()
        print("The first x-intercept is %0.9f" %x1)
        print("The second x-intercept is %0.9f" %x2)
        return

def Juno(x, a, b, c):
    """ If an x-variable was inputed, this is where it is calculated """
    y = (a * x **2 + b * x + c)
    print()
    print("NOTE: coefficients and variables have been rounded up for cleaniness.")
    print("The function f(%0.2f) = %0.2f X %0.2f² + %0.2f X %0.2f + %0.2f is" %(x,a,x,b,x,c))
    print("%0.9f" %y)
    return

def EarthLink(question1, a, b, c):
    """ If the user requested for the calculation of f(x), what is that x-variable. Also asks if user would like to try another quadratic equation. """
    if (question1 == 'y'):
        print()
        x = float(input("Please enter a value for x: "))
        Juno(x, a, b, c)
        print()  
    elif (question1 == 'n'):
        print()
    question3 = input("Would you like to try another quadratic? (y or n) ")
    print()
    MSN(question3)
    return question3

def MSN(question3):
    """ Exit program subroutine """
    if (question3 == 'y'):
        return
    elif (question3 == 'n'):
        print("Thank you for using the Deluxe Quadratic Function Calculator! Goodbye.")
        print("END OF LINE.")
        exit()
"END OF FILE"