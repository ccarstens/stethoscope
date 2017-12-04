from Agent import Agent
from Impulsator import Impulsator

BACKGROUND = color(0)

x = Agent()
i = Impulsator(25)

def setup():
    frameRate(25)
    size(500, 500)
    background(BACKGROUND)
    print(i.step)

    if 1 < 1.0:
        print("what")


def mouseMoved():
    pass


def mouseClicked():
    pass
    # x.size *= 2

def draw():
    
    x.move_right(2)
    x.draw()
    print(i.read())
