echo -n "Введите имя или путь вашей папки: "
read folder_path

if [ ! -d "$folder_path" ]; then
	echo "Вашей папки не существует"
	exit 1
else
	folder_name=$(basename $"folder_path")
	
	parent_dir=$(dirname "$folder_path")

	new_name="backup_${folder_name}"

	new_path="${parent_dir}/${new_name}"

	if [ -d "$new_path" ]; then
		rm -r $new_path
		cp -r $folder_path $new_path
		echo "Такая папка уже существовала. Пересоздал ее"
	else
		cp -r $folder_path $new_path
	fi
	
	for file in "$new_path"/*.txt; do
		base_file_name=$(basename $file)
		dir_path=$(dirname $file)
		mv "$dir_path/$base_file_name" "$dir_path/backup_$base_file_name"
	done
fi
