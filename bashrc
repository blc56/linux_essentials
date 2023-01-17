# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#alisases
#alias tags_gen="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q \`cat dirs\`"
alias u="cd ../;"
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias sc='screen -ln -Rd'
alias psx="ps -e ouid,pid,ppid,pgid,sid,cgname,c,stime,tty,time,cmd --forest && ps ouid,pid,ppid,pgid,sid,cgname,c,stime,tty,time,cmd | head -n 1"
alias vim="nvim"
alias less="nvim -R"
alias view="nvim -R"
if [[ $OSTYPE=="darwin32" ]]; then
	alias fdfind="fd"
else
	alias fd="fdfind"
fi

export PATH=/usr/local/bin/:$PATH
export PATH=${HOME}/local/bin/:${HOME}/local/sbin/:$PATH
export EDITOR="nvim"
export CLASSPATH="./"
#& -- ignore repeats
# list is colon delimited
export HISTIGNORE="&:ls:u:exit"

export LD_LIBRARY_PATH=${HOME}/local/lib/
export LD_RUN_PATH=${HOME}/local/lib/
export INCLUDE_PATH=${HOME}/local/include
export CFLAGS="-I${HOME}/local/include"
export LDFLAGS="-L${HOME}/local/lib"
export CPPFLAGS=${CFLAGS}
export CXXFLAGS=${CFLAGS}
export PKG_CONFIG_PATH=${HOME}/local/lib/pkgconfig

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
#ignore white space and duplicates in history
export HISTCONTROL=ignoreboth

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

if [ -f ~/.git-completion.bash ]; then
	source ~/.git-completion.bash
fi

# delete local branches which have been merged into the current branch
function git_print_merged {
	#git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d
	git checkout -q main && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base main $branch) && [[ $(git cherry main $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && echo "$branch"; done

}
function git_delete_merged {
	#git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d
	git checkout -q main && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base main $branch) && [[ $(git cherry main $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch ; done
}
function docker_rm_exited_containers {
	docker ps --filter status=exited -q | xargs docker rm
}

#have fzf use ripgrep
export FZF_DEFAULT_COMMAND='rg --column --line-number --no-heading --smart-case ""'
export FZF_CTRL_T_COMMAND='fdfind '
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# source bash customations for local environment
if [ -f ~/.bashrc_local ]; then
	source ~/.bashrc_local
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
