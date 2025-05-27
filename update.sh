#!/bin/bash

## Script to update packages from various sources and to upgrade Ubuntu OS
##
## Copyright (C) 2025 Mike Margreve (mike.margreve@outlook.com)
## Permission to copy and modify is granted under the foo license
##
## Usage: update [no arguments]

# ---------------------------------------------------
# APT package update
# ---------------------------------------------------
echo "[Updating apt packages]"

echo "➜ Updating apt repositories..."
sudo apt update -y

echo "➜ Upgrading apt packages to their latest version..."
# 'apt full-upgrade' is an enhanced version of the 'apt upgrade' command. 
# Apart from upgrading existing software packages, it installs and removes 
# some packages to satisfy some dependencies. The command includes a smart conflict 
# resolution feature that ensures that critical packages are upgraded first 
# at the expense of those considered of a lower priority.
# 'apt full-upgrade' is identical to 'apt dist-upgrade'.
# Using 'upgrade' is considered safer in an environment where stability is critical. 
sudo apt full-upgrade

echo "➜ Removing unused apt package dependencies..."
# ... packages that are not longer needed
# The --purge option is used to remove their system wide config files as well.
sudo apt autoremove --purge

echo "➜ Cleaning package cache..."
# 'apt autoclean' removes all stored archives in your cache for packages that can not 
# be downloaded anymore (thus packages that are no longer in the repo or that have a newer version in the repo).
# You can use 'apt clean' to remove all stored archives in your cache to safe even more disk space.
sudo apt autoclean

# ---------------------------------------------------
# Snap package update
# ---------------------------------------------------
echo "[Updating snap packages]"

echo "➜ Upgrading snap packages to their latest version..."
snap refresh

echo "➜ Removing old snap packages"
# This will remove unused snap packages (https://askubuntu.com/questions/1036633/how-to-remove-disabled-unused-snap-packages-with-a-single-line-of-command)
sudo snap list --all | while read snapname ver rev trk pub notes; do if [[ $notes = *disabled* ]]; then sudo snap remove "$snapname" --revision="$rev"; fi; done

echo "➜ Cleaning snap cache"
sudo du -sh /var/lib/snapd/cache/                  # Get used space
sudo find /var/lib/snapd/cache/ -exec rm -v {} \;  # Remove cache

# ---------------------------------------------------
# flatpak package update
# ---------------------------------------------------
if command -v flatpak >/dev/null 2>&1; then
    # If flatpak is installed...
    echo "[Updating flatpak packages]"

    echo "➜ Upgrading flatpak packages to their latest version..."
    flatpak update

    echo "➜ Remove unused flatpak packages..."
    flatpak uninstall --unused
fi

# ---------------------------------------------------
# Other
# ---------------------------------------------------
if command -v winetricks >/dev/null 2>&1; then
    # If installed...
    sudo winetricks --self-update
fi