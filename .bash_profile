
# Interact with Bash in Vim mode
set -o vi

# Vim is my editor. I fucking love vim. No, really.
export EDITOR=vim

# I never remember how to open finder from the terminal
alias finder='open'

# I never remember how to access the clipboard
alias clipboard='pbcopy'

# Use a colour terminal
alias ls='ls -G'
alias ll='ls -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Use macvim from the command line
alias mvim="open -a MacVim.app"

# Use the Ubuntu default prompt
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

# FYI: Old (boring) OS X prompt
#export PS1"=\h:\W \u\$ "

# I go here a lot
alias avon='ssh avon@zen'

alias crontab='VIM_CRONTAB=true crontab'

# Common git alias list
alias gs='git status -s'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gpom='git push origin master'
alias gl='git log'

# Node.js configuration
export NODE_PATH=/usr/lib/node_modules

