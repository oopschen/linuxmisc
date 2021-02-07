export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xsetroot -cursor_name left_ptr

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exec dbus-launch --auto-syntax --exit-with-session i3
