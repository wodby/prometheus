ARG PROM_VER
ARG BASE_IMAGE_TAG

FROM prom/prometheus:${PROM_VER}

FROM wodby/alpine:${BASE_IMAGE_TAG}

ENV PROM_VER="${PROM_VER}"

COPY --from=0 /bin/prometheus                           /usr/local/bin/
COPY --from=0 /bin/promtool                             /usr/local/bin/
COPY --from=0 /etc/prometheus/prometheus.yml            /etc/prometheus/prometheus.yaml
COPY --from=0 /usr/share/prometheus/console_libraries/  /usr/share/prometheus/console_libraries/
COPY --from=0 /usr/share/prometheus/consoles/           /usr/share/prometheus/consoles/

COPY docker-entrypoint.sh /

RUN set -ex; \
    addgroup -S prom; \
    adduser -S -D -H -h /home/prom -s /sbin/nologin -G prom prom; \
    \
    apk add --update --no-cache sudo; \
    \
    chmod +x /docker-entrypoint.sh; \
    \
    mkdir -p \
        /etc/prometheus \
        /var/lib/prometheus \
        /mnt/config; \
    \
    chown -R prom:prom \
        /etc/prometheus \
        /usr/local/bin/prometheus \
        /usr/local/bin/promtool \
        /var/lib/prometheus \
        /mnt/config; \
    \
    echo "chown prom:prom /var/lib/prometheus /mnt/config" > /usr/local/bin/init_volumes; \
    chmod +x /usr/local/bin/init_volumes; \
    { \
        echo -n 'prom ALL=(root) NOPASSWD:SETENV: '; \
        echo '/usr/local/bin/init_volumes'; \
    } | tee /etc/sudoers.d/prom; \
    \
    rm -rf \
        /tmp/* \
        /var/cache/apk/*

USER prom

EXPOSE 9090
WORKDIR /home/prom

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/prometheus", "--config.file=/etc/prometheus/prometheus.yaml", "--storage.tsdb.path=/var/lib/prometheus", "--web.console.libraries=/usr/share/prometheus/console_libraries", "--web.console.templates=/usr/share/prometheus/consoles"]