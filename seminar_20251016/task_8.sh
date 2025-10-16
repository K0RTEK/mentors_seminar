usage_percent=$(df / | awk 'NR==2 {gsub("%", ""); print $5}')

if [ "$usage_percent" -gt 80 ]; then
    echo "Использование диска составляет более $usage_percent% процентов"
else
    echo "Использование диска: $usage_percent% - норма"
fi
