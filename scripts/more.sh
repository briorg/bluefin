#!/bin/bash

wget 'https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage' -Lo /usr/bin/nvim.appimage
#wget 'https://download.beeper.com/linux/appImage/x64' -Lo /usr/bin/beeper.appimage

# # Dynamically create the required groups via sysusers.d
# # and set the GID based on the files we just chgrp'd
# tail /usr/lib/sysusers.d/onepassword.conf <<EOF
# g onepassword ${GID_ONEPASSWORD}
# EOF
# tail /usr/lib/sysusers.d/onepassword-cli.conf <<EOF
# g onepassword-cli ${GID_ONEPASSWORDCLI}
# EOF


# install thorium browser
rpm-ostree install $(curl -s https://api.github.com/repos/Alex313031/thorium/releases/latest  | \
 jq -r '.assets[] | select(.name | contains ("rpm")) | .browser_download_url')

tail /usr/lib/tmpfiles.d/onepassword.conf <<'EOF'
#L  /opt/1Password                           -     -  -            -  /usr/lib/1Password
C+  /run/1Password                           -     -  -            -  /usr/lib/1Password
L   /opt/1Password                           -     -  -            -  /run/1Password
z   /run/1Password/1Password-BrowserSupport  2755  -  onepassword  -  -
z   /run/1Password/chrome-sandbox            4755  -  onepassword  -  -
EOF

