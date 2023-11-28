#!/bin/bash
# This font is not free or open-source, so I'm hiding the script to download the zip in gh secrets.
# Sorry... I don't want to get in trouble.
#
# To run this locally, you should have a /tmp/pragmatapro.zip

set -euxo pipefail

mkdir /usr/share/fonts/pragmatapro -p
cd /usr/share/fonts/pragmatapro
unzip /tmp/pragmatapro.zip
fc-cache -f "${PWD}"