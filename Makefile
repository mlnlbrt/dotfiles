DOTFILELIST	:=				\
	.bin					\
	.i3						\
	.i3status.conf			\
	.vimrc					\
	.vim					\
	.gitconfig				\
	.profile				\
	.Xresources				\
	.config/dunst/dunstrc	\
	.icons					\
	.themes


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

.PHONY: all install clean backup cleanbackup configure \
	configurevim vimvundle vimpluginsinstall vimpluginscompile

all: backup clean install configure

install: $(TARGET_DOTFILES)
	@echo "Installed dotfiles"

clean:
	@rm -rf $(TARGET_DOTFILES)
	@echo "Cleaned user's dotfiles"

backup: $(BACKUP_DOTFILES)
	@echo "Saved user's dotfiles backup to" $(BACKUPDIR)

cleanbackup:
	@rm -rf $(dir $(BACKUPDIR))*/
	@echo "Cleaned backups"

configure: configurevim

configurevim: vimvundle vimpluginsinstall vimpluginscompile
	@echo "Configured Vim"

vimvundle: $(HOMEDIR)/.vim/bundle/Vundle.vim

vimpluginsinstall: $(HOMEDIR)/.vim/.pluginsinstalled

vimpluginscompile: $(HOMEDIR)/.vim/.pluginscompiled


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
# It's assumed that successful compilation of Vim's plugins
# is confirmed by the dotfile created below
$(HOMEDIR)/.vim/.pluginscompiled:
	@python $(HOMEDIR)/.vim/bundle/YouCompleteMe/install.py
	@touch $@
