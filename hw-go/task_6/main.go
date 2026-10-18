package main

import "fmt"

func main() {
	var n int
	fmt.Scan(&n)

	if n <= 0 {
		fmt.Println("Количество чисел должно быть больше 0")
		return
	}

	var positive, negative, zeros int

	for i := 0; i < n; i++ {
		var val int
		fmt.Scan(&val)
		if val > 0 {
			positive++
		} else if val < 0 {
			negative++
		} else {
			zeros++
		}
	}

	fmt.Println("Положительных:", positive)
	fmt.Println("Отрицательных:", negative)
	fmt.Println("Нулей:", zeros)
}
