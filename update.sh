#!/bin/bash

## Script to update packages from various sources and to upgrade Ubuntu OS
##
## Copyright (C) 2025 Mike Margreve (mike.margreve@outlook.com)
## Permission to copy and modify is granted under the foo license
##
## Usage: update [no arguments]

# ---------------------------------------------------
# APT package installation
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

