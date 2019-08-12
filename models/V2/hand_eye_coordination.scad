

difference() {
	cube(size = 10);
	sphere(r = 10);
}
/***********************************************
*********      SolidPython code:      **********
************************************************
 
from solid.objects import *
from solid.utils import *
from solid.solidpython import *

d = difference()(
	cube(10),
	sphere(10)
)
scad_render_to_file(d, "hand_eye_coordination.scad") 
 
************************************************/
