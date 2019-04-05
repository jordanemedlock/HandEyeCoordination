

class Range():
    def __init__(self, start, end, including_start=True, including_end=False):
        self.start = start
        self.end = end
        self.including_start = including_start
        self.including_end = including_end

    def __contains__(self, item):
        return ((self.start < item or (self.including_start and self.start == item))
            and (item < self.end or (self.including_end and self.end == item)))


if __name__ == '__main__':
    r1 = Range(0.0, 10.0)
    print('0.0 in r1', 0.0 in r1)
    print('10.0 in r1', 10.0 in r1)
    print('5.0 in r1', 5.0 in r1)
    print('100.0 in r1', 100.0 in r1)


    r2 = Range(0.0, 10.0, including_end=True)
    print('0.0 in r1', 0.0 in r2)
    print('10.0 in r1', 10.0 in r2)
    print('5.0 in r1', 5.0 in r2)
    print('100.0 in r1', 100.0 in r2)