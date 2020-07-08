# env
export JAVA_HOME=~/opt/openjdk/jdk-11
export PATH=$HOME/.local/bin:$JAVA_HOME/bin:$HOME/.poetry/bin:$HOME/.cargo/bin:$PATH
export DISABLE_AUTO_TITLE='true'
export TERM=screen-256color
export FZF_DEFAULT_COMMAND='rg --files -L -i '
export PIPENV_PYPI_MIRROR=https://mirrors.aliyun.com/pypi/simple/
#export LD_PRELOAD=/home/wzga/source_codes/wcwidth-icons/libwcwidth-icons.so

## awesome fonts
#source ~/.fonts/*.sh

# zplug
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# history
zplug "zsh-users/zsh-syntax-highlighting", use:"zsh-syntax-highlighting.zsh"
zplug "zsh-users/zsh-history-substring-search", use:"zsh-history-substring-search.zsh"
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# theme
#setopt prompt_subst # Make sure prompt is able to be generated properly.
#zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3 # defer until other plugins like oh-my-zsh is loaded
#POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir ssh virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs background_jobs history)
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme, defer:3
#end

# fzf
zplug "junegunn/fzf-bin", \
      from:gh-r, \
      as:command, \
      rename-to:fzf, \
      use:"*linux_amd64*"

# z
zplug "plugins/z", from:oh-my-zsh

# gradle completion
zplug "gradle/gradle-completion", from:github, as:command

zplug load

####### end
# bugfix ctrl-z not work https://github.com/zplug/zplug/issues/322
test -f $_zplug_lock && rm $_zplug_lock

# options for zsh
setopt extendedglob
DIRSTACKSIZE=7
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autolist
setopt appendhistory histignorealldups incappendhistory
SAVEHIST=50
HISTFILE=~/.zsh_history
bindkey -v

#alias
# thanks to z plugin: alias ds='dirs -v'
alias ll='ls -lh --color'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias dkc-db='dkc exec ${DBSERVICE:-db} mysql -h ${DBHOST:-127.0.0.1} -u ${DBUSER:-dev} -p${DBPWD:-123456} ${DBNAME:-dev}'
alias dkc-reup='dkc stop $p; dkc rm -v $p; dkc up -d $p; dkc logs -f $p;'
alias g='git'
alias sX='startx'
alias wip='watch -n 1 ip addr show dev wlan0'
## alias suffix
alias -s html=google-chrome-stable \
  docx=wps \
  doc=wps \
  xlsx=et \
  xls=et \
  pdf=mupdf \
  png=sxiv \
  jpeg=sxiv \
  jpg=sxiv \
  gif=sxiv \
  bmp=sxiv \
  md=vim \
  conf=vim \
  svg=google-chrome-stable \
  log=vim

alias startwifi="sudo rc-service net.wlan0 start"
alias restartwifi="sudo rc-service net.wlan0 restart"
alias vpninit="shadowsocks-redir-iptables A ~/.config/shadowsocks.json"
alias vpntoggle="shadowsocks-redir-iptables T ~/.config/shadowsocks.json"
alias vpnoff="shadowsocks-redir-iptables D ~/.config/shadowsocks.json"
alias hdof="monitor-op hdmi-off"
alias hdo="monitor-op hdmi-on"
alias hdm="monitor-op hdmi-mirror"
alias gw="./gradlew"
alias bdcls="pgrep baidunetdisk | xargs kill -HUP"
alias cuzp="unzip -O cp936"
alias ws="sudo wpa_cli -i wlan0"
alias wsl="sudo wpa_cli -i wlan0 list_networks"
alias wss="sudo wpa_cli -i wlan0 select_network"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

### environment
##### node js
export SASS_BINARY_SITE=http://npm.taobao.org/mirrors/node-sass
export PUPPETEER_DOWNLOAD_HOST=https://npm.taobao.org/mirrors
export ELECTRON_MIRROR=http://npm.taobao.org/mirrors/electron/
#####

## git prompt
source /usr/share/git/git-prompt.sh
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
precmd () { __git_ps1 "%n" ":%~$ " "|%s" }
