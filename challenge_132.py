# Challenge 132:
# Greatest Common Divisor

def gcd(m, n):
    while n != 0:
        m, n = n, m % n
    return m


def main():
    a, b = input().split(' ')
    print( gcd(int(a), int(b)) )


if __name__ == '__main__':
    main()
