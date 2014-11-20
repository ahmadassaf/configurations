#!/usr/bin/env bash
set -e

# Find the location of the script, this brings out the location of the current directory
SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories.
SOURCE_LOCATION="$SCRIPT_DIRECTORY" # Contains the files and directories I want to work with.

sh "$SOURCE_LOCATION/update.sh"

echo "\n ============================================
            oh-my-zsh
 ============================================ \n"

if [[ -d ${HOME}/.oh-my-zsh ]]; then
	read -p "Would you like to overwrite the .oh-my-zsh files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rm -rf "${HOME}/.oh-my-zsh"
		# symlink the oh-my-zsh to the home directory
		ln -s "$SOURCE_LOCATION/oh-my-zsh" "${HOME}/.oh-my-zsh"
	fi;
fi

if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
	# symlink the oh-my-zsh to the home directory
	ln -s "$SOURCE_LOCATION/oh-my-zsh" "${HOME}/.oh-my-zsh"
fi

# The default location is ~/.oh-my-zsh (hidden in your home directory).
# You can change the install directory with the ZSH environment variable, either by running export ZSH=/your/path before installing
# or by setting it before the end of the install pipeline like this:
# curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | ZSH=~/.dotfiles/zsh sh, for use copying the .oh-my-zsh and the .zshrc will do

if [[ ! -d ${HOME}/.oh-my-zsh/zsh-syntax-highlighting ]]; then

	echo "Installing zsh Syntax highlighting ... \n"

	# Installing zsh-syntax-highlighting(https://github.com/zsh-users/zsh-syntax-highlighting), inspired by Fish's syntax highlighting
	git clone "git://github.com/zsh-users/zsh-syntax-highlighting.git" "${HOME}/.oh-my-zsh/zsh-syntax-highlighting"

fi

if [[ -f ${HOME}/.zshrc ]]; then
	read -p "Would you like to overwrite the .zshrc file in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rm "${HOME}/.zshrc"
		# now overwrite the installed .zshrc file with the one in github repo
		ln -s "$SOURCE_LOCATION/oh-my-zsh/.zshrc" "${HOME}/.zshrc"
	fi;
fi

if [[ ! -f ${HOME}/.zshrc ]]; then
	# now overwrite the installed .zshrc file with the one in github repo
	ln -s "$SOURCE_LOCATION/oh-my-zsh/.zshrc" "${HOME}/.zshrc"
fi

echo "\n ============================================
            bash-it
 ============================================ \n"

# Installing the bash-it script files by symlinking the github repo to the HOME directory

if [[ -d ${HOME}/.bash_it ]]; then
	read -p "Would you like to overwrite the .bash_it files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rm -rf "${HOME}/.bash_it"
		# symlink the oh-my-zsh to the home directory
		ln -s "$SOURCE_LOCATION/bash-it" "${HOME}/.bash_it"
	fi;
fi

if [[ ! -d ${HOME}/.bash_it ]]; then
	# symlink the oh-my-zsh to the home directory
	ln -s "$SOURCE_LOCATION/bash-it" "${HOME}/.bash_it"
fi

# run the bash-it install script
sh "${HOME}/.bash_it/install.sh"

# add the .zsh alias files by combining the general and custom alias of the bash-it

echo "Check if the .zsh custom alias contains the combination of the bash-it alias files"

read -p "Would you like to overwrite the default .zsh aliases in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	cat "${HOME}/.bash_it/aliases/available/general.aliases.bash" > "${HOME}/.oh-my-zsh/lib/aliases.zsh"
	cat "${HOME}/.bash_it/aliases/custom.aliases.bash" >> "${HOME}/.oh-my-zsh/lib/aliases.zsh"

	# remove the first two lines specific to bash-it
	sed -i -e '1,3d' "$SOURCE_LOCATION/oh-my-zsh/lib/aliases.zsh"

fi;

echo "\n ============================================
            dotfiles
 ============================================ \n"

# run the dotfiles install script
sh "$SOURCE_LOCATION/dotfiles/install.sh"




