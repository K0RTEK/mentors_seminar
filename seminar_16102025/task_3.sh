echo -n "Введите название папки для архивации: "
read folder_name

if [ -d "$folder_name" ]; then
	tar -czf $folder_name.tar.gz $folder_name
	echo "Папка успешно заархивирована"
else
	echo "Такой папки не существует"
fi
