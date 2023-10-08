#!/usr/bin/env sh

set -e

echo "Installing 1Password"
#cd /usr/lib
#wget -qO- https://downloads.1password.com/linux/tar/stable/x86_64/1password-latest.tar.gz | tar -zxv
#ln -s 1Password 1password-*

mkdir /var/opt # temporary storage, will not end up in ostree
rpm-ostree install https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm

mv /var/opt/1Password /usr/lib/1Password

#create symlink /usr/bin/1password pointing to /opt/1Password/1password
ln -s /opt/1Password/1password /usr/bin/1password

# hacked from 1password-latest.tar.gz//after-install.sh

# chrome-sandbox requires the setuid bit to be specifically set.
# See https://github.com/electron/electron/issues/17972
chmod 4755 ./chrome-sandbox

GROUP_NAME="onepassword"
GID_OP="1500"
GID_OPCLI="1600"

# Setup the Core App Integration helper binary with the correct permissions and group
# if [ ! "$(getent group "${GROUP_NAME}")" ]; then
#   # GID must be > 1000, and I'd prefer GID > highest user GID
#   groupadd -K GID_MIN=1500 "${GROUP_NAME}"
# fi

HELPER_PATH="./1Password-KeyringHelper"
BROWSER_SUPPORT_PATH="./1Password-BrowserSupport"

chgrp "${GID_OP}" $HELPER_PATH
# The binary requires setuid so it may interact with the Kernel keyring facilities
chmod u+s $HELPER_PATH
chmod g+s $HELPER_PATH

# This gives no extra permissions to the binary. It only hardens it against environmental tampering.
chgrp "${GROUP_NAME}" $BROWSER_SUPPORT_PATH
chmod g+s $BROWSER_SUPPORT_PATH

# Restore previous directory
cd "$CWD"

# Register path symlink
ln -s /usr/lib/1Password /opt/1Password
EOF
chmod +x /usr/bin/install-1password

# Then we install the 1password CLI binary as well

cd "$(mktemp -d)"
wget -q https://cache.agilebits.com/dist/1P/op2/pkg/v2.14.0/op_linux_amd64_v2.14.0.zip
unzip op_linux_amd64_v2.14.0.zip

mv op /usr/bin

groupadd -g ${GID_OPCLI} onepassword-cli
chown root:onepassword-cli /usr/bin/op
chmod g+s /usr/bin/op

op --version
