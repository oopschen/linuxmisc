export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

# urxvtd --quiet --opendisplay --fork
exec ck-launch-session dbus-launch --auto-syntax --exit-with-session xmonad
