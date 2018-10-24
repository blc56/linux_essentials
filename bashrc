# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#alisases
#alias t="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q \`cat dirs\`"
alias u="cd ../;"
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias sc='screen -ln -Rd'
#alias jm="rm *.class; javac *.java 2>&1 | grep -C 5 .java | grep -C 5 [0-9]"
alias less="vimpager"
#alias T="vim ~/TODO"
#alias gc="git checkout"
#alias gs="git status"
#alias gsh="git stash"
#alias gb="git branch"
#alias gr="git rebase"
#alias gm="git merge"
#alias gd="git diff --color"
#alias gdt="git difftool --color"
#alias gl="git log"
#alias ga="git add"
#alias gps="git-p4 sync"
#alias gpr="git-p4 rebase"
#alias hgl='hg glog | less'
#alias hl='hg log | less'
#alias hlv='hg -v log | less'

function m 
{
	make -s $@ 2>&1 | grep --color=always -iC 5 "\(error\)\|\(warning\)\|\([0-9]\)\|\(=\)"
}

PATH=/usr/local/bin/:$PATH
PATH=${HOME}/local/bin/:${HOME}/local/sbin/:$PATH
PATH=${HOME}/.vim/bundle/vimpager:$PATH
EDITOR="vim"
CLASSPATH="./"
#& -- ignore repeats
# list is colon delimited
HISTIGNORE="&:ls:u:exit"
LD_LIBRARY_PATH=${HOME}/local/lib/
LD_RUN_PATH=${HOME}/local/lib/
INCLUDE_PATH=${HOME}/local/include
CFLAGS="-I${HOME}/local/include"
LDFLAGS="-L${HOME}/local/lib"
CPPFLAGS=${CFLAGS}
CXXFLAGS=${CFLAGS}
PKG_CONFIG_PATH=${HOME}/local/lib/pkgconfig

export PATH
export EDITOR
export CLASSPATH
export HISTIGNORE
export PAGER="vimpager"
export LD_LIBRARY_PATH
export LD_RUN_PATH
export INCLUDE_PATH
export CFLAGS
export CPPFLAGS
export CXXFLAGS
export LDFLAGS
export PKG_CONFIG_PATH

export TERM=xterm-256color
set -o vi
umask 077

#from /etc/bash/bashrc on a gentoo linux install. 

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# Change the window title of X terminals 
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs
### end shameless rip

export BACK_HISTORY=""
export FORWARD_HISTORY=""

export BACK_HISTORY=""
export FORWARD_HISTORY=""

function cd {
    BACK_HISTORY=$PWD:$BACK_HISTORY
    FORWARD_HISTORY=""
    builtin cd "$@"
}

function back {
    DIR=${BACK_HISTORY%%:*}
    if [[ -d "$DIR" ]]
    then
        BACK_HISTORY=${BACK_HISTORY#*:}
        FORWARD_HISTORY=$PWD:$FORWARD_HISTORY
        builtin cd "$DIR"
    fi  
}

function forward {
    DIR=${FORWARD_HISTORY%%:*}
    if [[ -d "$DIR" ]]
    then
        FORWARD_HISTORY=${FORWARD_HISTORY#*:}
        BACK_HISTORY=$PWD:$BACK_HISTORY
        builtin cd "$DIR"
    fi  
}

alias b="back"
alias f="forward"

alias w32="WINEPREFIX=~/.wine32 WINEARCH='win32'"

# source software dev defs
if [ -f ~/.bash_excensus ]; then
	. ~/.bash_excensus
fi
