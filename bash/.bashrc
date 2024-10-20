#!/usr/bin/env bash
#  Pavel Hrdina 2024

# If not running interactively, don't do anything:
[ -z "${PS1:-}" ] && return

[ -n "${PERLBREW_PERL:-}" ] && return

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# after cleanshell, not even $HOME is set, this messes up things that base off $HOME, like SDKman
if [ -z "${HOME:-}" ]; then
    export HOME=~
fi

# shut up Mac, Bash still rocks
export BASH_SILENCE_DEPRECATION_WARNING=1

# ============================================================================ #

# SECURITY TO STOP STUFF BEING WRITTEN TO DISK
#unset HISTFILE
#unset HISTFILESIZE
export HISTSIZE=50000
export HISTFILESIZE=50000

rmhist(){ history -d "$1"; }
histrm(){ rmhist "$1"; }
histrmlast(){ history -d "$(history | tail -n 2 | head -n 1 | awk '{print $1}')"; }

# This adds a time format of "YYYY-mm-dd hh:mm:ss  command" to the bash history
export HISTTIMEFORMAT="%F %T  "

# stop logging duplicate successive commands to history
HISTCONTROL=ignoredups:ignorespace

# Neat trick "[ \t]*" to exclude any command by just prefixing it with a space. Fast way of going stealth for pw entering on cli
# & here means any duplicate patterns, others are simple things like built-ins and ls and stuff you don't need history for
#export HISTIGNORE="[ \t]*:&:ls:[bf]g:exit"

# append rather than overwrite history
shopt -s histappend

# check window size and update $LINES and $COLUMNS after each command
shopt -s checkwinsize

shopt -s cdspell

# prevent core dumps which can leak sensitive information
ulimit -c 0

# tighten permissions except for root where library installations become inaccessible to my user account
if [ $EUID = 0 ]; then
    umask 0022
else
    # caused no end of problems when doing sudo command which retained 0077 and broke library access for user accounts
    #umask 0077
    umask 0022
fi


# ============================================================================ #

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


#######################################################
# FUNCTIONS
#######################################################

gcom() {
	git add .
	git commit -S -m "$1"
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
addToPath "$HOME/bin"
addToPath "$HOME/.local/bin"
addToPath "$HOME/.local/bin/zig"
addToPath "$HOME/apps"
addToPath "$HOME/.eww/target/release/"
addToPath "$HOME/.cargo/bin"

# Color for manpages in less makes manpages a little easier to read
# Colored bash using starshit
eval "$(starship init bash)"

####################################################
# Aliases
##################################################
# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Eza
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
. "$HOME/.cargo/env"
. "/home/hrdina/.deno/env"
