# -*- mode: shell-script; -*-
#+DEST=$HOME/
#+FNAME=.bash_aliases

# --------------------------------------------------------------------------
# ALIAS
# --------------------------------------------------------------------------

# Navigation
# --------------------------

# BOOKMARKing
# I got this http://hayne.net/MacDev/Bash/aliases.bash
# The following aliases (S , L and G) are for saving frequently used directories
# You can save a directory using an abbreviation of your choosing. Eg. save ms
# You can subsequently move to one of the saved directories by using cd with
# the abbreviation you chose. Eg. cd ms  (Note that no '$' is necessary.)

if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
    touch ~/.dirs
else
    source ~/.dirs
fi

alias L='cat ~/.dirs'

G () {              # goes to distination dir otherwise , stay in the dir
    cd ${1:-$(pwd)} ;
}

S () {              # SAVE a BOOKMARK
    sed "/$@=/d" ~/.dirs > ~/.dirs1;
    \mv ~/.dirs1 ~/.dirs;
    echo "$@"=\"`pwd`\" >> ~/.dirs;
    source ~/.dirs ;
}

R () {              # remove a BOOKMARK
    sed "/$@=/d" ~/.dirs > ~/.dirs1;
    \mv ~/.dirs1 ~/.dirs;
}

alias U='source ~/.dirs'    # Update BOOKMARK stack
# set the bash option so that no '$' is required when using the above facility
shopt -s cdable_vars

# -----------------------------------------------------------------

#for ease between folder
#alias .='echo "$PWD"'
alias ..='DOT="$PWD";cd ..'
alias ...='DOT="$PWD";cd ../..'
alias ....='DOT="$PWD";cd ../../..'
#come back
alias ,,='cd "$DOT"'

alias pd='pushd "$PWD"'
alias cd='OLD="$PWD"; cd '
alias ,='BACK="$OLD"; OLD="$PWD"; cd "$BACK"'

# make use of S,G two switch over two folder
alias sn='S n'
alias st='S t'
alias gn='G n'
alias gt='G t'

# apt
# --------------------------
# alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get remove --purge'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias upgrade='sudo apt-get upgrade'
#alias clean='sudo apt-get autoclean && sudo apt-get autoremove'
alias search='apt-cache search'
alias show='apt-cache show'
alias sources='(gksudo gedit /etc/apt/sources.list &)'
ppa () {
    sudo add-apt-repository ppa:$1/ppa
    sudo apt-get update
}

# Gnome
# --------------------------
alias o="gnome-open "
alias reboot="sudo /sbin/shutdown -r now"
alias shutdown="sudo /sbin/shutdown -h now"
alias shutup='gnome-session-save --shutdown-dialog'
alias lout='gnome-session-save --logout'

# Custom
# --------------------------
alias oup="~/bin/orgup.sh"
alias shrc='source ~/.bashrc'
alias orgcoNpush='cd ~/git/org && git add . && git commit -m "`date`" || git pull --rebase && git push origin HEAD || cd $OLD'
alias update_dotfiles='cd ~/git/dotfiles && ./place_all.pl || . ~/.bashrc || cd $OLD '

#delete
alias del='mv --target-directory=$HOME/.Trash/'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -A'
alias dirall='ls  --color=auto -laR | more'
alias lm='ls -al | more'
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias sl='ls'
alias rm='rm -v'


# Human readable
alias du='du -h'
alias df='df -h'

# MIS SPELLS
#--------------------------
alias tial='tail'
alias mroe='more'
alias moer='more'
alias type='more'
alias emasc='emacs'

# shorts
alias a='alias'
alias hi='history'

# emacs
alias e='emacs &'
alias ec='emacsclient'
alias edebug='emacs --debug-init'
alias ect='emacsclient -tc'
alias eda='emacs --daemon'

# grepping
# ----------
alias g='grep -i'  # Case insensitive grep
alias h='history|grep '
alias agrep='alias|grep '

# chmod and permissions commands -------
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'
alias 744='chmod 744'
alias perm='stat --printf "%a %n \n "' # requires a file name e.g. perm file

# find files
alias lfp='find `pwd` -maxdepth 1'
alias lfd='find `pwd` -maxdepth 1 -type d | sort'
alias lff='find `pwd` -maxdepth 1 -type f | sort'
alias ff='find . -name \!* -print'
alias f='find . -iname'

# gitting
#--------------------------
alias gis='git status'
alias gb="git branch"
alias gba="git branch -a"
alias gco='git checkout '
alias gad='git add .'
alias gd='git diff'
alias gip='git push'
alias gc="git commit -v"
alias gcam="git commit -a -m"
alias ga="git add"
alias lol="git lol"
alias lola="git lola"
alias gcheckback="git checkout HEAD --"
alias ggoback="git checkout HEAD^ --"
alias gitreset="git reset --hard"

alias gl="git pull --rebase"
alias gp="git push origin HEAD"
alias gcp="git cherry-pick"
alias gst="git status"
alias gr="git rm"
alias gmv="git mv"
alias gu="git pull --rebase && git push origin HEAD"


# mounting and unmounting
# -----------------------
#sshfs
alias farumount='fusermount -u ~/far_projects'

# MISC
#--------------------------
alias smacs=$HOME/bin/emacs-screen.sh
alias killbg='kill -9 %' # CAUTION
alias clean='rm -v *~ .*~ .#* \#*\#'
alias y='echo ITS OVER DUDE'
alias xp='vmplayer /dump/vmware/winxp/winxp.vmx &> /tmp/vmplayer.log &'
alias bt='gdb -batch-silent -ex "run" -ex "set logging overwrite on" -ex "set logging file gdb.bt" -ex "set logging on" -ex "set pagination off" -ex "handle SIG33 pass nostop noprint" -ex "echo backtrace:\n" -ex "backtrace full" -ex "echo \n\nregisters:\n" -ex "info registers" -ex "echo \n\ncurrent instructions:\n" -ex "x/16i \$pc" -ex "echo \n\nthreads backtrace:\n" -ex "thread apply all backtrace" -ex "set logging off" -ex "quit" --args'
alias bt_inspect='gdb -ex "run" -ex "set logging overwrite on" -ex "set logging file gdb.bt" -ex "set logging on" -ex "set pagination off" -ex "handle SIG33 pass nostop noprint" -ex "echo backtrace:\n" -ex "backtrace full" -ex "echo \n\nregisters:\n" -ex "info registers" -ex "echo \n\ncurrent instructions:\n" -ex "x/16i \$pc" -ex "echo \n\nthreads backtrace:\n" -ex "thread apply all backtrace" --args'

# quit shell
alias q='exit'
