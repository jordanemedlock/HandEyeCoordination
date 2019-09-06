import math

def default_options():
	return {}

class Controller():
	def __init__(self, options=None):
		options = options or {}

		options.update(default_options())

		self.options = options

		self.image_size = self.options['image_size']

		self.previous_target = None

	def get_target(self, objects):
		if len(objects) > 0:
			return sorted(objects, key=lambda x: self.target_score(x), reverse=True)[0]
		else:
			return None

	def target_score(self, obj):
		# I am going to make all of these values between 0 and 10 and then combine them later
		same_type_as_prev = False
		distance_to_prev = 1.0
		class_values = {
			'person': 3.0,
			'dog': 2.0,
			'cat': 1.0
		}
		class_score = 0.0
		if self.previous_target:
			same_type_as_prev = self.previous_target['class'] == obj['class']
			if same_type_as_prev:
				distance_to_prev = self.distance_to_prev(obj)
		if obj['class'] in class_values:
			class_score = class_values[obj['class']]

		same_type_score = 10 if same_type_as_prev else 0
		distance_score = 10 * (1 - distance_to_prev)

		return same_type_score * 100 + distance_score * 10 + class_score * 1

	def get_center(self, obj):
		start_x, start_y, end_x, end_y = obj['location']

		x = (start_x + end_x) / 2.0
		y = (start_y + end_y) / 2.0
		x /= self.image_size[0]
		y /= self.image_size[1]

		return (x, y)

	def distance_to_prev(self, obj):
		if self.previous_target:
			px, py = self.get_center(self.previous_target)

			x, y = self.get_center(obj)

			dx, dy = x-px, y-py
			return math.sqrt(dx*dx + dy*dy)
		return 1.0


	def get_move_command(self, objects):
		target = self.get_target(objects)

		if target:
			x, y = self.get_center(target)

			if x < 0.4:
				horiz = 'left'
			elif x < 0.6:
				horiz = 'center'
			else:
				horiz = 'right'

			if y < 0.4:
				vert = 'up'
			elif y < 0.6:
				vert = 'center'
			else:
				vert = 'down'

			self.previous_target = target

			return target, horiz, vert
		else:
			return None, None, None















