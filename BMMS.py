#       ****************************************************************************
#       *  PWM Motor Controller Program for Cytron MDD10A 10Amp Motor Driver pHat  *
#       *--------------------------------------------------------------------------*
#       *     Written in Python v3.7.3 under Thonny IDE by Daniel Justin Lomis     *
#       *                Tysons Corner, Virginia - October 27, 2020                *
#       *--------------------------------------------------------------------------*
#       *   Under collaboration with Michael DiStefano, Issac Woldeyohannis, and   *
#       *                           Shalomi Arulpragasam                           *
#       *--------------------------------------------------------------------------*
#       *       Developed specifically for the Box-Mover Engineering Project       *
#       *               Under Supervision of Dr. Mohamed H. Belghith               *
#       *           Northern Virginia Community College - Loudoun Campus           *
#       *      Foundations of Engineering: Engineering Fundatmentals (EGR121)      *
#       *--------------------------------------------------------------------------*
#       *    This program is protected under the GNU General Public License v3.0   *
#       ****************************************************************************


# Importing libraries
import RPi.GPIO as GPIO
from time import sleep
import os
# GPIO environmental variables
MOT = 12
DIR = 26
# GPIO environment settings
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(DIR,GPIO.OUT)
GPIO.setup(MOT,GPIO.OUT)
p = GPIO.PWM(MOT,100)
# GPIO default congifuration
GPIO.output(DIR,GPIO.LOW)
GPIO.output(DIR,GPIO.HIGH)
# Motor anti-seize startup subroutine
p.start(100)
sleep(0.4)
p.ChangeDutyCycle(18)
# Printing credits, commencing command selection subroutine
os.system('clear')
print("           Welcome to the Box-Mover Management System (BMMS)           ")
print("                        Written by Daniel Lomis                        ")
print("                              Version 1.1                              ")
print()
sleep(5)
print("       Programmed in Python v3.7.3 exclusively for Raspberry  Pi       ")
print("              Built on Pulse-width Modulation  technology              ")
print("                      Created on October 27, 2020                      ")
sleep(10)
os.system('clear')
print("\n")
print("The default speed is 6 RPM")
print("The default direction is FORWARD (clockwise)")
print("\n")
print("PLEASE READ THIS WAIVER AGREEMENT BEFORE PROCEEDING...")
print()
print("By pressing the 'ENTER' key, you agree to the fact that this program and its programmers")
print("are not liable for any injury or death caused by the input of the user,")
print("operation of system, or systematic malfunction of the box-mover.")
print()
os.system('sudo aplay -q /home/pi/PS3Bp.wav') # Used as a substitution of the terminal bell
input("PRESS THE 'ENTER' KEY TO CONTINUE.")
os.system('clear')
while(1):
    # Continued title from beginning, but now accounting for persistance
    print("____________________________________________________________________")
    print("             Box-Mover Management System (BMMS) -  v1.1             ")
    print("             Built on Pulse-width Modulation technology             ")
    print("\n")
    print("Please make a selection on the control pad, followed by the 'ENTER' key.")
    print()
    os.system('sudo aplay -q /home/pi/PS3TBp.wav')
    x=input("READY: ") # Looks for user input from control pad
    print("\n")
    os.system('clear')

    if x=='*': # if '*' is selected, then the motor will begin rotating clockwise at 25/100 PWM cycles
        print("Selected: Run") # print's indicated text to screen
        sleep(0.25) # pause for 1/2 second
        p.start(50) # Using PWM, indicates 25/100 cycles on the MOTor pin
       	print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled Run") # print indicated text along with a terminal bell
        sleep(1)

    elif x=='-': # if '*' was not pressed, then it continues down the list until the correct character is located, otherwise it returns with an unknown command and starts again at ln 48 by requesting input from control pad
        print("Selected: Forward")
        sleep(0.25)
        GPIO.output(DIR,GPIO.HIGH) # Using PWM, indicates CW-roation on the DIRection pin
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled Forward")
        sleep(1)

    elif x=='+':
        print("Selected: Reverse")
        sleep(0.25)
        GPIO.output(DIR,GPIO.LOW) # Using PWM, indicates CCW-roation on the DIRection pin
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled Reverse")
        sleep(1)

    elif x=='/':
        print("Selected: Full Stop")
        sleep(0.25)
        p.ChangeDutyCycle(0) # Using PWM, indicates 0/100 cycles on the MOTor pin
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled Full Stop")
        sleep(1)

    elif x=='1':
        print("Selected: 10% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(16) # Using PWM, indicates 16/100 cycles on the MOTor pin
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 10% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 3 RPM")
        sleep(1)

    elif x=='2':
        print("Selected: 20% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(22)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 20% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 6 RPM")
        sleep(1)

    elif x=='3':
        print("Selected: 30% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(30)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 30% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 9 RPM")
        sleep(1)

    elif x=='4':
        print("Selected: 40% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(40)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 40% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 12 RPM")
        sleep(1)

    elif x=='5':
        print("Selected: 50% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(50)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 50% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 15 RPM")
        sleep(1)

    elif x=='6':
        print("Selected: 60% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(60)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 60% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 18 RPM")
        sleep(1)

    elif x=='7':
        print("Selected: 70% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(70)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 70% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 21 RPM")
        sleep(1)

    elif x=='8':
        print("Selected: 80% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(80)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 80% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 24 RPM")
        sleep(1)

    elif x=='9':
        print("Selected: 90% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(90)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 90% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 27 RPM")
        sleep(1)

    elif x=='.':
        print("Selected: 100% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(100)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 100% Speed")
        sleep(0.2)
        print()
        print("Speed ≈ 30 RPM")
        sleep(1)

    elif x=='0':
        print("Selected: 00% Speed")
        sleep(0.25)
        p.ChangeDutyCycle(0)
        print()
        os.system('sudo aplay -q /home/pi/PS3Bp.wav')
        print("Signaled 00% Speed")
        sleep(0.2)
        print()
        print("Speed = 0 RPM")
        sleep(1)

    elif x=='=':
        os.system('clear') # Coming out of the Python Shell, tells command line to clear screen
        print("Signalling Full Stop...")
        sleep(3)
        p.ChangeDutyCycle(0)
        print()
        os.system('sudo aplay -q /home/pi/PS3TBp.wav')
        print("Signalled Full Stop")
        sleep(2)
        os.system('clear')
        print("Performing GPIO Clean up...")
        sleep(3)
        GPIO.cleanup() # Used to clear out raw data on the RPi's GPIO bus
        print()
        os.system('sudo aplay -q /home/pi/PS3TBp.wav')
        print("GPIO Bus Cleared")
        sleep(2)
        os.system('clear')
        while(2):
            # Exit prompt to power off system
            y=input("Would you like to 'SHUTDOWN' the Raspberry Pi?")
            if y=='*':
                os.system('clear')
                sleep(2)
                print("It's now safe to turn off your computer.")
                os.system('sudo aplay -q /home/pi/PS3TBp.wav')
                sleep(3)
                os.system('sudo shutdown now -P')
                break

            elif y=='/':
                os.system('clear')
                print("Thank you for using the Box-Mover Management System. Returning to Command Line Interface....")
                print()
                sleep(3)
                print("Please connect a QWERTY, US keyboard.")
                os.system('sudo aplay -q /home/pi/PS3Bp.wav')
                sleep(2)
                break

            else:
                print("Input error. Please try again.")
                print()

    else:
        p.start(0)
        os.system('sudo aplay -q /home/pi/PS3TBp.wav')
        print("Input not recognized. Signalled emergency STOP.")
        sleep(1)
