#!/bin/bash

# Get versions from arguments, or use defaults
VERSIONS=($@)
if [ ${#VERSIONS[@]} -eq 0 ]; then
    VERSIONS=(21 25)
fi

mkdir -p ../target

for VERSION in "${VERSIONS[@]}"; do
    echo "--- Generating URLs for Amazon Corretto Java ${VERSION} ---"
    URL_X64="https://corretto.aws/downloads/latest/amazon-corretto-${VERSION}-x64-linux-jdk.tar.gz"
    URL_ARM64="https://corretto.aws/downloads/latest/amazon-corretto-${VERSION}-aarch64-linux-jdk.tar.gz"

    # Debian
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        corretto_debian.Dockerfile > "../target/corretto_debian_${VERSION}.Dockerfile"
    echo "Generated target/corretto_debian_${VERSION}.Dockerfile"

    # Rocky
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        corretto_rocky.Dockerfile > "../target/corretto_rocky_${VERSION}.Dockerfile"
    echo "Generated target/corretto_rocky_${VERSION}.Dockerfile"
done
