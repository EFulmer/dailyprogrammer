# Challenge 146

import math


def perimeter(num_sides, circumradius):
    return circumradius * 2 * math.sin(math.pi / num_sides) * num_sides


def main():
    data = list(input().split(' '))
    num_sides = int(data[0])
    circumradius = float(data[1])
    perim = perimeter(num_sides, circumradius)
    print('{0:.3f}'.format(perim))


if __name__ == '__main__':
    main()
