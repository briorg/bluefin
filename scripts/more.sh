#!/bin/sh

wget 'https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage' -Lo /usr/bin/nvim.appimage
#wget 'https://download.beeper.com/linux/appImage/x64' -Lo /usr/bin/beeper.appimage
#

## install discord
curl -L 'https://discord.com/api/download?platform=linux&format=tar.gz' | tar -xzvC /usr/lib
cp /usr/lib/Discord/discord.desktop /usr/share/applications/