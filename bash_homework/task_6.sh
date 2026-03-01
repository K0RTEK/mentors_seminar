echo "=== Демонстрация ввода/вывода и перенаправления ==="

# 1. Читает данные из файла input.txt.
echo ""
echo "Чтение данных из input.txt:"
if [ ! -f "input.txt" ]; then
    echo "Файл input.txt не существует. Создаю тестовый файл..."
    cat > input.txt << 'EOF'
Это строка 1.
Это строка 2.
Это строка 3.
EOF
fi

cat input.txt

# 2. Перенап  равляет вывод команды wc -l (подсчет строк) в файл output.txt.
echo ""
echo "Подсчёт строк в input.txt и запись результата в output.txt:"
wc -l < input.txt > output.txt

echo "Результат сохранён в output.txt:"
cat output.txt

# 3. Перенаправляет ошибки выполнения команды ls для несуществующего файла в файл error.log.
echo ""
echo "Попытка выполнить ls для несуществующего файла и перехват ошибок в error.log:"
ls non_existent_file.txt 2> error.log

if [ -s "error.log" ]; then
    echo "Ошибки записаны в error.log:"
    cat error.log
else
    echo "Ошибок не возникло (файл, возможно, существует)."
fi

echo ""
echo "Все операции завершены."