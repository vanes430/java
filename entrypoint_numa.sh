#!/bin/bash

TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Set the prompt prefix and color
PREFIX_DOCKER=${PREFIX_DOCKER:-"container@pterodactyl~ "}
PREFIX_COLOR=${PREFIX_COLOR:-"\033[1m\033[33m"}

# Print NUMA status
printf "%b%s\033[0mnumactl --show\n" "$PREFIX_COLOR" "$PREFIX_DOCKER"
numactl --show

# Print Java version
printf "%b%s\033[0mjava -version\n" "$PREFIX_COLOR" "$PREFIX_DOCKER"
java -version

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\n%b%s\033[0mauthor\n" "$PREFIX_COLOR" "$PREFIX_DOCKER"
printf "\033[1m\033[34m--- Image Build Info ---\033[0m\n"
printf "Author  : vanes430\n"
printf "GitHub  : https://github.com/vanes430/java\n"
printf "Note    : Support this project by leaving a star on GitHub! 🌟\n"
printf "\033[1m\033[34m------------------------\033[0m\n\n"

printf "%b%s\033[0m%s\n" "$PREFIX_COLOR" "$PREFIX_DOCKER" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}
