#!/bin/bash

# Get versions from arguments, or use defaults
VERSIONS=($@)
if [ ${#VERSIONS[@]} -eq 0 ]; then
    VERSIONS=(21 25)
fi

mkdir -p ../target

for VERSION in "${VERSIONS[@]}"; do
    echo "--- Fetching URLs for BellSoft Java ${VERSION} ---"
    URL_X64=$(curl -s "https://api.bell-sw.com/v1/liberica/releases?version-feature=${VERSION}&os=linux&arch=x86&bitness=64&package-type=tar.gz&bundle-type=jdk" | jq -r ".[] | select(.latestInFeatureVersion == true) | .downloadUrl")
    URL_ARM64=$(curl -s "https://api.bell-sw.com/v1/liberica/releases?version-feature=${VERSION}&os=linux&arch=arm&bitness=64&package-type=tar.gz&bundle-type=jdk" | jq -r ".[] | select(.latestInFeatureVersion == true) | .downloadUrl")

    if [ -z "$URL_X64" ] || [ "$URL_X64" = "null" ]; then echo "Warning: Could not find x64 URL for version ${VERSION}"; fi
    if [ -z "$URL_ARM64" ] || [ "$URL_ARM64" = "null" ]; then echo "Warning: Could not find arm64 URL for version ${VERSION}"; fi

    # Debian
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        bellsoft_debian.Dockerfile > "../target/bellsoft_debian_${VERSION}.Dockerfile"
    echo "Generated target/bellsoft_debian_${VERSION}.Dockerfile"

    # Rocky
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        bellsoft_rocky.Dockerfile > "../target/bellsoft_rocky_${VERSION}.Dockerfile"
    echo "Generated target/bellsoft_rocky_${VERSION}.Dockerfile"
done
