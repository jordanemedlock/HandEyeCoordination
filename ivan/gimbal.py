from ivan.util.range import Range
from ivan.servo import Servo

class Gimbal():
    def __init__(self):
        self.x_axis = Servo.gpioServo(2)
        self.y_axis = Servo.gpioServo(3)
        self.x_loc = 0.5
        self.y_loc = 0.5
        self.x_range = Range(0.0, 1.0)
        self.y_range = Range(0.0, 1.0)


    def move(self, direction, speed=0.05):
        (dx, dy) = direction
        new_x = self.x_loc + dx * speed
        new_y = self.y_loc + dy * speed
        if new_x in self.x_range:
            self.x_loc = new_x
        if new_y in self.y_range:
            self.y_loc = new_y

        self.x_axis.turn_to(self.x_loc)
        self.y_axis.turn_to(self.y_loc)








        
