echo -n "Введите ваше имя:  "
read name

echo -n "Введите ваш возраст: "
read age

if ! [[ "$age" =~ ^[0-9]+$ ]]; then
	echo "Ошибка: возраст должен быть числом"
	exit 1
fi

next_year_age=$((age + 1))

echo "Привет, $name! Через год тебе будет $next_year_age лет"

