# Zsh
#############################
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
DISABLE_AUTO_UPDATE=true
source $ZSH/oh-my-zsh.sh

# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Path and variables
#############################

HIST_STAMPS="yyyy-mm-dd"
plugins=(git osx zsh-256color zsh-yarn-completions)

# I love vim
export EDITOR=nvim
alias vim="nvim"

export ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"

# Kubernetes autocompletion
# Source: https://kubernetes.io/docs/tasks/tools/install-kubectl/
# source <(kubectl completion zsh)

# Aliases
#############################

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
alias dc='docker compose'
dc-reboot() {
  dc rm --stop --force -v $1
  dc up -d --no-deps --build $1
}
dc-shell() {
  ID=$(dc ps -q $1)
  docker exec -it $ID sh
}

alias gch='git checkout'
alias gl='git lg'
alias gss='git status -s'
alias gch='git checkout'
alias gd='git diff'
alias ga='git add'
alias gb='git branch'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias curltime='curl -w "
    time_namelookup:  %{time_namelookup}
       time_connect:  %{time_connect}
    time_appconnect:  %{time_appconnect}
   time_pretransfer:  %{time_pretransfer}
      time_redirect:  %{time_redirect}
 time_starttransfer:  %{time_starttransfer}
                    ----------
         time_total:  %{time_total}
" -o /dev/null -s'

alias nicecurl='curl -L -v -s'
alias curlheaders='curl -L -v -s -o /dev/null'

# Seems redundant
# LOCAL_INIT=~/.init.sh
# if [ -e $LOCAL_INIT ] ; then
#   source $LOCAL_INIT
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias ps3000='lsof -nP -iTCP:3000 | grep LISTEN | xargs echo | cut -d " " -f 2'

# export PATH="/usr/local/opt/curl/bin:$PATH"

# Ensure SSH agent is running
eval "$(ssh-agent)" > /dev/null
ssh-add --apple-load-keychain > /dev/null 2>&1

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python version manager version manager
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# For Sony Bravia / DVD player
function ffmpeg_divx {
  ffmpeg -i "$1" \
    -c:v mpeg4 \
    -q:v 5 \
    -tag:v DIVX \
    -s 720x480 \
    -c:a libmp3lame \
    -q:a 5 \
    -ac 2 \
    -ar 44100 \
    "${1%.*}.divx.avi"
}

# Worked on Bottom's AVI files
function ffmpeg_mp4 {
  ffmpeg -i "$1" \
    -c:v mpeg4 \
    -q:v 3 \
    "${1%.*}.mp4"
}


function ffmpeg_ac3 {
  ffmpeg -i "$1" \
    -map 0:v  \
    -map 0:a:0  \
    -map 0:s  \
    -c copy  \
    -c:a ac3  \
    -b:a 640k  \
    "${1%.*}.ac3.mkv"
}
