add() {
	local a=$1
	local b=$2
	echo $(( a+b ))
}

sum=$(add 1 1)

echo "Сумма: $sum"
