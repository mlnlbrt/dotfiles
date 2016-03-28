DOTFILELIST	:=	\
	.bin \
	.i3	\
	.i3status.conf \
	.vimrc	\
	.vim \
	.gitconfig	\
	.profile \
	.Xresources	\
	.config/dunst/dunstrc \
	.icons \
	.themes \
	.gtkrc-2.0


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


###########
# TARGETS #
###########

.PHONY: all install clean backup configure \
	installsymlinks installvimvundle installvimplugins \
	cleanbackup	\
	configurevim configurevimplugins

all: backup clean install configure

install: installsymlinks \
	installvimvundle installvimplugins \
	installgtktheme installicons

installsymlinks: $(TARGET_DOTFILES)
	@echo "Installed symlinks"

installvimvundle: $(HOMEDIR)/.vim/bundle/Vundle.vim
	@echo "Installed Vim Vundle"

installvimplugins: $(HOMEDIR)/.vim/.pluginsinstalled
	@echo "Installed Vim plugins"

installgtktheme: $(HOMEDIR)/.themes/.themesinstalled
	@echo "Installed gtk theme"

installicons: $(HOMEDIR)/.icons/.iconsinstalled
	@echo "Installed icons"

clean:
	@rm -rf $(TARGET_DOTFILES)
	@echo "Cleaned user's dotfiles"

backup: $(BACKUP_DOTFILES)
	@echo "Saved user's dotfiles backup to" $(BACKUPDIR)

cleanbackup:
	@rm -rf $(dir $(BACKUPDIR))*/
	@echo "Cleaned backups"

configure: configurevim

configurevim: compilevimplugins
	@echo "Configured Vim"

compilevimplugins: $(HOMEDIR)/.vim/.pluginscompiled


#########
# RULES #
#########

# How to make symlinks in the user's /home directory
$(TARGET_DOTFILES):
	@ln -s $(addprefix $(PACKAGEDIR)/, $(notdir $@)) $@

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
	@svn export https://github.com/snwh/paper-gtk-theme/trunk/Paper $(HOMEDIR)/.themes/Paper
	@touch $@

# Install icons 
$(HOMEDIR)/.icons/.iconsinstalled:
	@svn export https://github.com/snwh/paper-icon-theme/trunk/Paper $(HOMEDIR)/.icons/Paper
	@touch $@
