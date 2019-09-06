import cv2

def add_detections_to_image(image, detections, target, horiz, vert):
	objCount = {}

	(h, w) = image.shape[:2]

	for obj in detections:
		color = (0, 255, 0)
		if obj == target:
			color = (0, 0, 255)

		class_ = obj['class']
		if class_ not in objCount:
			objCount[class_] = 0
		objCount[class_] += 1

		start_x, start_y, end_x, end_y = obj['location']

		cv2.rectangle(image, (start_x, start_y), (end_x, end_y), color, 2)

	label = ', '.join('{}: {}'.format(obj, count) for (obj, count) in objCount.items())
	if target:
		label += ' => {} {}'.format(horiz, vert)

	cv2.putText(image, label, (10, h-20), 
		cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)






