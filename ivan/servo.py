import sys
import traceback


class Servo(object):
	def __init__(self):
		self.location = 0.5

	def turn_to(self, value):
		self.location = value

	def turn(self, delta):
		self.turn_to(self.location + delta)

	@classmethod
	def mockServo(cls):
		return MockServo()

	@classmethod
	def gpioServo(cls, pin):
		try:
			import gpiozero 
			return GPIOServo(pin)
		except:
			traceback.print_exc(file=sys.stdout)
			return cls.mockServo()

	@classmethod
	def servoKitServo(cls, kit, index, actuation_range=120):
		try:
			from adafruit_servokit import ServoKit
			kit = ServoKit(channels=16)
			return ServoKitServo(kit, index, actuation_range=actuation_range)
		except:
			traceback.print_exc(file=sys.stdout)
			return cls.mockServo()


class MockServo(Servo):
	def turn_to(self, value):
		super().turn_to(value)
		print('Servo turned to {}'.format(value))


class GPIOServo(Servo):
	def __init__(self, pin):
		super().__init__()
		self.pin = pin
		self.servo = gpiozero.Servo(pin)

	def turn_to(self, value):
		super().turn_to(value)
		self.servo.value = value


class ServoKitServo(Servo):
	def __init__(self, kit, index, actuation_range=120):
		super().__init__()
		self.servo = kit.servo[index]
		self.servo.actuation_range = actuation_range

	def turn_to(self, value):
		super().turn_to()
		self.servo.angle = self.location * self.servo.actuation_range





