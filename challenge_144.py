# Challenge #144:
# Nuts and Bolts

def main():
    n = int(input())
    # read in input, use to build 2 dicts; old prices and new prices
    old_prices = {}
    for i in range(n):
        s = input().split(' ')
        old_prices[s[0]] = int(s[1])

    new_prices = {}
    for i in range(n):
        s = input().split(' ')
        new_prices[s[0]] = int(s[1])

    for k in old_prices:
        price_diff = new_prices[k] - old_prices[k]
        if price_diff > 0:
            print('{0} +{1}'.format(k, price_diff))
        elif price_diff < 0:
            print('{0} {1}'.format(k, price_diff))

if __name__ == '__main__':
    main()
