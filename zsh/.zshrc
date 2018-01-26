# env
export PATH=$PATH:~/.local/bin
export DISABLE_AUTO_TITLE='true'
export TERM=screen-256color
#export LD_PRELOAD=/home/wzga/source_codes/wcwidth-icons/libwcwidth-icons.so

# zplug
source ~/.zplug/init.zsh
## awesome fonts
source ~/.fonts/*.sh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# history
zplug "zsh-users/zsh-syntax-highlighting", use:"zsh-syntax-highlighting.zsh"
zplug "zsh-users/zsh-history-substring-search", use:"zsh-history-substring-search.zsh"
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# theme
#setopt prompt_subst # Make sure prompt is able to be generated properly.
#zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3 # defer until other plugins like oh-my-zsh is loaded
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme, defer:3
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir ssh)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs root_indicator background_jobs history time)
# bugfix partial display icon
POWERLEVEL9K_HOME_ICON=$'\Uf015 '
POWERLEVEL9K_HOME_SUB_ICON=$'\Uf07c '
POWERLEVEL9K_FOLDER_ICON=$'\Uf07b '
POWERLEVEL9K_ALWAYS_SHOW_USER=true
#end

# fzf
zplug "junegunn/fzf-bin", \
      from:gh-r, \
      as:command, \
      rename-to:fzf, \
      use:"*linux_amd64*"

# z
zplug "plugins/z", from:oh-my-zsh

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
alias ll='ls -lh'
alias -s html=google-chrome-stable
