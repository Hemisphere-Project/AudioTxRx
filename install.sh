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
ln -sf "$BASEPATH/bootlab-rec@.service" /etc/systemd/system/
ln -sf "$BASEPATH/bootlab-rec" /usr/local/bin/
ln -sf "$BASEPATH/bootlab-tunnel@.service" /etc/systemd/system/
ln -sf "$BASEPATH/bootlab-tunnel" /usr/local/bin/

systemctl daemon-reload

FILE=/boot/starter.txt
if test -f "$FILE"; then
echo "## [BootLab] audio tx-rx
# bootlab-tx@channel:password       # send audio flux from USB audio in to Bootlab server
# bootlab-rx@channel                # play audio flux from Bootlab server
# bootlab-rec@channel               # record audio flux from Bootlab server on /mnt/usb0
# bootlab-tunnel@ubuntu:boot.telemir.fr:22:2222   # establish ssh tunnel with Bootlab server
" >> /boot/starter.txt
fi

