import pika
import cv2
import numpy as np
import json

connection = pika.BlockingConnection(
    pika.ConnectionParameters(
        'localhost', 
        credentials=pika.PlainCredentials('ivan', 'ivan')
    )
)
channel = connection.channel()

channel.exchange_declare(exchange='main', exchange_type='topic')

def send_data(channel, key, data):
    data_key = key+'.data'
    channel.basic_publish(exchange='main', routing_key=data_key, body=data)
    print(f' [x] Sent {data_key}')

def send_image(channel, key, image):
    
    ret, jpg_buffer = cv2.imencode(
            ".jpg", frame, [int(cv2.IMWRITE_JPEG_QUALITY), 95])
    if ret:
        send_data(channel, key, jpg_buffer.tobytes())
    else:
        print(f' [X] Failed to jpg encode for stream {key}')

capture = cv2.VideoCapture(1)

while True:
    ret, frame = capture.read()
    if ret:
        send_image(channel, 'ivan.camera', frame)


