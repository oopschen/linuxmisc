# Linux Misc
此项目主要包含了一些linux使用的配置文件和不可分类的杂项。

## etc

/etc目录文件。

##  devel
开发相关配置文件。

## container
容器相关脚本和文件。


## Gentoo桌面系统安装步骤

1. 根据[官方文档](https://wiki.gentoo.org/wiki/Handbook:AMD64) 安装Gentoo系统。(Grub2 + Ext4)
1. 编译内核需要考虑(hid、intel特性功能、硬件驱动)
1. 常规用户增加权限"tty,wheel,audio,video,kvm,input,plugdev,pcap,usb"
1. root执行本仓库./run_as_root_populate_configs.sh脚本
1. 修改acpid的default.sh 脚本
1. 同步/etc/portage/package.use、/etc/portage/package.license、/etc/portage/package.accept_keywords等文件
1. 根据/world文件安装系统程序
1. 同步原有home文件：rsync -avHXU xxxx /home
1. 调整nvidia/iwlwifi等模块参数
