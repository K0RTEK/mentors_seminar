# FastAPI Домашнее задание

Два микросервиса на FastAPI:
- **TODO-сервис** — управление задачами (создание, просмотр, обновление, удаление).
- **Short URL-сервис** — сокращение ссылок и редирект по короткому ID.

Данные хранятся в SQLite и сохраняются между перезапусками контейнеров.

---

## Запуск через Docker

1. Создайте тома для данных:
   ```bash
   docker volume create todo_data
   docker volume create shorturl_data
   ```

2. Соберите образы:
   ```bash
   docker build -t todo-service todo_app/
   docker build -t shorturl-service shorturl_app/
   ```

3. Запустите сервисы:
   ```bash
   docker run -d -p 8000:80 -v todo_/app/data todo-service
   docker run -d -p 8001:80 -v shorturl_/app/data shorturl-service
   ```

4. Проверьте:
   - TODO: `curl http://localhost:8000/items`
   - Short URL: `curl http://localhost:8001/shorten -H "Content-Type: application/json" -d '{"url":"https://example.com"}'`

