#!/usr/bin/env bash
set -e

echo "\n ===========================================================
            ${magenta}Installing Machine Configurations${NC}
 =========================================================== \n"

# Colors and visual Configurations
export magenta='\033[35m'
export red='\033[31m'
export NC='\033[0m'
export BLINK='\033[5m'
export NORMAL='\033[0'

# Find the location of the script, this brings out the location of the current directory
export SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories.
export SOURCE_LOCATION="$SCRIPT_DIRECTORY" # Contains the files and directories I want to work with.

echo "${BLINK}${red}Please skip the update if this is a fresh install...${NC}"
read -p "Would you like to run an update on all the modules. Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Call the update script to check for any changes in the repos and fetch them
	sh "$SOURCE_LOCATION/update.sh"
fi

echo "\n ============================================
                ${red}oh-my-zsh${NC}
 ============================================ \n"

if [[ -d ${HOME}/.oh-my-zsh ]]; then
	read -p "Would you like to overwrite the .oh-my-zsh files in your home directory. Are you sure? [Y/N] " -n 1;
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
	read -p "Would you like to install zsh-syntax-highlighting ? [Y/N] " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then

		echo "Installing ${magenta}zsh Syntax highlighting${NC} ... \n"

		# Installing zsh-syntax-highlighting(https://github.com/zsh-users/zsh-syntax-highlighting), inspired by Fish's syntax highlighting
		git clone "git://github.com/zsh-users/zsh-syntax-highlighting.git" "${HOME}/.oh-my-zsh/zsh-syntax-highlighting"

		# Add the submodule so that it will refreshed on future updates
		touch "${HOME}/.oh-my-zsh/.gitmodules"

		echo "[submodule \"zsh-syntax-highlighting\"]
		path = zsh-syntax-highlighting
		url = https://github.com/zsh-users/zsh-syntax-highlighting.git" >> "${HOME}/.oh-my-zsh/.gitmodules"

		# activate zsh-syntax-highlighting by adding to source
		echo "\n\nsource ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "${HOME}/.zshrc"
	fi
fi

if [[ ! -f ${HOME}/.zshrc ]]; then
	# now overwrite the installed .zshrc file with the one in github repo
	ln -s "$SOURCE_LOCATION/oh-my-zsh/.zshrc" "${HOME}/.zshrc"
  else
	  read -p "Would you like to overwrite the .zshrc file in your home directory. Are you sure? [Y/N] " -n 1;
		echo "";
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			rm "${HOME}/.zshrc"
			# now overwrite the installed .zshrc file with the one in github repo
			ln -s "$SOURCE_LOCATION/oh-my-zsh/.zshrc" "${HOME}/.zshrc"
		fi;
fi

echo "\n ============================================
                ${red}bash-it${NC}
 ============================================ \n"

# Installing the bash-it script files by symlinking the github repo to the HOME directory

if [[ -d ${HOME}/.bash_it ]]; then
	read -p "Would you like to overwrite the .bash_it files in your home directory. Are you sure? [Y/N] " -n 1;
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

echo ""
echo "Checking if the ${red}.zsh${NC} custom alias contains the ${magenta}combination of the bash-it alias files${NC}"

read -p "Would you like to overwrite the default .zsh aliases in your home directory. Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	cat "${HOME}/.bash_it/aliases/available/general.aliases.bash" > "${HOME}/.oh-my-zsh/lib/aliases.zsh"
	cat "${HOME}/.bash_it/aliases/custom.aliases.bash" >> "${HOME}/.oh-my-zsh/lib/aliases.zsh"

	# remove the first two lines specific to bash-it
	sed -i -e '1,3d' "$SOURCE_LOCATION/oh-my-zsh/lib/aliases.zsh"

fi;

echo "\n ============================================
                ${red}dotfiles${NC}
 ============================================ \n"

# run the dotfiles install script
sh "$SOURCE_LOCATION/dotfiles/install.sh"

read -p "This will install Homebrew and the files defined in the brewfile. Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Installing brew files
	echo "Installing brew files configured in the ${magenta}.brewfile:"
	sh "${HOME}/.brewfile.sh"
fi

# Installing brew cask files
read -p "This will install the applications in the caskfile Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "Installing brew cask files configured in the ${magenta}.caskile:"
	sh "${HOME}/.caskfile.sh"
fi

echo "\n ============================================
                ${red}Themes${NC}
 ============================================ \n"
# run the themes install script
sh "$SOURCE_LOCATION/themes/install.sh"

# Installing brew cask files
read -p "This will apply system-wide modifications by applying the .osx file. Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sh "${HOME}/.osx"
fi

echo "\n ============================================
                ${red}Powerline Fonts${NC}
 ============================================ \n"

read -p "This will install Powerline Fonts. Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sh "$SOURCE_LOCATION/Powerline-fonts/install.sh"
fi

read -p "This will set the bash to the updated version installed by Homebrew. Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	chsh "/usr/local/Cellar/bash/4.3.30/bin/bash"
fi

read -p "This will install Emojis for terminal. Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo sh -c "curl https://raw.githubusercontent.com/mrowa44/emojify/master/emojify -o /usr/local/bin/emojify && chmod +x /usr/local/bin/emojify"
fi

echo "\n ${magenta}Enjoy the new configurations ....${NC}\n"

############################## HELPER FUNCTION ##################################

# Given strings containing space-delimited words A and B, "setdiff A B" will
# return all words in A that do not exist in B. Arrays in bash are insane
# (and not in a good way).
# From http://stackoverflow.com/a/1617303/142339
function setdiff() {
  local debug skip a b
  if [[ "$1" == 1 ]]; then debug=1; shift; fi
  if [[ "$1" ]]; then
    local setdiffA setdiffB setdiffC
    setdiffA=($1); setdiffB=($2)
  fi
  setdiffC=()
  for a in "${setdiffA[@]}"; do
    skip=
    for b in "${setdiffB[@]}"; do
      [[ "$a" == "$b" ]] && skip=1 && break
    done
    [[ "$skip" ]] || setdiffC=("${setdiffC[@]}" "$a")
  done
  [[ "$debug" ]] && for a in setdiffA setdiffB setdiffC; do
    echo "$a ($(eval echo "\${#$a[*]}")) $(eval echo "\${$a[*]}")" 1>&2
  done
  [[ "$1" ]] && echo "${setdiffC[@]}"
}

export -f setdiff

