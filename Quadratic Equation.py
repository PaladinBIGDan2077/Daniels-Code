""" 
The Quadraditc Equation Formula for Python 3.9.1 -- Written by Daniel J. Lomis
This program protected under the General Public License GPL v3.0.

"""
print("Welcome to the Deluxe Quadratic Function Calculator! Developed by Daniel J. Lomis v1.1")
print("NOTE: this program is case-sensitive!")
while (1):
    print()
    a = float(input("What is the coefficient of the xx term? "))
    if (a == 0):
        print("Bruh, the coefficient 'a' cannot equal 0! Sorry fam, please try again.")
        print()
        continue
    b = float(input("What is the coefficient of the x term? "))
    c = float(input("What is the value of the constant term? "))
    print()
    question = input("You have entered: %0.1fxx + %0.1fx + %0.1f. Does everything look good my dude? (y or n)" %(a,b,c))
    # Calculation of the radicand
    radicand = (b**2-4*a*c)
    if (question == 'y'):
        if (radicand < 0):
            print("Sorry bro, support for imaginary numbers will come in the next update! Please try again fam.")
        else:
            # The actual calculating bits
            radical = (radicand**0.5)
            postive_numerator = (-b + radical)
            negative_numerator = (-b - radical)
            denominator = (2*a)
            x1 = (postive_numerator/denominator)
            x2 = (negative_numerator/denominator)
            print()
            print("The first x-intercept is %0.20f" %x1)
            print("The second x-intercept is %0.20f" %x2)
            print()
            # Easter eggs
            if (x1 < 1): print("Please do not touch my red stapler.")
            if (x2 < -1): print("The cake is a lie!")
            if (c == 42): print("Well your one step closer to finding the answer to the ultimate question!")
            question2 = input("Would you like to try another quadratic? (y or n)")
            if (question2 == 'y'):
                continue
            else:
                print("END OF LINE.")
                break
    elif (question == 'n'):
        continue
"END OF FILE"
