from solid.objects import *
from solid.utils import *
from solid.solidpython import *

class SolidObject(object):
    def render(self):
        pass
    def render_to_file(self, filename):
        scad_render_to_file(self.render(), )



class Servo(SolidObject):
    class Gear(SolidObject):
        RADIUS = 2.5
        HEIGHT = 3
        def render(self):
            return cylinder(r=RADIUS, h=HEIGHT)

    class Arm(SolidObject):
        LARGER_DIAMETER = 
        SMALLER_DIAMETER = 
        LENGTH = 
        def render(self):
            linear_extrude(height=5)(
                circle(d=7),
                translate([0,14])(circle(d=4)),
                polygon([[3,0], [2,14], [-2,14], [-3,0]])
            )
    servoX = 12.3
    servoY = 22.6
    servoArmW = 32.3
    servoArmH = 11
scad_render_to_file(d, "hand_eye_coordination.scad")