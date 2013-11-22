from __future__ import print_function


def ranked_voting(candidates, ballots):
    # as given, higher number = lower pref. reverse that by subtracting 
    # the max from each, then getting the abs of everything in the result.
    votes = [ abs(x) for x in map(lambda x: max(ballots) - x, ballots) ]
    percents = [ float(x) / len(votes) for x in votes ]
    output = ''
    for pct, cnd in zip(percents, candidates):
        output += '{0:%} {1}, '.format(pct, cnd)
    
    print(output)


def main():
    n, m = raw_input('').split(' ')
    candidates = raw_input('').split(' ')
    ballots = [ raw_input('').split(' ') for i in range(1, m) ]

if __name__ == '__main__':
    main()
