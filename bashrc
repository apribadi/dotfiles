# Exit if we're in a script
[ -z "$PS1" ] && return


# jump!
source /etc/profile.d/autojump.bash

# already in /etc/bash.bashrc
# [ -r /etc/bash_completion   ] && . /etc/bash_completion

# compresses directory components
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

# prompt
if [[ "$USER" == 'apribadi' && "$HOSTNAME" == 'bywater' ]]; then
    PS1='\[\e[1;36m\]$(_dir_short)\[\e[m\] \[\e[1;37m\]>\[\e[m\] '
else
    PS1='\[\e[32m\]\u\[\e[34m\] \[\e[32m\]\h\[\e[m\] \[\e[1;36m\]$(_dir_short)\[\e[m\] \[\e[1;37m\]>\[\e[m\] '

fi



# make tab completion work better
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"

export EDITOR=vim
export HISTFILESIZE=10000
set -o vi
set -o ignoreeof                 # disable Ctrl-D exit
shopt -s checkwinsize            # line wrapping length after window resize
shopt -s cdspell                 # transparently corrects cmd spelling
shopt -s no_empty_cmd_completion # don't complete on empty
shopt -s cmdhist                 # multiline cmds stored as one cmd

# Aliases
alias ls='ls -hF --color --group-directories-first'
alias ..='cd ..'
alias ikarus=ikarus_wrap
alias py='ipython3 --no-confirm-exit --classic'

# Path
if [ -z $SET_PATH ]; then
    MORE="\
:/opt/openoffice/program\
:/usr/local/bin\
:$HOME/admin/bin\
:/opt/go/bin\
:/usr/local/games/WorldOfGoo\
:/usr/bin/vendor_perl
"
    export PATH=$PATH$MORE
    export SET_PATH=1
fi

export CLASSPATH=/usr/share/java/junit.jar
export IKARUS_LIBRARY_PATH=$HOME/prog/lib/ikarus:$HOME/prog/lib/ikarus/nausicaa/lib/nausicaa

# program specific
export OOO_FORCE_DESKTOP=gnome

