#!/bin/bash

# Master install script
# Usage: ./install.sh 21 25

# Capture all arguments as versions
VERSIONS=($@)

# Loop through each vendor directory
for vendor in adoptium bellsoft corretto graalee zulu graalee_numa; do
    if [ -f "$vendor/${vendor}_install.sh" ]; then
        echo "--- Processing $vendor ---"
        cd "$vendor" || continue
        # Pass version arguments to the vendor-specific install script
        chmod +x ${vendor}_install.sh
        ./${vendor}_install.sh "${VERSIONS[@]}"
        cd ..
    fi
done

echo -e "\nAll Dockerfiles have been generated in the 'target/' folder."