import machine
from random import randrange as random
from utime import sleep as sleep
led0 = machine.Pin(1, machine.Pin.OUT)
led1 = machine.Pin(2, machine.Pin.OUT)
led2 = machine.Pin(7, machine.Pin.OUT)
led3 = machine.Pin(8, machine.Pin.OUT)
led4 = machine.Pin(9, machine.Pin.OUT)
led5 = machine.Pin(10, machine.Pin.OUT)
led6 = machine.Pin(11, machine.Pin.OUT)
led7 = machine.Pin(13, machine.Pin.OUT)
lACT = machine.Pin(12, machine.Pin.OUT)
switch = machine.Pin(15, machine.Pin.IN)
spkr = machine.Pin(0, machine.Pin.OUT)
a = 0
b = 0
c = 0
d = 0
e = 0
f = 0
g = 0
h = 0
header = 0.05
y = 0.010
ACT = 0


x = 0

def alt(a,b,c,d,e,f,g,h,y,header):
    a = 0
    b = 1
    c = 0
    d = 1
    e = 0
    f = 1
    g = 0
    h = 1
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    a = 1
    b = 0
    c = 1
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)

def random_binary(a,b,c,d,e,f,g,h,y,header):
    a = int(random(0,2))
    b = int(random(0,2))
    c = int(random(0,2))
    d = int(random(0,2))
    e = int(random(0,2))
    f = int(random(0,2))
    g = int(random(0,2))
    h = int(random(0,2))
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)

def led(a,b,c,d,e,f,g,h):
    print(a, b, c, d, e, f, g, h)
    led0.value(a)
    led1.value(b)
    led2.value(c)
    led3.value(d)
    led4.value(e)
    led5.value(f)
    led6.value(g)
    led7.value(h)


def soundtx(a,b,c,d,e,f,g,h,y,header):
    spkr.value(1)
    lACT.value(1)
    sleep(header)
    spkr.value(0)
    lACT.value(0)
    sleep(header)
    spkr.value(a)
    lACT.value(a)
    sleep(y)
    spkr.value(0)
    lACT.value(0)
    sleep(y)
    spkr.value(b)
    lACT.value(b)
    sleep(y)
    spkr.value(0)
    lACT.value(0)
    sleep(y)
    spkr.value(c)
    lACT.value(c)
    sleep(y)
    spkr.value(0)
    lACT.value(0)
    sleep(y)
    spkr.value(d)
    lACT.value(d)
    sleep(y)
    spkr.value(0)
    lACT.value(0)
    sleep(y)
    spkr.value(e)
    lACT.value(e)
    sleep(y)
    spkr.value(0)
    lACT.value(0)
    sleep(y)
    spkr.value(f)
    lACT.value(f)
    sleep(y)
    spkr.value(0)
    lACT.value(0)
    sleep(y)
    spkr.value(g)
    lACT.value(g)
    sleep(y)
    spkr.value(0)
    lACT.value(0)
    sleep(y)
    spkr.value(h)
    lACT.value(h)
    sleep(y)
    spkr.value(0)
    lACT.value(0)
    sleep(y)


for i in range(100):
    random_binary(a,b,c,d,e,f,g,h,y,header)
#for i in range(1000):
#    alt(a,b,c,d,e,f,g,h,y,header)
while (x == 0):
    # 000 - 0
    a = 0
    b = 0
    c = 0
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 100 - 1
    a = 1
    b = 0
    c = 0
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 010 - 2
    a = 0
    b = 1
    c = 0
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 110 - 3
    a = 1
    b = 1
    c = 0
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 001 - 4
    a = 0
    b = 0
    c = 1
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 101 - 5
    a = 1
    b = 0
    c = 1
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 011 - 6
    a = 0
    b = 1
    c = 1
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 111 - 7
    a = 1
    b = 1
    c = 1
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 000100 - 8
    a = 0
    b = 0
    c = 0
    d = 1
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 100100 - 9
    a = 1
    b = 0
    c = 0
    d = 1
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 010100 - 10
    a = 0
    b = 1
    c = 0
    d = 1
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 110100 - 11
    a = 1
    b = 1
    c = 0
    d = 1
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 001100 - 12
    a = 0
    b = 0
    c = 1
    d = 1
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1011 - 13
    a = 1
    b = 0
    c = 1
    d = 1
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0111 - 14
    a = 0
    b = 1
    c = 1
    d = 1
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 11110 - 15
    a = 1
    b = 1
    c = 1
    d = 1
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 00001 - 16
    a = 0
    b = 0
    c = 0
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 10001 - 17
    a = 1
    b = 0
    c = 0
    d = 0
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 01001 - 18
    a = 0
    b = 1
    c = 0
    d = 0
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 11001 - 19
    a = 1
    b = 1
    c = 0
    d = 0
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 00101 - 20
    a = 0
    b = 0
    c = 1
    d = 0
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 10101 - 21
    a = 1
    b = 0
    c = 1
    d = 0
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 01101 - 22
    a = 0
    b = 1
    c = 1
    d = 0
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 11101 - 23
    a = 1
    b = 1
    c = 1
    d = 0
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 00011 - 24
    a = 0
    b = 0
    c = 0
    d = 1
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 10011 - 25
    a = 1
    b = 0
    c = 0
    d = 1
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 01011 - 26
    a = 0
    b = 1
    c = 0
    d = 1
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 11011 - 27
    a = 1
    b = 1
    c = 0
    d = 1
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 00111 - 28
    a = 0
    b = 0
    c = 1
    d = 1
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 10111 - 29
    a = 1
    b = 0
    c = 1
    d = 1
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 01111 - 30
    a = 0
    b = 1
    c = 1
    d = 1
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 11111 - 31
    a = 1
    b = 1
    c = 1
    d = 1
    e = 1
    f = 0
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 000001 - 32
    a = 0
    b = 0
    c = 0
    d = 0
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 100001 - 33
    a = 1
    b = 0
    c = 0
    d = 0
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 010001 - 34
    a = 0
    b = 1
    c = 0
    d = 0
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 110001 - 35
    a = 1
    b = 1
    c = 0
    d = 0
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 001001 - 36
    a = 0
    b = 0
    c = 1
    d = 0
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 101001 - 37
    a = 1
    b = 0
    c = 1
    d = 0
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 011001 - 38
    a = 0
    b = 1
    c = 1
    d = 0
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 111001 - 39
    a = 1
    b = 1
    c = 1
    d = 0
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 000101 - 40
    a = 0
    b = 0
    c = 0
    d = 1
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 100101 - 41
    a = 1
    b = 0
    c = 0
    d = 1
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 010101 - 42
    a = 0
    b = 1
    c = 0
    d = 1
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 110101 - 43
    a = 1
    b = 1
    c = 0
    d = 1
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 001101 - 44
    a = 0
    b = 0
    c = 1
    d = 1
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 101101 - 45
    a = 1
    b = 0
    c = 1
    d = 1
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 011101 - 46
    a = 0
    b = 1
    c = 1
    d = 1
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 111101 - 47
    a = 1
    b = 1
    c = 1
    d = 1
    e = 0
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 000011 - 48
    a = 0
    b = 0
    c = 0
    d = 0
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 100011 - 49
    a = 1
    b = 0
    c = 0
    d = 0
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 010011 - 50
    a = 0
    b = 1
    c = 0
    d = 0
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 110011 - 51
    a = 1
    b = 1
    c = 0
    d = 0
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 001011 - 52
    a = 0
    b = 0
    c = 1
    d = 0
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 101011 - 53
    a = 1
    b = 0
    c = 1
    d = 0
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 011011 - 54
    a = 0
    b = 1
    c = 1
    d = 0
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 111011 - 55
    a = 1
    b = 1
    c = 1
    d = 0
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 000111 - 56
    a = 0
    b = 0
    c = 0
    d = 1
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 100111 - 57
    a = 1
    b = 0
    c = 0
    d = 1
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 010111 - 58
    a = 0
    b = 1
    c = 0
    d = 1
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 110111 - 59
    a = 1
    b = 1
    c = 0
    d = 1
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 001111 - 60
    a = 0
    b = 0
    c = 1
    d = 1
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 101111 - 61
    a = 1
    b = 0
    c = 1
    d = 1
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 011111 - 62
    a = 0
    b = 1
    c = 1
    d = 1
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 111111 - 63
    a = 1
    b = 1
    c = 1
    d = 1
    e = 1
    f = 1
    g = 0
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0000001 - 64
    a = 0
    b = 0
    c = 0
    d = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1000001 - 65
    a = 1
    b = 0
    c = 0
    d = 0
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0100001 - 66
    a = 0
    b = 1
    c = 0
    d = 0
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1100001 - 67
    a = 1
    b = 1
    c = 0
    d = 0
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0010001 - 68
    a = 0
    b = 0
    c = 1
    d = 0
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1010001 - 69
    a = 1
    b = 0
    c = 1
    d = 0
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0110001 - 70
    a = 0
    b = 1
    c = 1
    d = 0
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1110001 - 71
    a = 1
    b = 1
    c = 1
    d = 0
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0001001 - 72
    a = 0
    b = 0
    c = 0
    d = 1
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1001001 - 73
    a = 1
    b = 0
    c = 0
    d = 1
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0101001 - 74
    a = 0
    b = 1
    c = 0
    d = 1
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1101001 - 75
    a = 1
    b = 1
    c = 0
    d = 1
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0011001 - 76
    a = 0
    b = 0
    c = 1
    d = 1
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1011001 - 77
    a = 1
    b = 0
    c = 1
    d = 1
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0111001 - 78
    a = 0
    b = 1
    c = 1
    d = 1
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1111001 - 79
    a = 1
    b = 1
    c = 1
    d = 1
    e = 0
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0000101 - 80
    a = 0
    b = 0
    c = 0
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1000101 - 81
    a = 1
    b = 0
    c = 0
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0100101 - 82
    a = 0
    b = 1
    c = 0
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1100101 - 83
    a = 1
    b = 1
    c = 0
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0010101 - 84
    a = 0
    b = 0
    c = 1
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1010101 - 85
    a = 1
    b = 0
    c = 1
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0110101 - 86
    a = 0
    b = 1
    c = 1
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1110101 - 87
    a = 1
    b = 1
    c = 1
    d = 0
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0001101 - 88
    a = 0
    b = 0
    c = 0
    d = 1
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1001101 - 89
    a = 1
    b = 0
    c = 0
    d = 1
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0101101 - 90
    a = 0
    b = 1
    c = 0
    d = 1
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1101101 - 91
    a = 1
    b = 1
    c = 0
    d = 1
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0011101 - 92
    a = 0
    b = 0
    c = 1
    d = 1
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1011101 - 93
    a = 1
    b = 0
    c = 1
    d = 1
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0111101 - 94
    a = 0
    b = 1
    c = 1
    d = 1
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1111101 - 95
    a = 1
    b = 1
    c = 1
    d = 1
    e = 1
    f = 0
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0000011 - 96
    a = 0
    b = 0
    c = 0
    d = 0
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1000011 - 97
    a = 1
    b = 0
    c = 0
    d = 0
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0100011 - 98
    a = 0
    b = 1
    c = 0
    d = 0
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1100011 - 99
    a = 1
    b = 1
    c = 0
    d = 0
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0010011 - 100
    a = 0
    b = 0
    c = 1
    d = 0
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1010011 - 101
    a = 1
    b = 0
    c = 1
    d = 0
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0110011 - 102
    a = 0
    b = 1
    c = 1
    d = 0
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1110011 - 103
    a = 1
    b = 1
    c = 1
    d = 0
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0001011 - 104
    a = 0
    b = 0
    c = 0
    d = 1
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1001011 - 105
    a = 1
    b = 0
    c = 0
    d = 1
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0101011 - 106
    a = 0
    b = 1
    c = 0
    d = 1
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1101011 - 107
    a = 1
    b = 1
    c = 0
    d = 1
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0011011 - 108
    a = 0
    b = 0
    c = 1
    d = 1
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1011011 - 109
    a = 1
    b = 0
    c = 1
    d = 1
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0111011 - 110
    a = 0
    b = 1
    c = 1
    d = 1
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1111011 - 111
    a = 1
    b = 1
    c = 1
    d = 1
    e = 0
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0000111 - 112
    a = 0
    b = 0
    c = 0
    d = 0
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1000111 - 113
    a = 1
    b = 0
    c = 0
    d = 0
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0100111 - 114
    a = 0
    b = 1
    c = 0
    d = 0
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1100111 - 115
    a = 1
    b = 1
    c = 0
    d = 0
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0010111 - 116
    a = 0
    b = 0
    c = 1
    d = 0
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1010111 - 117
    a = 1
    b = 0
    c = 1
    d = 0
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0110111 - 118
    a = 0
    b = 1
    c = 1
    d = 0
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1110111 - 119
    a = 1
    b = 1
    c = 1
    d = 0
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0001111 - 120
    a = 0
    b = 0
    c = 0
    d = 1
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1001111 - 121
    a = 1
    b = 0
    c = 0
    d = 1
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0101111 - 122
    a = 0
    b = 1
    c = 0
    d = 1
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1101111 - 123
    a = 1
    b = 1
    c = 0
    d = 1
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0011111 - 124
    a = 0
    b = 0
    c = 1
    d = 1
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1011111 - 125
    a = 1
    b = 0
    c = 1
    d = 1
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 0111111 - 126
    a = 0
    b = 1
    c = 1
    d = 1
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    # 1111111 - 127
    a = 1
    b = 1
    c = 1
    d = 1
    e = 1
    f = 1
    g = 1
    h = 0
    led(a,b,c,d,e,f,g,h)
    soundtx(a,b,c,d,e,f,g,h,y,header)
    
    for i in range(10000):
        random_binary(a,b,c,d,e,f,g,h,y,header)