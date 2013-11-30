# Challenge #134:
# N-Divisible Digits (Easy)

def n_divisible(n, m):
    biggest_num = 10 ** m - 1
    # print('n = {n}, m = {biggest_num}'.format(n=n, biggest_num=biggest_num))
    for i in range(biggest_num, n, -1):
        if i % n == 0:
            return i
    
    return 'No solution found.'


def main():
    line = input('').split(' ')
    m = int(line[0])
    n = int(line[1])
    print(n_divisible(n, m))


if __name__ == '__main__':
    main()
