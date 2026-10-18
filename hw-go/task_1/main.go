package main

import "fmt"

func main() {
	var fn int
	var sn int
	var operator string

	fmt.Scanln(&fn)
	fmt.Scanln(&sn)
	fmt.Scanln(&operator)

	switch operator {
	case "+":
		fmt.Println(fn + sn)
	case "-":
		fmt.Println(fn - sn)
	case "/":
		if sn == 0 {
			fmt.Println("Деление на ноль")
		} else {
			fmt.Println(fn / sn)
		}
	case "*":
		fmt.Println(fn * sn)
	default:
		fmt.Println("Неизвестный оператор")
	}
}
