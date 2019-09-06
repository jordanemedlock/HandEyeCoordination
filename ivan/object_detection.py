import cv2
import numpy as np

def default_options():
	return {

	}

class ObjectDetector():
	def __init__(self, options=None):
		self.options = options or {}
		self.options.update(default_options())

		self.prototxt = self.options['prototxt']
		self.caffemodel = self.options['caffemodel']

		self.classes = self.options['classes']
		self.consider = self.options['consider']
		self.confidence = self.options['confidence']

		self.input_width = self.options['input_width']
		self.input_height = self.options['input_height']
		self.scale_factor = self.options['scale_factor']

		self.initialize_model()

	def initialize_model(self):
		self.model = cv2.dnn.readNetFromCaffe(self.prototxt, self.caffemodel)


	def get_raw_detections(self, image):
		size = (self.input_width, self.input_height)
		resized = cv2.resize(image, size)
		blob = cv2.dnn.blobFromImage(resized, 1.0/self.scale_factor, size, self.scale_factor)

		self.model.setInput(blob)
		detections = self.model.forward()

		return detections

	def get_all_detections(self, image):
		(h, w) = image.shape[:2]

		detections = self.get_raw_detections(image)

		objects = []

		for i in np.arange(0, detections.shape[2]):
			confidence = detections[0,0,i,2]

			idx = int(detections[0,0,i,1])
			try:
				class_ = self.classes[idx]
			except:
				class_ = 'unknown'

			box = detections[0,0,i,3:7] * np.array([w, h, w, h])
			box = box.astype('int')

			objects.append({
				'confidence': confidence,
				'class': class_,
				'location': box
			})

		objects = list(sorted(objects, key=lambda obj: obj['confidence'], reverse=True))
		return objects

	def get_considered_detections(self, image):
		objects = self.get_all_detections(image)

		return list(filter(lambda x: x['class'] in self.consider and x['confidence'] > self.confidence, objects))






