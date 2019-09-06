
from imutils.video import VideoStream
import imutils
import time
import cv2
from ivan.display import add_detections_to_image
from ivan.object_detection import ObjectDetector
from ivan.controller import Controller
from json import load

with open('object_detection.json', 'r') as fp:
	config = load(fp)

print('Creating object detector')
det = ObjectDetector(config)
controller = None # We need the image dimensions to make the controller

print('Loading video stream')
vs = VideoStream(src=0).start()
time.sleep(2.0)

while True:
	print('Reading frame')
	frame = vs.read()


	frame = imutils.resize(frame, width=400)

	if not controller:
		y, x = frame.shape[:2]
		print(x, y)
		controller = Controller({'image_size': (x, y)})

	print('Getting detections')
	objects = det.get_considered_detections(frame)
	target, horiz, vert = controller.get_move_command(objects)

	add_detections_to_image(frame, objects, target, horiz, vert)

	cv2.imshow('test.py', frame)
	key = cv2.waitKey(1) & 0xFF

	if key == ord('q'):
		break