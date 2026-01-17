# Pterodactyl Image created by vanes430
FROM --platform=$TARGETOS/$TARGETARCH rockylinux:9-minimal

ARG TARGETARCH
ARG JAVA_VERSION=21
ARG DOWNLOAD_URL_X64
ARG DOWNLOAD_URL_ARM64

LABEL author="vanes430" maintainer="admin@vanes430.my.id"
LABEL org.opencontainers.image.source="https://github.com/vanes430/java"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.description="Multi-version GraalVM Image (Rocky Linux)"

RUN microdnf install -y bsdtar curl jq ca-certificates shadow-utils tar gzip glibc-langpack-en && \
    microdnf clean all

RUN set -e; \
    if [ "$TARGETARCH" = "amd64" ]; then \
        URL=$DOWNLOAD_URL_X64; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        URL=$DOWNLOAD_URL_ARM64; \
    else \
        URL=$DOWNLOAD_URL_X64; \
    fi; \
    curl -fL -o /tmp/graalvm.tar.gz "${URL}" && \
    mkdir -p /opt/java/graalvm && \
    bsdtar -xf /tmp/*.tar.gz -C /opt/java/graalvm --strip-components 1 && \
    chmod -R +rX /opt/java && \
    rm /tmp/graalvm.tar.gz

RUN useradd -m -d /home/container container

ENV JAVA_HOME=/opt/java/graalvm
ENV PATH="/opt/java/graalvm/bin:${PATH}"
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
