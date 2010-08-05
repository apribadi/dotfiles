# Exit if we're in a script
[ -z "$PS1" ] && return

# prompt
PS1='\[\e[1;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]>\[\e[m\] '

set -o vi
export EDITOR=vim
export HISTCONTROL=ignoredups
shopt -s checkwinsize

. /etc/bash_completion      # Enable good bash completion
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"

shopt -s cdspell                 # transparently corrects cmd spelling
shopt -s no_empty_cmd_completion # don't complete on empty
shopt -s cmdhist                 # multiline cmds stored as one cmd

# Aliases
alias ls='ls -hF --color'
