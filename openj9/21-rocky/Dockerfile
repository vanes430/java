#██╗   ██╗ █████╗ ███╗   ██╗███████╗███████╗██╗  ██╗██████╗  ██████╗ 
#██║   ██║██╔══██╗████╗  ██║██╔════╝██╔════╝██║  ██║╚════██╗██╔═████╗
#██║   ██║███████║██╔██╗ ██║█████╗  ███████╗███████║ █████╔╝██║██╔██║
#╚██╗ ██╔╝██╔══██║██║╚██╗██║██╔══╝  ╚════██║╚════██║ ╚═══██╗████╔╝██║
# ╚████╔╝ ██║  ██║██║ ╚████║███████╗███████║     ██║██████╔╝╚██████╔╝
#  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝     ╚═╝╚═════╝  ╚═════╝ 
# Pterodactyl Image created by vanes430
FROM --platform=$TARGETOS/$TARGETARCH rockylinux:9-minimal

LABEL author="vanes430" maintainer="admin@vanes430.my.id"
LABEL org.opencontainers.image.source="https://github.com/vanes430/java"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.description="Pterodactyl Image created by vanes430"

RUN microdnf install -y \
    openssl \
    shadow-utils \
    glibc-langpack-en \
    ca-certificates \
    alsa-lib \
    fontconfig \
    freetype \
    libX11 \
    libXext \
    libXi \
    libXrender \
    libXtst && \
    rpm --install https://github.com/ibmruntimes/semeru21-binaries/releases/download/jdk-21.0.8%2B9_openj9-0.53.0/ibm-semeru-open-21-jdk-21.0.8.9_0.53.0-1.x86_64.rpm && \
    microdnf clean all

RUN useradd -m -d /home/container container

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/ibm-semeru-open-21-jdk
ENV PATH="$JAVA_HOME/bin:$PATH"

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint /entrypoint
CMD [ "/entrypoint" ]