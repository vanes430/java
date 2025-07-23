#██╗   ██╗ █████╗ ███╗   ██╗███████╗███████╗██╗  ██╗██████╗  ██████╗ 
#██║   ██║██╔══██╗████╗  ██║██╔════╝██╔════╝██║  ██║╚════██╗██╔═████╗
#██║   ██║███████║██╔██╗ ██║█████╗  ███████╗███████║ █████╔╝██║██╔██║
#╚██╗ ██╔╝██╔══██║██║╚██╗██║██╔══╝  ╚════██║╚════██║ ╚═══██╗████╔╝██║
# ╚████╔╝ ██║  ██║██║ ╚████║███████╗███████║     ██║██████╔╝╚██████╔╝
#  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝     ╚═╝╚═════╝  ╚═════╝ 
# Pterodactyl Image created by vanes430
FROM --platform=$TARGETOS/$TARGETARCH bellsoft/liberica-openjdk-rocky:17

LABEL author="vanes430" maintainer="admin@vanes430.my.id"
LABEL org.opencontainers.image.source="https://github.com/vanes430/java"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.description="Pterodactyl Image created by vanes430"

RUN microdnf update -y && microdnf install -y \
    openssl passwd glibc-langpack-en \
    && useradd -m -d /home/container container \
    && microdnf clean all

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint /entrypoint
CMD [ "/entrypoint" ]