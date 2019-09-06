# USAGE
# python client.py --server-ip SERVER_IP

# import the necessary packages
from imutils.video import VideoStream
import imagezmq
import argparse
import socket
import time
from ivan.gimbal import Gimbal

# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-s", "--server-ip", default='127.0.0.1',
	help="ip address of the server to which the client will connect")
args = vars(ap.parse_args())

# initialize the ImageSender object with the socket address of the
# server
sender = imagezmq.ImageSender(connect_to="tcp://{}:5555".format(
	args["server_ip"]))

# get the host name, initialize the video stream, and allow the
# camera sensor to warmup
rpiName = socket.gethostname()
# vs = VideoStream(usePiCamera=True).start()
vs = VideoStream(src=0).start()
time.sleep(2.0)

speeds = {
	'left': -1,
	'right': 1,
	'center': 0,
	'up': 1,
	'down': -1
}

gimbal = Gimbal()
 
while True:
	# read the frame from the camera and send it to the server
	frame = vs.read()
	print('sending frame')
	reply = sender.send_image(rpiName, frame)
	reply = reply.decode()
	print('reply', reply)

	if reply == 'none':
		pass # do nothing for now
	else:
		horiz, vert = reply.split(',')

		x = speeds[horiz]
		y = speeds[vert]

		gimbal.move((x, y))



