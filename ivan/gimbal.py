try:
    from adafruit_servokit import ServoKit
    kit = ServoKit(channels=16)
except:
    from ivan.util.mock_servo import mock_kit
    kit = mock_kit
from ivan.util.range import Range

class Gimbal():
    def __init__(self):
        self.kit = kit
        self.x_axis = kit.servo[0]
        self.y_axis = kit.servo[1]
        self.x_loc = 60
        self.y_loc = 60
        self.x_range = Range(0.0, 120.0)
        self.y_range = Range(0.0, 120.0)


    def move(self, direction, speed=10):
        (dx, dy) = direction
        new_x = self.x_loc + dx * speed
        new_y = self.y_loc + dy * speed
        if new_x in self.x_range:
            self.x_loc = new_x
        if new_y in self.y_range:
            self.y_loc = new_y

        self.x_axis.angle = self.x_loc
        self.y_axis.angle = self.y_loc








        
