# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Add user's scripts to path
export PATH=$PATH:$HOME/.bin

# Add /opt's exports
source /opt/exports 2> /dev/null || true

# Set default editor and browser
export EDITOR=vim
export BROWSER=vimb

# Force Eclipse to use GTK2
export SWT_GTK3=0

# Maven related exports
export M2_HOME=/usr/share/maven
export MAVEN_OPTS="-Xms256m -Xmx512m"
