#!/bin/bash
BASEPATH="$(dirname "$(readlink -f "$0")")"
echo "$BASEPATH"
cd "$BASEPATH"
pacman -S ffmpeg  --noconfirm --needed
pip install -r requirements.txt
ln -sf "$BASEPATH/bootlab-tx@.service" /etc/systemd/system/
ln -sf "$BASEPATH/bootlab-tx" /usr/local/bin/
ln -sf "$BASEPATH/bootlab-rx@.service" /etc/systemd/system/
ln -sf "$BASEPATH/bootlab-rx" /usr/local/bin/

systemctl daemon-reload

FILE=/boot/starter.txt
if test -f "$FILE"; then
echo "## [BootLab] audio tx-rx
# bootlab-tx@channel:password
# bootlab-rx@channel
" >> /boot/starter.txt
fi

