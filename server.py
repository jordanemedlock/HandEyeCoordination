# USAGE
# python server.py --prototxt MobileNetSSD_deploy.prototxt --model MobileNetSSD_deploy.caffemodel --montageW 2 --montageH 2

# import the necessary packages
import numpy as np
import imagezmq
import imutils
import cv2
from ivan.display import add_detections_to_image
from ivan.object_detection import ObjectDetector
from ivan.controller import Controller
from json import load



with open('object_detection.json', 'r') as fp:
	det = ObjectDetector(load(fp))

controller = Controller({'image_size': (400, 300)})

# initialize the ImageHub object
image_hub = imagezmq.ImageHub()
while True:
	print('Waiting for image')
	(rpiName, frame) = image_hub.recv_image()

	frame = imutils.resize(frame, width=400)

	objects = det.get_considered_detections(frame)

	target, horiz, vert = controller.get_move_command(objects)


	if not target:
		reply = b'none'
	else:
		reply = str.encode('{},{}'.format(horiz, vert))

	print('sending reply', reply)
	image_hub.send_reply(reply)

	add_detections_to_image(frame, objects, target, horiz, vert)

	cv2.imshow('Ivan server ({})'.format(rpiName), frame)
	key = cv2.waitKey(1) & 0xFF

	if key == ord("q"):
		break

# do a bit of cleanup
cv2.destroyAllWindows()