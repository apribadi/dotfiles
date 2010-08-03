# Exit if we're in a script
[ -z "$PS1" ] && return

# Bash prompt
PS1='[\u@\h \W]\$ '

# Set vi mode
set -o vi
export EDITOR=vim

. /etc/bash_completion      # Enable good bash completion
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"

shopt -s cdspell                 # transparently corrects cmd spelling
shopt -s no_empty_cmd_completion # don't complete on empty
shopt -s cmdhist                 # multiline cmds stored as one cmd

# Aliases
alias ls='ls -hF --color'
