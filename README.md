# ubuntu-update

Maintenance script to update/upgrade Ubuntu software packages and OS. Feel free to fork and tailor it according to your own needs.

## Features

- 📦 Supports snap, flatpak and apt package upgrades;
- 🗑️ Cleaning unnecessary/old packages, cache and files.

This script will not upgrade to a newer Ubuntu version. Run ```sudo do-release-upgrade``` for this purpose.

## Running the script

The first thing I do on a clean installation...

```sh
chmod +x update.sh
./update.sh
```

## Supported versions

- Ubuntu 25.04

## Credits

By Mike Margreve (mike.margreve@outlook.com) and licensed under MIT. The original source can be found here: https://github.com/margrevm/ubuntu-update