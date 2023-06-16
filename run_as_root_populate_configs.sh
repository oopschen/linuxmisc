#!/usr/bin/env bash
#

if [ 1 -gt $# ]; then
  echo "sh script username"
  exit 1
fi

homebase=/home/$1
scriptdir=$(realpath $(dirname $0))

# udev rule
ln -sv $scriptdir/etc/udev/*.rules /etc/udev/rules.d/
# sudo 
cp -r $scriptdir/etc/sudoers.d /etc/
chown -R root:root /etc/sudoers.d
# xorg server 
ln -sv $scriptdir/etc/X11/xorg.conf.d /etc/X11/
# sysctl.d
ln -sv $scriptdir/etc/sysctl.d/*.conf /etc/sysctl.d/
# acpi
ln -sv $scriptdir/etc/acpi/actions/*.sh /etc/acpi/actions/
# dnsmasq
ln -sv $scriptdir/etc/dnsmasq.d /etc/
sed -r -i.rootp.bak 's@^#(conf-dir.+\.d/,\*.conf$)@\1@ig' /etc/dnsmasq.conf
# v2ray
rm /etc/v2ray/config.json
ln -sv $homebase/.config/v2ray/config.json /etc/v2ray/
# nftables
ln -sv $homebase/.config/nftables.d /etc/


