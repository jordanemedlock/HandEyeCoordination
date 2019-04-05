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
    cascPath = '/usr/local/share/opencv4/haarcascades/haarcascade_frontalface_default.xml'
    class FaceDetector():
        def __init__(self):
            self.faceCascade = cv2.CascadeClassifier(cascPath)
            self.cap = cv2.VideoCapture(0)
            self.cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)
            self.last = 0.5, 0.5

        def find_face(self):
            re, image = self.cap.read()
            if not re:
                return (random(), random())
            gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
            faces = self.faceCascade.detectMultiScale(
                gray,
                scaleFactor=1.1,
                minNeighbors=5,
                minSize=(30,30)
            )

            for (x, y, w, h) in faces:
                height, width = gray.shape
                cv2.rectangle(image,rec=(x,y,w,h),color=(255,0,0),thickness=2)
                # cv2.imshow('face', image)
                # cv2.waitKey(10)
                x = x + int(w/2)
                y = y + int(h/2)
                x, y = x / width, (1 - y / height)
                print('found face at', x, y)
                self.last = (x,y)
                return x, y
            return (random(), random())


