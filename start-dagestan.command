#!/bin/bash

# Переход в папку, где лежит сам этот файл
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

echo "Запуск проекта Dagestan..."
echo "---------------------------------------"

PORT=8080
URL="http://127.0.0.1:${PORT}/indexD.html"

# Запускаем простой локальный сервер
python3 -m http.server "$PORT" --bind 127.0.0.1 >/tmp/dagestan-localhost.log 2>&1 &
SERVER_PID=$!

# Даем серверу время подняться
sleep 2

# Открываем сайт в браузере
open "$URL"

echo "Сайт открыт: $URL"
echo "Логи сервера: /tmp/dagestan-localhost.log"
echo "Закрыть сервер: CTRL + C в этом окне"
echo "---------------------------------------"

trap 'kill $SERVER_PID 2>/dev/null' EXIT
wait $SERVER_PID