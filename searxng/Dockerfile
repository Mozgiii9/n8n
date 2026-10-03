# Официальный образ зафиксирован по digest для воспроизводимых обновлений.
FROM ghcr.io/searxng/searxng@sha256:c642712fcedcdaa78fac44f71eada86aff510745826ba1bd1a368211fea2ce7f

COPY --chown=977:977 settings.yml /etc/searxng/settings.yml

ENV GRANIAN_HOST="::" \
    GRANIAN_PORT="8080" \
    GRANIAN_WORKERS="1"

EXPOSE 8080
