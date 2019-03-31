

try:
	from adafruit_servokit import ServoKit
	kit = ServoKit
except ImportError:
	from mock_servo import mock_kit
	kit = mock_kit

