read -p "Введите число: " number

if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
    echo "Ошибка: введите целое число (положительное, отрицательное или ноль)."
    exit 1
fi

if [ "$number" -gt 0 ]; then
    echo "Число $number — положительное."
    
    echo "Счёт от 1 до $number:"
    counter=1
    while [ $counter -le $number ]; do
        echo "$counter"
        ((counter++))
    done

elif [ "$number" -lt 0 ]; then
    echo "Число $number — отрицательное."

else
    echo "Число равно нулю."
fi