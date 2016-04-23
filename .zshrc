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
export PATH=$PATH:/usr/local/share/python
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/opt/chefdk/bin
export PATH=$PATH:$GOPATH/bin

# I love vim
export EDITOR=nvim
alias vim="nvim"

# Override some ridiculous global default I can't see
export VAGRANT_DEFAULT_PROVIDER=virtualbox

export ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"


# Aliases
#############################

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
alias gl='git lg'
alias gss='git status -s'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit -m'
alias gcam='git commit -a -m'

# I never remember how useful this mac command is
alias spotlight='mdfind'
