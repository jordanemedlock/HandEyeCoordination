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
	cascPath = 'cascade file path'
	class FaceDetector():
		def __init__(self):
			self.faceCascade = cv2.CascadeClassifier(cascPath)
			print('loaded face cascade')
			self.cap = cv2.VideoCapture(0, cv2.CAP_V4L)
			if self.cap.isOpened():
				print('initialized capture')
			else:
				print('failed to initialize')

		def find_face(self):
			print('reading image')
			re, image = self.cap.read()
			if not re:
				return random(), random()
			gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
			faces = self.faceCascade.detectMultiScale(
				gray,
				scaleFactor=1.1,
				minNeighbors=5,
				minSize=(30,30),
				flags=cv2.cv.CV_HAAR_SCALE_IMAGE
			)

			print("Found {0} faces!".format(len(faces)))

			if faces:
				(x, y, w, h) = faces[0]
				x = x + w/2
				y = y + h/2
				height, width, channels = gray.shape
				return x / width, (1 - y / height)
			else:
				return (random(), random())


