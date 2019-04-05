from face_detection import FaceDetector
from gimbal import Gimbal
import time

fd = FaceDetector()
gimbal = Gimbal()

while True:
    (x, y) = fd.find_face()
    x = 2*x - 1
    y = 2*y - 1
    x_dir = 'right' if x > 0 else 'left'
    y_dir = 'up' if x > 0 else 'down'

    print('moving', y_dir, 'and', x_dir)
    gimbal.move((-x, y), 30)

