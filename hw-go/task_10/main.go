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
	summa := val
	minVal, maxVal := val, val

	var even, odd int
	if val%2 == 0 {
		even++
	} else {
		odd++
	}

	for i := 1; i < n; i++ {
		fmt.Scan(&val)
		summa += val
		if val < minVal {
			minVal = val
		}
		if val > maxVal {
			maxVal = val
		}
		if val%2 == 0 {
			even++
		} else {
			odd++
		}
	}

	average := float64(summa) / float64(n)

	fmt.Println("Сумма:", summa)
	fmt.Println("Среднее:", average)
	fmt.Println("Максимум:", maxVal)
	fmt.Println("Минимум:", minVal)
	fmt.Println("Чётных:", even)
	fmt.Println("Нечётных:", odd)
}
