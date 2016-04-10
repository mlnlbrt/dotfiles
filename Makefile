DOTFILELIST :=
DOTFILELIST += .bin
DOTFILELIST += .i3 .i3status.conf
DOTFILELIST += .vimrc .vim
DOTFILELIST += .gitconfig
DOTFILELIST += .profile .Xresources
DOTFILELIST += .icons .themes .gtkrc-2.0
DOTFILELIST += .config/dunst/dunstrc


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

ICONS_GITADDR	:= https://github.com/snwh/paper-icon-theme/trunk/Paper 
THEMES_GITADDR	:= https://github.com/snwh/paper-gtk-theme/trunk/Paper 


###########
# TARGETS #
###########

.PHONY: all install clean backup update reset configure \
	installsymlinks installvimvundle installvimplugins \
	cleanbackup \
	configurevim configurevimplugins

all: backup clean install configure

install: installsymlinks \
	installvimvundle installvimplugins \
	installgtktheme installicons \

installsymlinks: $(TARGET_DOTFILES)
	@echo "Installed symlinks"

installvimvundle: $(HOMEDIR)/.vim/bundle/Vundle.vim

installvimplugins: $(HOMEDIR)/.vim/.pluginsinstalled

installgtktheme: $(HOMEDIR)/.themes/.themesinstalled

installicons: $(HOMEDIR)/.icons/.iconsinstalled

clean:
	@rm -rf $(TARGET_DOTFILES)
	@echo "Cleaned user's dotfiles"

backup: $(BACKUP_DOTFILES)
	@echo "Saved user's dotfiles backup to" $(BACKUPDIR)

cleanbackup:
	@rm -rf $(dir $(BACKUPDIR))*/
	@echo "Cleaned backups"

update: clean reset install

reset:
	@git fetch origin
	@git reset --hard origin/master

configure: configurevim

configurevim: compilevimplugins

compilevimplugins: $(HOMEDIR)/.vim/.pluginscompiled


#########
# RULES #
#########

# How to make symlinks in the user's /home directory
$(TARGET_DOTFILES):
	@mkdir -p $(dir $(subst $(HOMEDIR)/,,$@))
	@ln -s $(addprefix $(PACKAGEDIR)/, $(subst $(HOMEDIR)/,,$@)) $@

# How to make backup of the user's particular dotfiles
# which are affected by the package
$(BACKUP_DOTFILES):
	@mkdir -p $(dir $@)
	@cp -Lr $(addprefix $(HOMEDIR)/, $(subst $(BACKUPDIR)/,,$@)) $@ 2> /dev/null || true

# Obtain Vim's Vundle
$(HOMEDIR)/.vim/bundle/Vundle.vim:
	@git clone https://github.com/VundleVim/Vundle.vim.git $@
	@echo "Installed Vim Vundle"

# Install Vim's plugins
# It's assumed that successful installation of Vim's plugins
# is confirmed by the dotfile created below
$(HOMEDIR)/.vim/.pluginsinstalled:
	@vim +PluginInstall +qall
	@touch $@
	@echo "Installed Vim plugins"

# Compile Vim's plugins
$(HOMEDIR)/.vim/.pluginscompiled:
	@python $(HOMEDIR)/.vim/bundle/YouCompleteMe/install.py
	@touch $@
	@echo "Configured Vim"

# Install GTK theme
$(HOMEDIR)/.themes/.themesinstalled:
	@svn export $(THEMES_GITADDR) $(HOMEDIR)/.themes/Paper
	@touch $@
	@echo "Installed themes"

# Install icons 
$(HOMEDIR)/.icons/.iconsinstalled:
	@svn export $(ICONS_GITADDR) $(HOMEDIR)/.icons/Paper
	@touch $@
	@echo "Installed icons"
