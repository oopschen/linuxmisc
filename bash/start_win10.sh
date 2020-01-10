#!/usr/bin/env bash
sharedir=$(realpath ~/share)
diskdir=$(realpath ~/win10/disk-c)
qemu-system-x86_64 --enable-kvm --name win10 -accel kvm -m 6G  \
  -drive file=${diskdir},format=raw,index=1,media=disk \
  -nic user,ipv6=off,smb=${sharedir}   -boot d -smp 4,cores=2,threads=2 -cpu host \
  -display sdl -vga std -device qemu-xhci -usb $@


# Vendor=03f0 ProdID=ae07
# device_add driver=usb-host,vendorid=,productid=
