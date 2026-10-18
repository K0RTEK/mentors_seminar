package main

import "fmt"

func main() {
	var n int
	fmt.Scan(&n)

	var summa int

	for i := 1; i <= n; i++ {
		if i%2 == 0 && i%3 == 0 {
			summa += i
		}
	}

	fmt.Println("Сумма:", summa)
}
