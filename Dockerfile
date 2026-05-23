FROM docker.n8n.io/n8nio/n8n:1.123.46
USER root
RUN apk add --no-cache ffmpeg curl
RUN chown -R node:node /home/node/.n8n
USER node
