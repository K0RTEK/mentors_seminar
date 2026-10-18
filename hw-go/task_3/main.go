package main

import "fmt"

func main() {
	var number int
	fmt.Scanln(&number)

	var array []int
	var summa int

	for i := 0; i < number; i++ {
		array = append(array, i+1)
		summa += array[i]
	}

	result := float64(summa) / float64(number)
	fmt.Println(result)
}
