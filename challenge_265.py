from __future__ import print_function
import itertools
import random


def main():
    upper_bound = raw_input("Please choose an upper bound (zero-based): ")
    perm_no     = raw_input("Please choose a permutation number (zero-based): ")
    try:
        ub = int(upper_bound)
        perm = int(perm_no)
        perms = list(itertools.permutations(range(ub)))
        perms.sort()
        print(perms[perm])
    except ValueError:
        print("Expected two integers, got {} and {}".format(upper_bound, perm))


if __name__ == '__main__':
    main()
