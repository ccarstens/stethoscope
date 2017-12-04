class Agent:
    x = 0
    y = 0

    size = 1

    def move_right(self, step):

        newPos = self.x + step

        if newPos > width:
            newPos = 0

        self.x = newPos
        # print(self.x)

    def draw(self):
        stroke(255, 0, 0)
        fill(255, 0, 0)
        ellipse(self.x, mouseY, self.size, self.size)