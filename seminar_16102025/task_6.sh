echo -n "Введите путь к директории: "
read dir_path

if [ ! -d "$dir_path" ]; then
    echo "Ошибка: '$dir_path' не является директорией или не существует"
    exit 1
fi

find "$dir_path" -type f -mtime +7 -delete

echo "Все файлы, изменённые более 7 дней назад, удалены из '$dir_path'"
