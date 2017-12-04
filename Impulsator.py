from __future__ import division



class Impulsator:
    value = 0.0
    direction = 1
    floor = 0
    ceiling = 1
    step = 0

    def __init__(self, steps):
        self.step = (self.ceiling - self.floor) / steps

    def calculate(self):
        newValue = self.calculateNewValue()
        # self.log("BEFORE IF")
        if self.floor > newValue or self.ceiling < int(newValue):
            self.log("OUT (" + str(newValue) + ")")
            self.direction *= -1
            newValue = self.calculateNewValue()
        

        self.value = newValue

    def read(self):
        self.calculate()
        return self.value

    def calculateNewValue(self):
        return self.value + self.step * self.direction


    def log(self, location = ""):
        print(location + "\nValue: " + str(self.value) + "\nDirection: " + str(self.direction) + "\nStep: " + str(self.step) + "\n\n")



