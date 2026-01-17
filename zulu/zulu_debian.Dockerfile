# Pterodactyl Image created by vanes430
FROM --platform=$TARGETOS/$TARGETARCH debian:bookworm-slim

ARG TARGETARCH
ARG JAVA_VERSION=21
ARG DOWNLOAD_URL_X64
ARG DOWNLOAD_URL_ARM64

LABEL author="vanes430" maintainer="admin@vanes430.my.id"
LABEL org.opencontainers.image.source="https://github.com/vanes430/java"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.description="Multi-version Azul Zulu Image (Debian)"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl jq ca-certificates openssl passwd locales iproute2 tar && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN set -e; \
    if [ "$TARGETARCH" = "amd64" ]; then \
        URL=$DOWNLOAD_URL_X64; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        URL=$DOWNLOAD_URL_ARM64; \
    else \
        URL=$DOWNLOAD_URL_X64; \
    fi; \
    curl -fL -o /tmp/zulu.tar.gz "${URL}" && \
    mkdir -p /opt/java/zulu && \
    tar -xzf /tmp/zulu.tar.gz -C /opt/java/zulu --strip-components=1 --no-same-owner --no-same-permissions --no-xattrs --no-selinux --no-acl && \
    chmod -R +rX /opt/java && \
    rm /tmp/zulu.tar.gz

RUN useradd -m -d /home/container container

ENV JAVA_HOME=/opt/java/zulu
ENV PATH="/opt/java/zulu/bin:${PATH}"
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
