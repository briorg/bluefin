#!/bin/bash

wget 'https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage' -Lo /usr/bin/nvim.appimage
#wget 'https://download.beeper.com/linux/appImage/x64' -Lo /usr/bin/beeper.appimage
#

## install discord
curl -L 'https://discord.com/api/download?platform=linux&format=tar.gz' | tar -xzvC /usr/lib
cp /usr/lib/Discord/discord.desktop /usr/share/applications/
mkdir /usr/share/discord
cat > /usr/share/discord/Discord <<EOF
#!/bin/bash
exec /usr/lib/Discord/Discord    --enable-features=UseOzonePlatform --ozone-platform=wayland --no-sandbox --enable-features=WaylandWindowDecorations "${@}"
EOF