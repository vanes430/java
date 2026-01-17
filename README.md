# Pterodactyl Java Docker Images
------------------------

Welcome! This repository provides **ready-to-use multi-architecture Docker images** (AMD64 & ARM64) tailored for [Pterodactyl](https://pterodactyl.io) environments. All images are available **for free** via GitHub Container Registry.

## 🔧 Available Java Images (Copy-Paste for Pterodactyl)
------------------------

### ☕ Adoptium JDK (Temurin)
````
Adoptium_Debian_21|ghcr.io/vanes430/java:adoptium_debian_21
Adoptium_Debian_25|ghcr.io/vanes430/java:adoptium_debian_25
Adoptium_Rocky_21|ghcr.io/vanes430/java:adoptium_rocky_21
Adoptium_Rocky_25|ghcr.io/vanes430/java:adoptium_rocky_25
````

### 🔔 BellSoft Liberica JDK
````
BellSoft_Debian_21|ghcr.io/vanes430/java:bellsoft_debian_21
BellSoft_Debian_25|ghcr.io/vanes430/java:bellsoft_debian_25
BellSoft_Rocky_21|ghcr.io/vanes430/java:bellsoft_rocky_21
BellSoft_Rocky_25|ghcr.io/vanes430/java:bellsoft_rocky_25
````

### 🟢 Amazon Corretto JDK
````
Corretto_Debian_21|ghcr.io/vanes430/java:corretto_debian_21
Corretto_Debian_25|ghcr.io/vanes430/java:corretto_debian_25
Corretto_Rocky_21|ghcr.io/vanes430/java:corretto_rocky_21
Corretto_Rocky_25|ghcr.io/vanes430/java:corretto_rocky_25
````

### 🧊 GraalVM EE (GraalEE)
````
GraalEE_Debian_21|ghcr.io/vanes430/java:graalee_debian_21
GraalEE_Debian_25|ghcr.io/vanes430/java:graalee_debian_25
GraalEE_Rocky_21|ghcr.io/vanes430/java:graalee_rocky_21
GraalEE_Rocky_25|ghcr.io/vanes430/java:graalee_rocky_25
````

### 💙 Azul Zulu JDK
````
Zulu_Debian_21|ghcr.io/vanes430/java:zulu_debian_21
Zulu_Debian_25|ghcr.io/vanes430/java:zulu_debian_25
Zulu_Rocky_21|ghcr.io/vanes430/java:zulu_rocky_21
Zulu_Rocky_25|ghcr.io/vanes430/java:zulu_rocky_25
````

## 🛠️ Build & Installation

This repository uses a template-based build system to generate version-specific Dockerfiles for multiple vendors.

### 1. Generate Dockerfiles
You can generate Dockerfiles for specific Java versions across all vendors using the master `install.sh` script.

```bash
# Make scripts executable
chmod +x install.sh && chmod +x */*.sh

# Generate for default versions (21 and 25)
./install.sh

# Generate for specific versions
./install.sh 8 11 17 21 25
```

Generated Dockerfiles will be located in the `target/` directory, named as `<vendor>_<os>_<version>.Dockerfile`.

### 2. Manual Installation
If you want to generate Dockerfiles for a specific vendor only:
```bash
cd adoptium
./adoptium_install.sh 21 25
```

## ✨ Features
- **Multi-Arch**: Native support for `x86_64` (AMD64) and `aarch64` (ARM64).
- **Modern Bases**: Uses `Debian Bookworm` and `Rocky Linux 9`.
- **Full UTF-8**: Correct emoji and special character display.
- **Dynamic Downloads**: Always fetches the latest patch version directly from vendors.

## ⚙️ Environment Variables

You can customize the container's appearance using these environment variables:

| Variable | Description | Default Value |
|----------|-------------|---------------|
| `PREFIX_DOCKER` | Custom text prefix for the terminal prompt. | `container@pterodactyl~ ` |
| `PREFIX_COLOR` | ANSI color code for the prompt prefix. | `\033[1m\033[33m` (Bold Yellow) |
| `TZ` | Container timezone. | `UTC` |