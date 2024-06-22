import os
from time import sleep


def cheese():
    sleep(0.25)

for i in range(8):
    print("___#___")
    cheese()
    print("__#_#__")
    cheese()
    print("_#___#_")
    cheese()
    print("#_____#")
    cheese()
    print("#######")
    cheese()
    print("#_____#")
    cheese()
    print("#_____#")
    cheese()
    print("_______")
    os.system("cls")