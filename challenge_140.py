# Challenge 140:
# Variable Notation (Easy)

import re


spaced_var = re.compile('\s')
camel_case = '0'
snake_case = '1'
snake_caps = '2'


def handle_camel(var):
    return var[0] + ''.join(map(str.capitalize, var[1:]))


def handle_snake_caps(var):
    return '_'.join(map(str.upper, var))

def convert_notation(notation, name):
    return conversion_rules[notation](name)


conversion_rules = { camel_case : handle_camel,
                     snake_case : '_'.join,
                     snake_caps : handle_snake_caps, }

def main():
    notation = input()
    name = input()
    print(convert_notation(notation, name))


if __name__ == '__main__':
    main()
