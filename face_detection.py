from random import random

needs_mock = False
try:
	import cv2

except ImportError:
	needs_mock = True

if needs_mock:
	class FaceDetector():
		def __init__(self):
			pass

		def find_face(self):
			return (random(), random())

else:
	class FaceDetector():
		def __init__(self):
			pass

		def find_face(self):
			pass