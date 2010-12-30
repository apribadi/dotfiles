# Exit if we're in a script
[ -z "$PS1" ] && return

source /etc/profile.d/autojump.bash

# prompt
PS1='\[\e[1;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]>\[\e[m\] '


set -o vi
export EDITOR=vim
export HISTCONTROL=ignoredups
shopt -s checkwinsize

. /etc/bash_completion
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"


shopt -s cdspell                 # transparently corrects cmd spelling
shopt -s no_empty_cmd_completion # don't complete on empty
shopt -s cmdhist                 # multiline cmds stored as one cmd
set -o ignoreeof # disable Ctrl-D exit

# Aliases
alias ls='ls -hF --color --group-directories-first'
alias android=/opt/android-sdk/tools/android

# Path
if [ -z $SET_PATH ]; then
    MORE="\
:/opt/openoffice/program\
:/usr/local/bin\
:~/admin/bin\
:/opt/go/bin\
:/usr/local/games/WorldOfGoo\
:~/09-10/op_sys/os161-support/tools/bin\
:~/09-10/op_sys/os161-support/bin\
:~/09-10/op_sys/os161-support/tools/bin\
:~/09-10/op_sys/os161-support/bin\
    "
    export PATH=$PATH$MORE
    export CLASSPATH=$CLASSPATH:/usr/share/java/junit.jar
    export SET_PATH=1
fi

# program specific
export OOO_FORCE_DESKTOP=gnome
export PACMAN=pacman-color
#export PYTHONDONTWRITEBYTECODE=

