# Exit if we're in a script
[ -z "$PS1" ] && return

if [ -n "$IS_LOGIN_SHELL" ]; then
    # save path
    export OLDPATH=$PATH
fi

#
# Things for the interactive shell.
#

export PATH="\
$HOME/admin/4ti2/bin\
:$HOME/prog/go/bin\
:$HOME/rsc/bin\
:$HOME/admin/bin\
:$HOME/.lein/bin\
:$HOME/.luarocks/bin\
:$HOME/prog/julia/julia\
:$HOME/prog/jdbctool-1.0/bin\
:$HOME/node_modules/.bin\
:/opt/go/bin\
:/opt/openoffice/program\
:/opt/singular/bin\
:/usr/local/games/WorldOfGoo\
:$OLDPATH\
"

# compress directory components
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

# shell prompt
if [[ "$USER" == 'apribadi' && "$HOSTNAME" == 'bywater' ]]; then
    PS1='\[\e[1;36m\]$(_dir_short)\[\e[m\] \[\e[1;37m\]>\[\e[m\] '
else
    PS1='\[\e[32m\]\u\[\e[34m\] \[\e[32m\]\h\[\e[m\] \[\e[0;36m\]$(_dir_short)\[\e[m\] \[\e[0;37m\]>\[\e[m\] '
fi

# autojump
source /etc/profile.d/autojump.bash
# already in /etc/bash.bashrc
# [ -r /etc/bash_completion   ] && . /etc/bash_completion


# make tab completion work better
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set completion-prefix-display-length 2"

export EDITOR=vim
export BROWSER=chromium
export HISTFILESIZE=10000
export PAGER=less
set -o vi
set -o ignoreeof                 # disable Ctrl-D exit
export IGNOREEOF=1000
shopt -s checkwinsize            # line wrapping length after window resize
shopt -s cdspell                 # transparently corrects cmd spelling
shopt -s no_empty_cmd_completion # don't complete on empty
shopt -s cmdhist                 # multiline cmds stored as one cmd

# make some of my programs autocomplete
complete -cf run # commands and files

# Aliases
alias ls='ls --human-readable --classify --color --group-directories-first'
alias ..='cd ..'
alias ikarus=ikarus_wrap
alias factor='rlwrap factor-vm -run=listener'
alias ipython='ipython --no-confirm-exit --classic'
alias sl=''
alias netcfg='sudo netcfg'
alias wifi-select='sudo wifi-select'
alias csi='rlwrap csi'

function ea {
    ssh -l east ea.st.hmc.edu
}

function et {
    open $@pdf
    vim $@tex
}

# GUI look/feel
export OOO_FORCE_DESKTOP=gnome

# misc programming languages
export CLASSPATH=/usr/share/java/junit.jar
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export IKARUS_LIBRARY_PATH=$HOME/prog/lib/ikarus:$HOME/prog/lib/ikarus/nausicaa/lib/nausicaa
export FACTOR_ROOTS="$HOME/prog/factor/root"
export PERL5LIB="$HOME/perl5/lib/perl5"
export GOPATH=$HOME/prog/go
export CHICKEN_REPOSITORY=$HOME/prog/chicken/eggs

# perl local::lib
export PERL_LOCAL_LIB_ROOT="/home/apribadi/perl5";
export PERL_MB_OPT="--install_base /home/apribadi/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/apribadi/perl5";
export PERL5LIB="/home/apribadi/perl5/lib/perl5/i686-linux-thread-multi:/home/apribadi/perl5/lib/perl5:$PERL5LIB";
export PATH="/home/apribadi/perl5/bin:$PATH";

