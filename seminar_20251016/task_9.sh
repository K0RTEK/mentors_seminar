echo -n "Введите команду для запуска в фоне: "
read command

$command &

pid=$!

echo "Команда запущена в фоне. PID: $pid"
