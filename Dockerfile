# Файл: Dockerfile

# Стадия сборки: обычный Alpine с apk, тут собираем нужные бинарники
FROM alpine:3.22 AS deps
RUN apk add --no-cache ffmpeg curl

# Финальный образ: hardened n8n, пакетный менеджер недоступен — поэтому копируем готовое
FROM ghcr.io/n8n-io/n8n:2.41.6
USER root

# Копируем ffmpeg, curl и их разделяемые библиотеки из стадии deps.
# ВНИМАНИЕ: список .so зависит от сборки; ниже базовый набор, может потребоваться дополнить.
COPY --from=deps /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=deps /usr/bin/curl   /usr/bin/curl
COPY --from=deps /usr/lib/        /usr/lib/

RUN chown -R node:node /home/node/.n8n
USER node
