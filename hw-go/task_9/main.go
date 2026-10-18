package main

import "fmt"

func main() {
	var balance float64
	fmt.Scan(&balance)

	var choice int
	fmt.Scan(&choice)

	switch choice {
	case 1:
		fmt.Println("Баланс:", balance)
	case 2:
		var amount float64
		fmt.Scan(&amount)
		balance += amount
		fmt.Println("Баланс:", balance)
	case 3:
		var amount float64
		fmt.Scan(&amount)
		if amount > balance {
			fmt.Println("Недостаточно средств")
		} else {
			balance -= amount
			fmt.Println("Баланс:", balance)
		}
	default:
		fmt.Println("Неизвестное действие")
	}
}
