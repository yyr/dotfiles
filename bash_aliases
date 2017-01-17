# -*- mode: shell-script; -*-
#+DEST=$HOME/
#+FNAME=.bash_aliases

# --------------------------------------------------------------------------
# ALIAS
# --------------------------------------------------------------------------
timeit () {
    date1=$(date +"%s")
    $@
    date2=$(date +"%s")
    diff=$(($date2-$date1))
    date -u -d @"$diff" +'Time stat: %-Mm %-Ss'
    # echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
}


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

# make use of S,G two switch over two folder (quick bookmarks)
alias sn='S n'
alias st='S t'
alias gn='G n'
alias gt='G t'

# apt
# --------------------------
# alias install='sudo apt-get install'
alias gapt='sudo apt-get'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get remove --purge'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias upgrade='sudo apt-get upgrade'
alias upstall='sudo apt-get update && sudo apt-get install'
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
alias o="gvfs-open "
alias reboot="sudo /sbin/shutdown -r now"
alias shutdown="sudo /sbin/shutdown -h now"
alias shutup='gnome-session-save --shutdown-dialog'
alias lout='gnome-session-save --logout'

# Custom
# --------------------------
alias shrc='source ~/.bashrc'
alias orgcoNpush='cd ~/git/org && git add -A && git commit -m "`date`" || git pull --rebase && git push origin HEAD || cd $OLD'

# remote
alias hclogin='kinit yagnesh@HCOOP.NET && aklog hcoop.net'


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
alias t='time'

# emacs
alias e='setsid emacs'
alias edebug='emacs --debug-init'
alias ect='emacsclient -tc'
alias ecn='emacsclient -c'
alias eda='emacs --daemon'
function ec()
{
    if (( $# < 1 )); then
        emacsclient -c &
    else
        echo came here
        emacsclient $@ &
    fi
}


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
alias gic="git clean -xdf"
alias gcheckback="git checkout HEAD --"
alias ggoback="git checkout HEAD^ --"
alias gitreset="git reset --hard"

alias gl="git pull"
alias gp="git push origin HEAD"
alias gcp="git cherry-pick"
alias gst="git status"
alias gr="git rm"
alias gmv="git mv"
alias gu="git pull --rebase && git push origin HEAD"

# vagrant
alias vb="vagrant box"
alias vh="vagrant halt"
alias vp="vagrant provision"
alias vs="vagrant status"
alias vssh="vagrant ssh"
alias vu="vagrant up"


# python specific
alias pyprof='python -m cProfile'

# mounting and unmounting
# -----------------------
#sshfs
alias farumount='fusermount -u ~/far_projects'


# virtual machines
alias xp='vboxmanage startvm "xp"'
alias vb="virtualbox --fullscreen --startvm "


# Misc
#--------------------------
alias killbg='kill -9 %' # CAUTION
alias clean='rm -v *~ .*~ .#* \#*\#'
alias ncl='time ncl -Q'
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

# gdb
alias bt='gdb -batch-silent -ex "run" -ex "set logging overwrite on" -ex "set logging file gdb.bt" -ex "set logging on" -ex "set pagination off" -ex "handle SIG33 pass nostop noprint" -ex "echo backtrace:\n" -ex "backtrace full" -ex "echo \n\nregisters:\n" -ex "info registers" -ex "echo \n\ncurrent instructions:\n" -ex "x/16i \$pc" -ex "echo \n\nthreads backtrace:\n" -ex "thread apply all backtrace" -ex "set logging off" -ex "quit" --args'
alias bt_inspect='gdb -ex "run" -ex "set logging overwrite on" -ex "set logging file gdb.bt" -ex "set logging on" -ex "set pagination off" -ex "handle SIG33 pass nostop noprint" -ex "echo backtrace:\n" -ex "backtrace full" -ex "echo \n\nregisters:\n" -ex "info registers" -ex "echo \n\ncurrent instructions:\n" -ex "x/16i \$pc" -ex "echo \n\nthreads backtrace:\n" -ex "thread apply all backtrace" --args'

# Python servers
alias webs='python -m SimpleHTTPServer'
alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias fakemail='python -m smtpd -n -c DebuggingServer localhost:20025'

# quit shell
alias q='exit'


# Display random digits speckled across the screen
alias noise='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;3$(($RANDOM % 8))" grep --color "[^ ]"'
alias distract='cat /dev/urandom | hexdump -C | grep "ca fe"'

#clear the terminal (no upwards scrolling)
alias cls='printf "\033c"'

#sha1 hash
alias sha1='openssl sha1'

#Display current time
alias now='date +"%T"'

#Display current date and time
alias nowdate='date +"%A %Y年%m月%d日 %T"'

#List of ports
alias ports='netstat -tulanp'

# rm safety net
alias del='rm -I --preserve-root'

#Top 10 memory eating processes
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

#Top 10 cpu eating processes
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

# shoot the fat ducks in your current dir and sub dirs
alias ducks='du -cm | sort -nr | head'

# Easily pass a string to and look for it in the process table.
# Even removes the grep of the current line.
alias psgrep='ps -ef | grep -v $$ | grep -i '

# Helps with copy and pasting to and from a terminal using X and the mouse
# Especially for piping output to the clipboard and vice versa
alias xcopy='xsel --clipboard --input'
alias xpaste='xsel --clipboard --output'

### Functions

#Calculator (The equation cannot have spaces)
# > ? 5+5
# > 10
? () { echo "$@" | bc -l; }

cdl() { cd"$@"; ls -alF; }

#Display basic system information
function sysstats() {
    echo -e "\nMachine information:" ; uname -a
    echo -e "\nUsers logged on:" ; w -h
    echo -e "\nCurrent date :" ; date
    echo -e "\nMachine status :" ; uptime
    echo -e "\nMemory status :" ; free
    echo -e "\nFilesystem status :"; df -h
}

#Lists the ip(s) for a domain name
# > whatip google.com
whatip() {
    if [ $# != 1 ]; then
        echo "Usage: whatip <ip address>"
    else
        nslookup $1 | grep Add | grep -v '#' | cut -f 2 -d ' '
    fi
}

# Makes a directory of the specified name and immediately switches to that directory
mkcd() {
    if [ $# != 1 ]; then
        echo "Usage: mkcd <dir>"
    else
        mkdir -p $1 && cd $1
    fi
}

#Changes directories up the specified number
up() { [ $(( $1 + 0 )) -gt 0 ] && cd $(eval "printf '../'%.0s {1..$1}"); }

#Generate a alphanumeric password/random string
passgen() {
    echo $(< /dev/urandom tr -dc A-Za-z0-9_ | head -c$1)
}

#Flip a coin
coinflip() {
	if [[ $(($RANDOM % 2)) -eq 1 ]]; then
		echo "Heads";
	else
		echo "Tails"
	fi
}

#Create a copy of a file with a .bkup suffix
bkup() {
    cp $1 $1.bkup
}

#Restore a .bkup file (Warning: will overwrite)
bkdown() {
    mv $1 " basename "$1" .bkup"
}

#Grab the summary from the corresponding wikipedia page
wiki() {
	dig +short txt $1.wp.dg.cx
}

#Simple timer
timeit(){
	echo "Press any key to stop"
#	time -f "%E real" read -sn1
	/usr/bin/time -f "%E real" $(read -sn1)
}

#Slowly echo the input back out to the screen
slowecho(){
	echo $1 | pv -qL 10
}

#Kill the parent process of a mouse-clicked X window
xmurder(){
	WINDOW_ID=`xwininfo | grep "Window id:" | awk '{print $4}'`
	PROCESS_ID=`xprop -id $WINDOW_ID _NET_WM_PID | awk '{print $3}'`
	kill -9 $PROCESS_ID
}

murder() {
    pids=`ps -ef | grep $1  | grep -v grep  | awk '{print $2}'`
    for p in $pids; do
        echo "kill pid:" $p
        kill -9 $p
    done
}


# which ls
wh () {
    ls -l `which $1`
}

#
alias em=$'emacsclient -t --eval \'(let ((display-buffer-alist `(("^\\*magit: " display-buffer-same-window) ,display-buffer-alist))) (magit-status))\''
