import pika
import sys
import os

def main():
    connection = pika.BlockingConnection(
        pika.ConnectionParameters(
            'localhost', 
            credentials=pika.PlainCredentials('ivan', 'ivan')
        )
    )
    channel = connection.channel()

    def callback(ch, method, properties, body):
        print(' [x] Receive', body)

    channel.basic_consume(
        queue='hello',
        auto_ack=True,
        on_message_callback=callback
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