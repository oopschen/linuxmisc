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

## hdmi change callback script for udev
ln -sv $scriptdir/root/.bin /root/

# sudo 
cp -r $scriptdir/etc/sudoers.d /etc/
chown -R root:root /etc/sudoers.d

# xorg server 
[ ! -d /etc/X11/xorg.conf.d ] && mkdir -p /etc/X11/xorg.conf.d
ln -sv $scriptdir/etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d

## copy system config
cp /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d

# sysctl.d
ln -sv $scriptdir/etc/sysctl.d/*.conf /etc/sysctl.d/

# acpi
ln -sv $scriptdir/etc/acpi/actions/*.sh /etc/acpi/actions/

# dnsmasq
ln -sv $scriptdir/etc/dnsmasq.d /etc/
ln -sv $homebase/.config/.private.server.conf /etc/dnsmasq.d/server-pri.conf
## using openresolv
ln -sv $scriptdir/etc/resolvconf.conf /etc/
### alter dnsmasq.conf
### 1. include /etc/dnsmasq.d/
### 2. resolv /etc/dnsmasq-resolv.conf
### 3. enable filterwin2k to filter soa record in 114 dns
sed -r -i.rootp.bak 's@^#(conf-dir.+\.d/,\*.conf$)@\1@ig;s@^#(resolv-file=)$@\1/etc/dnsmasq-resolv.conf@ig;' /etc/dnsmasq.conf

# v2ray
rm /etc/v2ray/config.json
ln -sv $homebase/.config/v2ray/config.json /etc/v2ray/

# nftables
ln -sv $homebase/.config/nftables.d /etc/
