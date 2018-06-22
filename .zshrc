# Zsh
#############################
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
DISABLE_AUTO_UPDATE=true
source $ZSH/oh-my-zsh.sh


# Path and variables
#############################

HIST_STAMPS="yyyy-mm-dd"
plugins=(git osx zsh-256color)

export GOPATH="/Users/zephod/code/go"

export PATH=""
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/opt/chefdk/bin
export PATH=$PATH:$GOPATH/bin
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules


# I love vim
export EDITOR=nvim
alias vim="nvim"

# Override some ridiculous global default I can't see
export VAGRANT_DEFAULT_PROVIDER=virtualbox

export ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"


# Aliases
#############################

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
alias dc='docker-compose'
dc-reboot() {
  dc rm --stop --force -v $1
  dc up -d --no-deps --build $1
}
dc-shell() {
  ID=$(dc ps -q $1)
  docker exec -it $ID sh
}

alias gl='git lg'
alias gss='git status -s'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit -m'
alias gcam='git commit -a -m'

# I wrote this to kill old webpack-dev-servers
alias rescue='ps -a -eo pid,command | grep "node.*webpack-dev-server" | grep -v grep | awk "{print \$1}" | xargs kill -9'

LOCAL_INIT=~/.init.sh
if [ -e $LOCAL_INIT ] ; then
  source $LOCAL_INIT
fi
