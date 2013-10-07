#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function _dir_short { 
perl <<-'EOF'
$_ = `pwd`; chomp;
if ($_ eq '/') {
    print '/';
} else {
    s/$ENV{HOME}/~/;
    @_ = split '/', $_;
    $_ = substr($_, 0, 1) for @_[0 .. $#_ - 2];
    print join('/', @_);
}
EOF
} 

PS1='\[\e[1;36m\]$(_dir_short)\[\e[m\]\[\e[1;37m\]>\[\e[m\] '

# autojump
source /etc/profile.d/autojump.bash

# make tab completion work better
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set completion-prefix-display-length 2"

set -o ignoreeof                 # disable Ctrl-D exit
export IGNOREEOF=1000
shopt -s checkwinsize            # line wrapping length after window resize
shopt -s no_empty_cmd_completion # don't complete on empty
shopt -s cmdhist                 # multiline cmds stored as one cmd

export PAGER=less
export EDITOR=vim

alias ls='ls --human-readable --classify --color --group-directories-first' 
alias sl=''
alias netcfg='sudo netcfg'

function run {
    nohup "$@" &> /dev/null &
}
