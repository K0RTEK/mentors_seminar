package main

import "fmt"

func main() {
	var n int
	fmt.Scan(&n)

	if n <= 0 {
		fmt.Println("Количество чисел должно быть больше 0")
		return
	}

	var val int
	fmt.Scan(&val)
	minVal, maxVal := val, val

	for i := 1; i < n; i++ {
		fmt.Scan(&val)
		if val < minVal {
			minVal = val
		}
		if val > maxVal {
			maxVal = val
		}
	}

	fmt.Println("Максимум:", maxVal)
	fmt.Println("Минимум:", minVal)
}
