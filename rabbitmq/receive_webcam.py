import pika
import sys
import os
import numpy as np
import cv2

def main():
    connection = pika.BlockingConnection(
        pika.ConnectionParameters(
            'localhost', 
            credentials=pika.PlainCredentials('ivan', 'ivan')
        )
    )
    channel = connection.channel()

    def image_received(ch, method, properties, body):
        image = cv2.imdecode(np.frombuffer(body, dtype='uint8'), -1)

        cv2.imshow(method.routing_key, image)
        cv2.waitKey(1)

    channel.exchange_declare(exchange='main', exchange_type='topic')
    result = channel.queue_declare(queue='', exclusive=True)
    queue_name = result.method.queue

    channel.queue_bind(
        exchange='main', queue=queue_name, routing_key='*.camera.data'
    )

    channel.basic_consume(
        queue=queue_name,
        auto_ack=True,
        on_message_callback=image_received
    )

    channel.start_consuming()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)