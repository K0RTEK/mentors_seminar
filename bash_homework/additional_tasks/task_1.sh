# Проверка аргумента
if [ $# -ne 1 ]; then
    echo "Ошибка: укажите директорию для резервного копирования."
    echo "Использование: $0 <путь_к_директории>"
    exit 1
fi

SOURCE_DIR="$1"

# Проверяем существование исходной директории
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Ошибка: директория '$SOURCE_DIR' не существует."
    exit 1
fi

BACKUP_DIR="backups"
mkdir -p "$BACKUP_DIR"

LOG_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).log"

CURRENT_DATE=$(date +%Y-%m-%d)

# Счётчик скопированных файлов
COUNT=0

echo "=== Резервное копирование начато ===" | tee -a "$LOG_FILE"
echo "Исходная директория: $SOURCE_DIR" | tee -a "$LOG_FILE"
echo "Дата резервного копирования: $CURRENT_DATE" | tee -a "$LOG_FILE"
echo "Лог записан в: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Проходим по всем файлам в указанной директории (без поддиректорий)
for file in "$SOURCE_DIR"/*; do
    # Пропускаем, если нет файлов
    if [ ! -e "$file" ]; then
        continue
    fi

    # Пропускаем каталоги (только файлы)
    if [ -d "$file" ]; then
        echo "Пропущена директория: $(basename "$file")" | tee -a "$LOG_FILE"
        continue
    fi

    # Формируем новое имя файла с датой
    filename=$(basename "$file")
    extension="${filename##*.}"
    basename="${filename%.*}"

    # Если файл без расширения — просто добавляем дату
    if [ "$filename" = "$extension" ]; then
        new_filename="${filename}_${CURRENT_DATE}"
    else
        new_filename="${basename}_${CURRENT_DATE}.${extension}"
    fi

    # Копируем файл в папку backups
    cp "$file" "$BACKUP_DIR/$new_filename" 2>> "$LOG_FILE"

    if [ $? -eq 0 ]; then
        echo "Скопирован: $filename -> $new_filename" | tee -a "$LOG_FILE"
        ((COUNT++))
    else
        echo "Ошибка при копировании: $filename" | tee -a "$LOG_FILE"
    fi
done

echo "" | tee -a "$LOG_FILE"
echo "=== Резервное копирование завершено ===" | tee -a "$LOG_FILE"
echo "Количество успешно скопированных файлов: $COUNT" | tee -a "$LOG_FILE"

echo ""
echo "Успешно завершено!"
echo "Скопировано файлов: $COUNT"
echo "Лог операций сохранён в: $LOG_FILE"