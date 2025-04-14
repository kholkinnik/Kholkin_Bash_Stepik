#АНАЛИЗ ЛОГОВ
# Указываю где файл, где буду хранить отчет
file="report.txt"

# Создаю файл, если он не существует
> $file

#Считаю количество строк без AWK, с  awk 'END {print NR}' access.log
count=0
while read -r line; do
       count=$((count + 1))
done < access.log

#Формирование отчета по образцу
{
echo "Отчет о логе веб-сервера"
echo "=========================================="
echo "Общее количество запросов:  $count"
echo "Количество уникальных IP адресов: $(awk '{print $1}' access.log | sort | uniq | wc -l)"
echo ""
echo "Количество запросов по методам"
awk '{print $6}' access.log |tr -d '"'| sort | uniq -c 
echo ""
echo "Самый популярный:  $(awk '{print $7}' access.log | sort | uniq -c | sort -nr | head -1)"
} >> $file
echo "Отчет сохранен в файл report.txt"
