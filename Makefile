DOTFILELIST :=
DOTFILELIST += .bin
DOTFILELIST += .i3 .i3status.conf
DOTFILELIST += .vimrc .vim
DOTFILELIST += .local/share/applications/mimeapps.list
DOTFILELIST += .gitconfig
DOTFILELIST += .profile .Xresources .xsession
DOTFILELIST += .fonts.conf
DOTFILELIST += .icons .themes .gtkrc-2.0
DOTFILELIST += .pulse/client.conf .pulse/daemon.conf .pulse/default.pa
DOTFILELIST += .config/dunst/dunstrc
DOTFILELIST += .config/gtk-3.0/settings.ini
DOTFILELIST += .config/mpv/mpv.conf
DOTFILELIST += .surf
DOTFILELIST += .ssh/config


#############
# VARIABLES #
#############

BACKUPNAME		:= $(shell cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

HOMEDIR			:= $(shell echo ~)
BACKUPDIR		:= $(PWD)/.backup/$(BACKUPNAME)
PACKAGEDIR		:= $(PWD)

VIMDIR			:= $(addprefix $(HOMEDIR)/, .vim)
THEMESDIR		:= $(addprefix $(HOMEDIR)/, .themes)
ICONSDIR		:= $(addprefix $(HOMEDIR)/, .icons)

BACKUP_DOTFILES		:= $(addprefix $(BACKUPDIR)/, $(DOTFILELIST))
TARGET_DOTFILES		:= $(addprefix $(HOMEDIR)/, $(DOTFILELIST))

ICONS_REMOTEADDR	:= https://github.com/mlnlbrt/paper-icon-theme/trunk/Paper


###########
# TARGETS #
###########

.PHONY: all \
	backup clean install \
	installsymlinks installvimplugins installicons \
	update gitupdate

all: backup clean install

backup: $(BACKUP_DOTFILES)
	@echo "Saved the user's dotfiles backup to" $(BACKUPDIR)

clean:
	@rm -rf $(TARGET_DOTFILES)
	@rmdir -p $(filter-out $(HOMEDIR)/, $(dir $(TARGET_DOTFILES))) 2> /dev/null || true

install: installsymlinks installvimplugins installicons

installsymlinks: $(TARGET_DOTFILES)

installvimplugins: $(VIMDIR)/bundle/Vundle.vim $(VIMDIR)/.pluginsinstalled 

installicons: $(ICONSDIR)/.iconsinstalled

update: clean gitupdate install

gitupdate:
	@git fetch origin
	@git reset --hard origin/master


#########
# RULES #
#########

# How to make backup of the user's particular dotfiles
# which are affected by the package
$(BACKUP_DOTFILES):
	@mkdir -p $(dir $@)
	@cp -Lr $(addprefix $(HOMEDIR)/, $(subst $(BACKUPDIR)/,,$@)) $@ 2> /dev/null || true

# How to make symlinks in the user's /home directory
$(TARGET_DOTFILES):
	@mkdir -p $(dir $@)
	@ln -s $(addprefix $(PACKAGEDIR)/, $(subst $(HOMEDIR)/,,$@)) $@

# Get Vim's Vundle
$(VIMDIR)/bundle/Vundle.vim:
	@git clone https://github.com/VundleVim/Vundle.vim.git $@

# Install Vim's plugins
# It's assumed that the successful installation of Vim's plugins
# is confirmed by the dotfile created below
$(VIMDIR)/.pluginsinstalled:
	@vim +PluginInstall +qall
	@touch $@

# Install icons
$(ICONSDIR)/.iconsinstalled:
	@svn export $(ICONS_REMOTEADDR) $(ICONSDIR)/Paper
	@touch $@
