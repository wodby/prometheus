ARG PROMETHEUS_VER=3.13.0

#--------------------------------------------------------------
FROM prom/prometheus:v${PROMETHEUS_VER} AS prom_orig

#--------------------------------------------------------------
FROM wodby/alpine:3.24

ARG PROMETHEUS_VER

ENV PROMETHEUS_VER="${PROMETHEUS_VER}"

COPY --from=prom_orig /bin/prometheus                           /usr/local/bin/
COPY --from=prom_orig /bin/promtool                             /usr/local/bin/
COPY docker-entrypoint.sh /
COPY ./bin/ /usr/local/bin/
COPY ./templates/ /etc/gotpl/

RUN set -ex; \
    addgroup -S prom; \
    adduser -S -D -H -h /home/prom -s /sbin/nologin -G prom prom; \
    \
    apk add --update --no-cache sudo; \
    \
    mkdir -p /etc/prometheus /var/lib/prometheus; \
    chown -R prom:prom /etc/prometheus /var/lib/prometheus; \
    \
    chmod +x /docker-entrypoint.sh \
        /usr/local/bin/init_volumes \
        /usr/local/bin/init_scripts; \
    \
    { \
        echo -n 'prom ALL=(root) NOPASSWD:SETENV: '; \
        echo -n '/usr/local/bin/init_volumes, '; \
        echo '/usr/local/bin/init_scripts'; \
    } | tee /etc/sudoers.d/prom; \
    \
    rm -rf \
        /tmp/* \
        /var/cache/apk/*

USER prom

VOLUME /var/lib/prometheus
WORKDIR /home/prom

EXPOSE 9090

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/prometheus-init"]
