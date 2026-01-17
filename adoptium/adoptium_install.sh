#!/bin/bash

# Get versions from arguments, or use defaults
VERSIONS=($@)
if [ ${#VERSIONS[@]} -eq 0 ]; then
    VERSIONS=(21 25)
fi

mkdir -p ../target

for VERSION in "${VERSIONS[@]}"; do
    echo "--- Fetching URLs for Adoptium Java ${VERSION} ---"
    URL_X64=$(curl -s "https://api.adoptium.net/v3/assets/latest/${VERSION}/hotspot?architecture=x64&image_type=jdk&os=linux&vendor=eclipse" | jq -r '.[0].binary.package.link')
    URL_ARM64=$(curl -s "https://api.adoptium.net/v3/assets/latest/${VERSION}/hotspot?architecture=aarch64&image_type=jdk&os=linux&vendor=eclipse" | jq -r '.[0].binary.package.link')

    if [ -z "$URL_X64" ] || [ "$URL_X64" = "null" ]; then echo "Warning: Could not find x64 URL for version ${VERSION}"; fi
    if [ -z "$URL_ARM64" ] || [ "$URL_ARM64" = "null" ]; then echo "Warning: Could not find arm64 URL for version ${VERSION}"; fi

    # Debian
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        adoptium_debian.Dockerfile > "../target/adoptium_debian_${VERSION}.Dockerfile"
    echo "Generated target/adoptium_debian_${VERSION}.Dockerfile"

    # Rocky
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        adoptium_rocky.Dockerfile > "../target/adoptium_rocky_${VERSION}.Dockerfile"
    echo "Generated target/adoptium_rocky_${VERSION}.Dockerfile"
done
