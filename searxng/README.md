# Приватный поиск для n8n Assistant

SearXNG работает отдельным сервисом `searxng` в окружении `production` того же проекта Railway, что и n8n.

## Конфигурация

- Официальный образ SearXNG `2026.10.2-19ffbcd30` зафиксирован по digest в `Dockerfile`.
- Включены HTML и JSON API; сервер слушает IPv6 и IPv4 на порту 8080.
- Один процесс Granian; лимиты сервиса в Railway: 1 vCPU и 1 ГБ RAM.
- Healthcheck: `/healthz`; перезапуск при сбое; автоматическое засыпание отключено.
- Публичных доменов и TCP-прокси нет. Доступ только из внутренней сети проекта.
- Активный поисковик: Yahoo. При проверке 04.10.2026 он возвращал релевантные результаты на русском и английском. Google, DuckDuckGo, Brave и Qwant ограничивали запросы с адреса Railway; Bing возвращал нерелевантную выдачу для части запросов.
- Redis/Valkey и отдельный том не требуются: защита публичного экземпляра и лимитер отключены, настройки включены в образ. Сервис не хранит пользовательские данные.

Переменные сервиса SearXNG в Railway:

```dotenv
PORT=8080
SEARXNG_SECRET=<случайный секрет; хранится только в Railway>
```

Переменная сервиса n8n:

```dotenv
N8N_INSTANCE_AI_SEARXNG_URL=http://searxng.railway.internal:8080
```

## Обновление

Источник сервиса — этот GitHub-репозиторий, ветка `main`, Root Directory `/searxng`, файл конфигурации `/searxng/railway.toml`. Изменения отслеживаются в `/searxng/**`.

При обновлении сначала замените digest официального образа в `Dockerfile`. После развертывания проверьте `/healthz` и `/search?q=n8n&format=json` из контейнера n8n, затем штатный клиент SearXNG Assistant. Ответ HTTP 200 без релевантных результатов не считается успешной проверкой.

Поисковики могут менять ограничения для IP-адресов дата-центров. Если выдача перестала работать, проверьте поле `unresponsive_engines` JSON-ответа и протестируйте другой движок перед включением в `settings.yml`.

Официальная документация: [контейнер SearXNG](https://docs.searxng.org/admin/installation-docker.html), [настройки поиска](https://docs.searxng.org/admin/settings/settings_search.html), [Assistant n8n](https://docs.n8n.io/deploy/host-n8n/configure-n8n/set-up-n8n-assistant).
