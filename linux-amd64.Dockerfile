ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_AMD64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_AMD64}
EXPOSE 4545
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="4545/tcp,4545/udp"

RUN apk add --no-cache icu-libs icu-data-full

ARG VERSION
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://github.com/thomst08/requestrr/releases/download/V${VERSION}/requestrr-linux-musl-x64.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chown -R hotio:hotio "${APP_DIR}" && \
    rmdir "${APP_DIR}/bin/config" && \
    ln -s "${CONFIG_DIR}" "${APP_DIR}/bin/config"

COPY root/ /
