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

RUN microdnf install -y openssl shadow-utils glibc-langpack-en \
    && rpm --install https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm \
    && microdnf install -y zulu21-jdk \
    && useradd -m -d /home/container container \
    && microdnf clean all


ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/zulu21-ca

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../../entrypoint /entrypoint
CMD [ "/entrypoint" ]
