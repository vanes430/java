#██╗   ██╗ █████╗ ███╗   ██╗███████╗███████╗██╗  ██╗██████╗  ██████╗ 
#██║   ██║██╔══██╗████╗  ██║██╔════╝██╔════╝██║  ██║╚════██╗██╔═████╗
#██║   ██║███████║██╔██╗ ██║█████╗  ███████╗███████║ █████╔╝██║██╔██║
#╚██╗ ██╔╝██╔══██║██║╚██╗██║██╔══╝  ╚════██║╚════██║ ╚═══██╗████╔╝██║
# ╚████╔╝ ██║  ██║██║ ╚████║███████╗███████║     ██║██████╔╝╚██████╔╝
#  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝     ╚═╝╚═════╝  ╚═════╝ 
# Pterodactyl Image created by vanes430
FROM --platform=$TARGETOS/$TARGETARCH debian:bookworm-slim

LABEL author="vanes430" maintainer="admin@vanes430.my.id"
LABEL org.opencontainers.image.source="https://github.com/vanes430/java"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.description="Pterodactyl Image with Amazon Corretto 17"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    curl \
    ca-certificates \
    openssl \
    passwd \
    gnupg \
    && wget https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.deb -O /tmp/corretto.deb \
    && apt-get install -y /tmp/corretto.deb \
    && rm -rf /var/lib/apt/lists/* /tmp/corretto.deb

RUN useradd -m -d /home/container container

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto
ENV PATH="$JAVA_HOME/bin:$PATH"

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint /entrypoint
CMD [ "/entrypoint" ]