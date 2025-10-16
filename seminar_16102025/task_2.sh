echo -n "Введите название файла: "
read file_path 

if [ -f "$file_path" ]; then
	echo "Файл существует"
else
	echo "Файл не существует"
fi
