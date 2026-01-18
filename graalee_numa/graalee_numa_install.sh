#!/bin/bash

# Get versions from arguments, or use defaults
VERSIONS=($@)
if [ ${#VERSIONS[@]} -eq 0 ]; then
    VERSIONS=(21 25)
fi

mkdir -p ../target

for VERSION in "${VERSIONS[@]}"; do
    echo "--- Generating URLs for GraalVM Java ${VERSION} ---"
    URL_X64="https://download.oracle.com/graalvm/${VERSION}/latest/graalvm-jdk-${VERSION}_linux-x64_bin.tar.gz"
    URL_ARM64="https://download.oracle.com/graalvm/${VERSION}/latest/graalvm-jdk-${VERSION}_linux-aarch64_bin.tar.gz"

    # Debian
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        graalee_numa_debian.Dockerfile > "../target/graalee_numa_debian_${VERSION}.Dockerfile"
    echo "Generated target/graalee_numa_debian_${VERSION}.Dockerfile"

    # Rocky
    sed -e "s|ARG JAVA_VERSION=21|ARG JAVA_VERSION=${VERSION}|" \
        -e "s|ARG DOWNLOAD_URL_X64|ARG DOWNLOAD_URL_X64=${URL_X64}|" \
        -e "s|ARG DOWNLOAD_URL_ARM64|ARG DOWNLOAD_URL_ARM64=${URL_ARM64}|" \
        graalee_numa_rocky.Dockerfile > "../target/graalee_numa_rocky_${VERSION}.Dockerfile"
    echo "Generated target/graalee_numa_rocky_${VERSION}.Dockerfile"
done
