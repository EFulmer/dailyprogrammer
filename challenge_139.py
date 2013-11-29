# Daily Programmer Challenge #139: 
# Pangrams (Easy)

def is_pangram(string):
    alphabet = { chr(i) for i in range(96, 123) }
    lc_str = string.lower()
    return all(alpha in lc_str for alpha in alphabet)
