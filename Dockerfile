FROM ghcr.io/n8n-io/n8n:1.123.46
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg curl \
    && rm -rf /var/lib/apt/lists/*           # чистим кэш apt, чтобы не раздувать слой

RUN chown -R node:node /home/node/.n8n
USER node
