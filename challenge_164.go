package main

import "fmt"
import "reflect" // for deep-equality checks; to compare maps for Task 3
import "strings" // to lowercase strings for Task 3
import "unicode" // used for Task 3; whitespace detection in anagrams

func hello_world() {
	fmt.Println("Hello World")
}

func array_3and5() []int {
	// I guess that with some number theory knowledge you could 
	// figure out a more effcient way to do the initialization and 
	// looping that doesn't involve constant reallocation of memory,
	// but that's not something I know about right now...

	// initialize an empty int array
	array := []int{}

	for i := 0; len(array) < 100; i++ {
		if i % 3 == 0 && i % 5 == 00 {
			// append creates a new array with the 2nd argument
			// appended to it, so we re-assign here
			array = append(array, i)
		}
	}
	return array
}

func print_array(array []int) {
	for i := 0; i < len(array); i++ {
		fmt.Println(array[i])
	}
}

func anagram(word1 string, word2 string) bool {
	// make a map containing the number of appearances for each rune
	// (go's encoding-agnostic abstraction of characters)
	// in both strings, and compare them: if they match, then word1 and
	// word2 are anagrams of each other
	
	// initialize empty maps/dictionaries/hashes that map runes to 
	// integers; these are our rune-count dicts for each word
	chars1 := make(map[rune]int)
	chars2 := make(map[rune]int)

	// range gives (int-index, rune) pairs for strings: this is a foreach 
	// loop
	for _, c := range strings.ToLower(word1) {
		// discarding spaces makes the function more flexible, so
		// it can check whether two PHRASES, not just two WORDS,
		// are anagrams of each other
		if ! unicode.IsSpace(c) {
			// default int value in golang is 0, so this is safe
			chars1[c] = chars1[c] + 1
		}
	}

	for _, c := range strings.ToLower(word2) {
		if ! unicode.IsSpace(c) {
			chars2[c] = chars2[c] + 1
		}
	}

	return reflect.DeepEqual(chars1, chars2)
}

func remove_char(banned rune, s string) string {
	filtered := make([]rune, len(s))
	i := 0
	for _, c := range s {
		if c != banned {
			filtered[i] = c
			i++
		}	
	}
	return string(filtered[:i])
}

func sum_ints(numbers []int) int {
	total := 0
	for _, v := range numbers {
		total = total + v
	}
	return total
}

func sum_floats(numbers []float64) float64 {
	total := 0.0
	for i := range numbers {
		total = total + float64(i)
	}
	return total
}

func main() {
	fmt.Println("Task 1: Hello World")
	hello_world()
	fmt.Println("")

	fmt.Println("Task 2: Return an array of the first 100 numbers that are divisible by 3 and 5")
	array := array_3and5()
	print_array(array)
	fmt.Println("")

	fmt.Println("Task 3: Create a program that verifies if a word is an anagram of another word.")
	fmt.Println(anagram("Mary", "Army"))
	fmt.Println("")
	
	fmt.Println("Task 4: Create a program that removes a specified letter from a word.")
	fmt.Println(remove_char('g', "golang"))
	fmt.Println("")
	
	fmt.Println("Task 5: Sum all the elements of an array.")
	int_array := []int{1, 2, 3, 4, 5}
	fmt.Printf("sum_ints(%v) = %d\n", int_array, sum_ints(int_array))
}
