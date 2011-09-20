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

G () {				# goes to distination dir otherwise , stay in the dir
    cd ${1:-$(pwd)} ;
}

S () {				# SAVE a BOOKMARK
    sed "/$@/d" ~/.dirs > ~/.dirs1;
    \mv ~/.dirs1 ~/.dirs;
    echo "$@"=\"`pwd`\" >> ~/.dirs;
    source ~/.dirs ;
}

R () {				# remove a BOOKMARK
    sed "/$@/d" ~/.dirs > ~/.dirs1;
    \mv ~/.dirs1 ~/.dirs;
}

alias U='source ~/.dirs' 	# Update BOOKMARK stack
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

#workstations & sites
alias amu='ssh -Y yagnesh@amur.porc.lowtem.hokudai.ac.jp'
alias kor='ssh -Y yagnesh@korsakov.porc.lowtem.hokudai.ac.jp'
alias kur='ssh -Y yagnesh@kuril.porc.lowtem.hokudai.ac.jp'
alias sup='ssh -Y bu3107@wine.hucc.hokudai.ac.jp'
alias sap='ssh -Y sapporoindians@sapporoindians.com'
alias yuz='ssh -Y yagnesh@yuzhno.porc.lowtem.hokudai.ac.jp'
alias lubu='ssh -Y yagnesh@okhotsk19.lowtem.hokudai.ac.jp'
alias lpy='ssh -Y yagnesh@raghava-note.lowtem.hokudai.ac.jp'
alias huisa='ssh -Y huisa@huisa.net'
alias blade='ssh -Y yagnesh@blade.ees.hokudai.ac.jp'
alias sunku='ssh -Y yagnesh@sunku.ees.hokudai.ac.jp'

export vamu=yagnesh@amur.porc.lowtem.hokudai.ac.jp
export vkor=yagnesh@korsakov.porc.lowtem.hokudai.ac.jp
export vkur=yagnesh@kuril.porc.lowtem.hokudai.ac.jp
export vsup=bu3107@wine.hucc.hokudai.ac.jp
export vsap=sapporoindians@sapporoindians.com
export vyuz=yagnesh@yuzhno.porc.lowtem.hokudai.ac.jp
export vlpy=yagnesh@raghava-note.lowtem.hokudai.ac.jp
export vhuisa=huisa@huisa.net
export vblade=yagnesh@blade.ees.hokudai.ac.jp
export vlubu=yagnesh@okhotsk19.lowtem.hokudai.ac.jp
export vsunku=yagnesh@okhotsk19.lowtem.hokudai.ac.jp

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
alias ect='emacsclient -t temp || rm -f temp'
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
alias clean='rm *~ .*~ .#* \#*\#'
alias y='echo ITS OVER DUDE'
alias xp='vmplayer vmware/winxp/winxp.vmx'

# quit shell
alias q='exit'
