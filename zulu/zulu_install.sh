#!/bin/bash

# Get versions from arguments, or use defaults
VERSIONS=($@)
if [ ${#VERSIONS[@]} -eq 0 ]; then
    VERSIONS=(21 25)
fi

mkdir -p ../target

for VERSION in "${VERSIONS[@]}"; do
    echo "--- Fetching URLs for Azul Zulu Java ${VERSION} ---"
    URL_X64=$(curl -fsSL "https://api.azul.com/zulu/download/community/v1.0/bundles/latest/?java_version=${VERSION}&os=linux&arch=x86&hw_bitness=64&bundle_type=jdk&ext=tar.gz" | jq -r ".url")
    URL_ARM64=$(curl -fsSL "https://api.azul.com/zulu/download/community/v1.0/bundles/latest/?java_version=${VERSION}&os=linux&arch=arm&hw_bitness=64&bundle_type=jdk&ext=tar.gz" | jq -r ".url")

    if [ -z "$URL_X64" ] || [ "$URL_X64" = "null" ]; then echo "Warning: Could not find x64 URL for version ${VERSION}"; fi
    if [ -z "$URL_ARM64" ] || [ "$URL_ARM64" = "null" ]; then echo "Warning: Could not find arm64 URL for version ${VERSION}"; fi

    # Debian
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        zulu_debian.Dockerfile > "../target/zulu_debian_${VERSION}.Dockerfile"
    echo "Generated target/zulu_debian_${VERSION}.Dockerfile"

    # Rocky
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        zulu_rocky.Dockerfile > "../target/zulu_rocky_${VERSION}.Dockerfile"
    echo "Generated target/zulu_rocky_${VERSION}.Dockerfile"
done
