# -*- mode: shell-script; -*-
#+DEST=$HOME/
#+FNAME=.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion  > /dev/null
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL="ignoredups:ignorespace"

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export ALTERNATE_EDITOR=emacs
export EDITOR=emacsclient
export VISUAL=emacsclient
export EDITOR

# PS1
function my_prompt {
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"
    local RESET='\e[0m'

    if [ x$TERM == x"xterm" ]; then
        PS1=`echo "${EMC}\h${RESET}:${EMB}\w${RESET}$ "`
    else
        PS1="\u@\h:\w$ "
    fi
}

PROMPT_COMMAND=my_prompt
PS2='    '

#
function _exit()        # Function to run upon exit of shell.
{
    echo -e "Well done yag, see you soon :)"
}
trap _exit EXIT

s() { # do sudo, or sudo the last command if no argument given
    if [[ $# == 0 ]]; then
        sudo $(history -p '!!')
    else
        sudo "$@"
    fi
}

# load splitted files
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_plugins ]; then
    . ~/.bash_plugins
fi

if [ -f ~/.bash_custom ]; then
    . ~/.bash_custom            # system specific
fi

# .bashrc ends here
