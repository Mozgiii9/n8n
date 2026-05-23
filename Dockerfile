# Файл: Dockerfile

FROM ghcr.io/n8n-io/n8n:1.123.46
USER root

# Диагностика: выведет дистрибутив и какой пакетный менеджер реально есть.
# Видно будет в логах билда Railway. Можно удалить после успешной сборки.
RUN cat /etc/os-release || true; command -v apk apt-get apk-tools 2>/dev/null || true

# Возврат к apk (база n8n — Alpine). apt-get на Alpine отсутствует → отсюда был exit 127.
RUN apk add --no-cache ffmpeg curl

RUN chown -R node:node /home/node/.n8n
USER node
