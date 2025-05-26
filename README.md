[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# ubuntu-update

Script to update/upgrade Ubuntu software packages and OS. Feel free to fork and tailor it according to your own needs.

## Features

- 📦 Supports snap, .deb and apt package update;
- 🗑️ Cleaning unnecessary packages, cache and files.

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