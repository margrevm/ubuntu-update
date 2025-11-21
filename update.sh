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
printf '\033[1;32m[Updating apt packages]\033[0m\n'

printf '\033[0;32m➜ Updating apt repositories...\033[0m\n'
sudo apt update -y

printf '\033[0;32m➜ Upgrading apt packages to their latest version...\033[0m\n'
# 'apt full-upgrade' is an enhanced version of the 'apt upgrade' command. 
# Apart from upgrading existing software packages, it installs and removes 
# some packages to satisfy some dependencies. The command includes a smart conflict 
# resolution feature that ensures that critical packages are upgraded first 
# at the expense of those considered of a lower priority.
# 'apt full-upgrade' is identical to 'apt dist-upgrade'.
# Using 'upgrade' is considered safer in an environment where stability is critical. 
sudo apt full-upgrade

printf '\033[0;32m➜ Removing unused apt package dependencies...\033[0m\n'
# ... packages that are not longer needed
# The --purge option is used to remove their system wide config files as well.
sudo apt autoremove --purge -y

printf '\033[0;32m➜ Cleaning package cache...\033[0m\n'
# 'apt autoclean' removes all stored archives in your cache for packages that can not 
# be downloaded anymore (thus packages that are no longer in the repo or that have a newer version in the repo).
# You can use 'apt clean' to remove all stored archives in your cache to safe even more disk space.
sudo du -sh /var/cache/apt #Shows the cache
sudo apt autoclean

# ---------------------------------------------------
# Snap package update
# ---------------------------------------------------
printf '\033[1;32m[Updating snap packages]\033[0m\n'

printf '\033[0;32m➜ Force upgrading snap packages to their latest version...\033[0m\n'
# ... even if this not strictly necessary as snapd does this automatically in the background according to its own schedule.
snap refresh

printf '\033[0;32m➜ Removing old snap packages\033[0m\n'
# This will remove unused snap packages (https://askubuntu.com/questions/1036633/how-to-remove-disabled-unused-snap-packages-with-a-single-line-of-command)
sudo snap list --all | while read snapname ver rev trk pub notes; do if [ $notes = *disabled* ]; then sudo snap remove "$snapname" --revision="$rev"; fi; done

printf '\033[0;32m➜ Cleaning snap cache\033[0m\n'
echo "Before: [$(sudo du -sh /var/lib/snapd/cache/)]"
sudo sh -c 'rm -rf /var/lib/snapd/cache/*'          # Remove cache
echo "After: [$(sudo du -sh /var/lib/snapd/cache/)]"

# ---------------------------------------------------
# flatpak package update
# ---------------------------------------------------
if command -v flatpak >/dev/null 2>&1; then
    # If flatpak is installed...
    printf '\033[0;32m[Updating flatpak packages]\033[0m\n'

    printf '\033[0;32m➜ Upgrading flatpak packages to their latest version...\033[0m\n'
    flatpak update

    printf '\033[0;32m➜ Remove unused flatpak packages...\033[0m\n'
    flatpak uninstall --unused
fi

# ---------------------------------------------------
# Other
# ---------------------------------------------------
printf '\033[1;32m[Updating other packages]\033[0m\n'

# If winetricks is installed...
if command -v winetricks >/dev/null 2>&1; then
    printf '\033[0;32m➜ Update winetricks\033[0m\n'
    sudo winetricks --self-update
fi

# If tailscale is installed...
if command -v tailscale >/dev/null 2>&1; then
    # After a release upgrade of Ubuntu the tailscale repository may be broken and 'apt-get update'
    # might not work anymore.
    # Reinstalling it using the install script from tailscale.com ensures that the latest
    # version compatible with the current Ubuntu version is installed.

    #printf '\033[0;32m➜ Update tailscale\033[0m\n'
    #curl -fsSL https://tailscale.com/install.sh | sh
fi