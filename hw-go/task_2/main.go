package main

import "fmt"

func main() {
	var number int

	fmt.Scanln(&number)

	if number >= 0 {
		fmt.Println("Число положительное")
	} else {
		fmt.Println("Число отрицательное")
	}

	if number%2 == 0 {
		fmt.Println("Число четное")
	} else {
		fmt.Println("Число нечетное")
	}

	if number%3 == 0 || number%5 == 0 {
		fmt.Println("Число делится на 3 или 5")
	} else {
		fmt.Println("Число не делится на 3 или 5")
	}
}
