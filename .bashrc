#
# ~/.bashrc
#

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Add user's scripts to path
export PATH=$PATH:$HOME/.bin

# Add /opt's exports
source /opt/exports 2> /dev/null || true

# Set default terminal, editor and browser
export TERMINAL=xterm
export EDITOR=vim
export BROWSER=chromium

# Force Eclipse to use GTK2
export SWT_GTK3=0

# Maven related exports
export M2_HOME=/usr/share/maven
export MAVEN_OPTS="-Xms256m -Xmx512m"

# Function and its alias to set a window title of a terminal
set_window_title() {
        echo -ne "\e]0;$1\007"
}
alias swt=set_window_title

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
