# Я пытался :(

get_memory_usage() {
    # Получаем общую память и свободную (в МБ)
    total_mem=$(free -m | awk 'NR==2{print $2}')
    used_mem=$(free -m | awk 'NR==2{print $3}')

    if [ "$total_mem" -gt 0 ]; then
        echo "scale=1; ($used_mem / $total_mem) * 100" | bc
    else
        echo "0"
    fi
}

get_cpu_load() {
    # Используем uptime и извлекаем среднюю нагрузку за 1 минуту
    load=$(uptime | awk -F'load average:' '{ print $2 }' | awk '{ print $1 }')
    echo "$load"
}

get_disk_usage() {
    # Используем df для корневой файловой системы
    usage=$(df / | awk 'NR==2{print $5}' | sed 's/%//')
    echo "$usage"
}

# --- Сбор данных ---

echo "=== Мониторинг системных ресурсов ==="
echo "Дата и время: $(date)"
echo ""

cpu_load=$(get_cpu_load)
echo "Загрузка CPU (средняя за 1 мин): $cpu_load"

mem_percent=$(get_memory_usage)
echo "Использование памяти: $mem_percent%"

disk_percent=$(get_disk_usage)
echo "Использование диска (/): $disk_percent%"

echo ""

# --- Проверка порога памяти ---

THRESHOLD=80

if (( $(echo "$mem_percent > $THRESHOLD" | bc -l) )); then
    echo "ВНИМАНИЕ: Использование памяти превысило $THRESHOLD%!"
    echo "   Текущее использование: $mem_percent%"
    echo ""
    echo "Топ-5 процессов по использованию памяти:"
    echo "   PID    %MEM  COMMAND"
    ps aux --sort=-%mem | head -n 6 | awk '{printf "%-7s %-6s %s\n", $2, $4, $11}'
    echo ""
else
    echo "Использование памяти в норме (< $THRESHOLD%)."
fi

echo ""
echo "Мониторинг завершён."