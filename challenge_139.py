# Daily Programmer Challenge #139: 
# Pangrams (Easy)

from collections import Counter
from string import ascii_lowercase


def is_pangram(a_string):
    lc_str = a_string.lower()
    in_str = [ char in lc_str for char in ascii_lowercase ]
    return all(in_str)


def pangram_ec(a_string):
    lc_str = a_string.lower()
    char_count = Counter(lc_str)
    count_str = [ '{char}: {num}'.format(char=k, num=char_count[k]) 
                  for k in sorted(list(set((char_count.elements()))))
                  if k in ascii_lowercase ]
    in_str = [ char in lc_str for char in ascii_lowercase ]
    # not a fan of this + ' ' bit:
    result_str = str(all(in_str)) + ' ' + ' '.join(count_str)
    return result_str


def main():
    n = int(input(''))
    strings = [ input('') for i in range(n) ]
    for s in strings:
        print(pangram_ec(s))


if __name__ == '__main__':
    main()
