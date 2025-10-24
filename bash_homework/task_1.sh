# 1. Создаёт список всех файлов в текущей директории, указывая их тип (файл, каталог и т.д.).

echo "=== Список файлов в текущей директории ==="
files=()
for item in *; do
    [ -e "$item" ] || continue
    files+=("$item")
done

if [ ${#files[@]} -eq 0 ]; then
    echo "В текущей директории нет файлов."
else
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            type="файл"
        elif [ -d "$file" ]; then
            type="каталог"
        elif [ -L "$file" ]; then
            type="символическая ссылка"
        else
            type="другой тип"
        fi
        permissions=$(stat --format="%A" "$file" 2>/dev/null)
        if [ -z "$permissions" ]; then
            permissions="не удалось получить права"
        fi
        echo "Имя: $file | Тип: $type | Права: $permissions"
    done
fi

echo ""

# 2. Проверяет наличие определённого файла, переданного как аргумент скрипта, и выводит сообщение о его наличии или отсутствии.
if [ $# -eq 0 ]; then
    echo "Ошибка: не указан файл для проверки. Используйте: $0 <имя_файла>"
else
    target_file="$1"
    if [ -e "$target_file" ]; then
        echo "Файл '$target_file' существует."
    else
        echo "Файл '$target_file' не существует."
    fi
fi

echo ""

# 3. Использует цикл for для вывода информации о каждом файле: его имя и права доступа.
echo "=== Информация о файлах (имя и права доступа) ==="
for file in "${files[@]}"; do
    permissions=$(stat --format="%A" "$file" 2>/dev/null)
    if [ -z "$permissions" ]; then
        permissions="не удалось получить права"
    fi
    echo "Имя: $file | Права: $permissions"
done