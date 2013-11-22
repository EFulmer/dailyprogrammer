# Challenge #141 (Easy): Fletcher's Checksum, 16-bit version

from __future__ import print_function


def fletcher_16(data):
    sum1 = 0
    sum2 = 0
    chars = [ ord(d) for d in data ]
    for c in chars:
        sum1 = (sum1 + c) % 255
        sum2 = (sum1 + sum2) % 255
    
    return (sum2 << 8) | sum1

def main():
    lines = int(raw_input(''))
    args = []
    for i in range(lines):
        args.append(raw_input(''))

    for arg in args:
        num = args.index(arg) + 1
        print('{0} {1:x}'.format(num, fletcher_16(arg)))

if __name__ == '__main__':
    main()
