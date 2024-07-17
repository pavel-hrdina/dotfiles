#!/bin/bash
#
#      ____  ___   _____ __  ______  ______
#     / __ )/   | / ___// / / / __ \/ ____/
#    / __  / /| | \__ \/ /_/ / /_/ / /
#   / /_/ / ___ |___/ / __  / _, _/ /___
#  /_____/_/  |_/____/_/ /_/_/ |_|\____/
#
#  Pavel Hrdina 2024

iatest=$(expr index "$-" i)

test -s ~/.alias && . ~/.alias || true

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style none"; fi

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

#######################################################
# FUNCTIONS
#######################################################

gcom() {
	git add .
	git commit -S -m "$1"
}

lazyg() {
	git add .
	git commit -S -m "$1"
	git push
}

glog() {
	git log --graph \
		--pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' \
		--abbrev-commit
}

# copy files from $1 to $2
rsyncc() {
	rsync -P -v -z ‐‐compress‐choice=zstd -a "$1" "$2"
}

addToPath() {
	if [[ "$PATH" != *"$1"* ]]; then
		export PATH=$1:$PATH
	fi
}

####################################################
# Sourcing files
##################################################

addToPath "$HOME/.zig"

. /home/pavel/_zig.bash

# Color for manpages in less makes manpages a little easier to read
# Colored bash using starshit
eval "$(starship init bash)"
