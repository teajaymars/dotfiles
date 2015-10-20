############
## LOCALE ##
############
# Fixes broken Vim on Ubuntu
export LC_ALL=$LANG

##########
## PATH ##
##########
# Node binaries
export PATH="/usr/local/share/npm/bin:$PATH"
# Python binaries
export PATH="/usr/local/share/python:$PATH"

#################
## ENVIRONMENT ##
#################
# Vim is my editor. I fucking love vim. No, really.
export EDITOR=vim

#############
## ALIASES ##
#############
# I never remember how to open finder from the terminal
alias finder='open'
# I never remember how useful this mac command is
alias spotlight='mdfind'
# I never remember how to access the clipboard
alias clipboard='pbcopy'
# Use a colour terminal
alias ls='ls -G'
alias ll='ls -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# Edit my crontable with Vim
alias crontab='VIM_CRONTAB=true crontab'
# Common git alias list
alias gss='git status -s'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

#########
# MARKS #
#########
# Source: http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
export MARKPATH=$HOME/.marks
function jump {
    cd -P $MARKPATH/$1 2> /dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
    rm -i $MARKPATH/$1
}
function marks {
    \ls -l $MARKPATH | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}
alias jj='jump'


#########
## ETC ##
#########
# Git autocompletion script
GIT_SCRIPT=~/Dropbox/scripts/.git-completion.sh 
if [ -e $GIT_SCRIPT ] ; then
  source $GIT_SCRIPT
fi

# Fast searching for files
findext() {
  find . -name \*.$1
}

# Use the Ubuntu default prompt
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

