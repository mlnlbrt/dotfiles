DOTFILELIST 		:= 		\
	.i3		 				\
	.i3status.conf 			\
	.vimrc					\
	.vim					\
	.gitconfig				\
	.Xresources				


#############
# VARIABLES #
#############

BACKUPNAME			:= $(shell cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

HOMEDIR				:= $(shell echo ~)
BACKUPDIR			:= $(PWD)/.backup/$(BACKUPNAME)
PACKAGEDIR			:= $(PWD)

TARGET_DOTFILES		:= $(addprefix $(HOMEDIR)/, $(DOTFILELIST))
BACKUP_DOTFILES 	:= $(addprefix $(BACKUPDIR)/, $(DOTFILELIST))
PACKAGE_DOTFILES	:= $(addprefix $(PACKAGEDIR)/, $(DOTFILELIST))


###########
# TARGETS #
###########

.PHONY: all backup clean install 

all: backup clean install
	@echo $(DOTFILES)

install: $(TARGET_DOTFILES)
	@echo "Installed dotfiles"

clean:
	@rm -rf $(TARGET_DOTFILES)
	@echo "Cleaned user's dotfiles"

backup: $(BACKUP_DOTFILES)
	@echo "Saved user's dotfiles backup to" $(BACKUPDIR)


#########
# RULES #
#########

# How to make symlinks in the user's /home directory
$(TARGET_DOTFILES):
	@ln -s $(addprefix $(PACKAGEDIR)/, $(notdir $@)) $@

# How to make backup of the user's particular dotfiles
# which are affected by the package
$(BACKUP_DOTFILES):
	@mkdir -p $(BACKUPDIR)
	@cp -Lr $(addprefix $(HOMEDIR)/, $(notdir $@)) $@ 2> /dev/null || true
