DOTFILELIST :=
DOTFILELIST += .bin
DOTFILELIST += .i3 .i3status.conf
DOTFILELIST += .vimrc .vim
DOTFILELIST += .local/share/applications/mimeapps.list
DOTFILELIST += .gitconfig
DOTFILELIST += .profile .Xresources
DOTFILELIST += .fonts.conf
DOTFILELIST += .icons .themes .gtkrc-2.0
DOTFILELIST += .pulse/client.conf .pulse/daemon.conf .pulse/default.pa
DOTFILELIST += .config/dunst/dunstrc
DOTFILELIST += .config/firejail
DOTFILELIST += .config/gtk-3.0/settings.ini
DOTFILELIST += .config/mpv/mpv.conf
DOTFILELIST += .config/vimb/config
DOTFILELIST += .ncmpcpp/config
DOTFILELIST += .ssh/config


#############
# VARIABLES #
#############

BACKUPNAME		:= $(shell cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

HOMEDIR			:= $(shell echo ~)
BACKUPDIR		:= $(PWD)/.backup/$(BACKUPNAME)
PACKAGEDIR		:= $(PWD)

TARGET_DOTFILES		:= $(addprefix $(HOMEDIR)/, $(DOTFILELIST))
BACKUP_DOTFILES		:= $(addprefix $(BACKUPDIR)/, $(DOTFILELIST))
PACKAGE_DOTFILES	:= $(addprefix $(PACKAGEDIR)/, $(DOTFILELIST))

ICONS_REMOTEADDR	:= https://github.com/snwh/paper-icon-theme/trunk/Paper
THEMES_REMOTEADDR	:= https://github.com/snwh/paper-gtk-theme/trunk/Paper


###########
# TARGETS #
###########

.PHONY: \
	all backup clean update gitupdate install \
	installsymlinks \
	installvimplugins \
	installgtktheme \
	installicons

all: backup clean install

backup: $(BACKUP_DOTFILES)
	@echo "Saved the user's dotfiles backup to" $(BACKUPDIR)

clean:
	@rm -rf $(TARGET_DOTFILES)

update: clean gitupdate install

gitupdate:
	@git fetch origin
	@git reset --hard origin/master

install: installsymlinks installvimplugins installgtktheme installicons

installsymlinks: $(TARGET_DOTFILES)

installvimplugins: \
	$(HOMEDIR)/.vim/bundle/Vundle.vim \
	$(HOMEDIR)/.vim/.pluginsinstalled \
	$(HOMEDIR)/.vim/.pluginscompiled

installgtktheme: $(HOMEDIR)/.themes/.themesinstalled

installicons: $(HOMEDIR)/.icons/.iconsinstalled


#########
# RULES #
#########

# How to make symlinks in the user's /home directory
$(TARGET_DOTFILES):
	@mkdir -p $(dir $@)
	@ln -s $(addprefix $(PACKAGEDIR)/, $(subst $(HOMEDIR)/,,$@)) $@

# How to make backup of the user's particular dotfiles
# which are affected by the package
$(BACKUP_DOTFILES):
	@mkdir -p $(dir $@)
	@cp -Lr $(addprefix $(HOMEDIR)/, $(subst $(BACKUPDIR)/,,$@)) $@ 2> /dev/null || true

# Obtain Vim's Vundle
$(HOMEDIR)/.vim/bundle/Vundle.vim:
	@git clone https://github.com/VundleVim/Vundle.vim.git $@

# Install Vim's plugins
# It's assumed that successful installation of Vim's plugins
# is confirmed by the dotfile created below
$(HOMEDIR)/.vim/.pluginsinstalled:
	@vim +PluginInstall +qall
	@touch $@

# Compile Vim's plugins
$(HOMEDIR)/.vim/.pluginscompiled:
	@python $(HOMEDIR)/.vim/bundle/YouCompleteMe/install.py
	@touch $@

# Install GTK theme
$(HOMEDIR)/.themes/.themesinstalled:
	@svn export $(THEMES_REMOTEADDR) $(HOMEDIR)/.themes/Paper
	@touch $@

# Install icons
$(HOMEDIR)/.icons/.iconsinstalled:
	@svn export $(ICONS_REMOTEADDR) $(HOMEDIR)/.icons/Paper
	@touch $@
