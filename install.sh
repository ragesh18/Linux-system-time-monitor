#!/usr/bin/env bash
# Installation script for Linux Screen Time

set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="stmon"

echo "Installing $SCRIPT_NAME to $INSTALL_DIR..."

if [ ! -f "stmon.sh" ]; then
    echo "Error: stmon.sh not found in the current directory."
    exit 1
fi

# Need sudo if not root
if [ "$EUID" -ne 0 ]; then
    echo "Requesting administrative privileges to copy to $INSTALL_DIR..."
    sudo cp "stmon.sh" "$INSTALL_DIR/$SCRIPT_NAME"
    sudo chmod +x "$INSTALL_DIR/$SCRIPT_NAME"
else
    cp "rexM.sh" "$INSTALL_DIR/$SCRIPT_NAME"
    chmod +x "$INSTALL_DIR/$SCRIPT_NAME"
fi

echo "Installation complete!"
echo "You can now run '$SCRIPT_NAME' from your terminal."
