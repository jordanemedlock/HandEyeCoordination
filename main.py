from face_detection import FaceDetector
from gimbal import Gimbal
import time

fd = FaceDetector()
gimbal = Gimbal()

while True:
	(x, y) = fd.find_face()
	x = 2*x - 1
	y = 2*y - 1
	gimbal.move((x, y))
	time.sleep(0.1)

