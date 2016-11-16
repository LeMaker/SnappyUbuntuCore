#!/bin/sh

sudo /snap/bin/ubuntu-image --channel stable --image-size 4G --extra-snaps bluez --extra-snaps snapweb --extra-snaps modem-manager --extra-snaps network-manager -o uc16-lemaker-guitar-`date +%Y%m%d`-0.img lemaker-guitar.model

