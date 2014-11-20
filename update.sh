#!/usr/bin/env bash

# Find the location of the script, this brings out the location of the current directory
SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories.
SOURCE_LOCATION="$SCRIPT_DIRECTORY" # Contains the files and directories I want to work with.

echo "\nPulling latest updates from main Github repo and all its submdoules \n";
# Pulling recent updates from the upstream and check for changes
git pull --recurse-submodules origin master

echo "Would you like to push back changes to forked repositories. Please enter ${red}[Forked remote name]${NC} or ${magenta}"N"${NC} to skip: " && read
echo "";
if [[ ! $REPLY =~ ^[nN]$ ]]; then
	echo "Pushing back any changes to the forket repositories\n"
	grep path .gitmodules | sed 's/.*= //' | while read -r line ; do
    if [[ $line != "gitignore" ]]; then
	    # update the forked github repo
	    echo "pushing changes on repository: ${magenta}$line${NC} on remote: ${red}$REPLY${NC}";
	    #git -C "$SOURCE_LOCATION/$line" status
	    git -C "$SOURCE_LOCATION/$line" add --all
	    git -C "$SOURCE_LOCATION/$line" commit -m "automatic updating of repository via update script"
	    git -C "$SOURCE_LOCATION/$line" push "$REPLY" master
  	fi
	done
fi

echo "\nPushing changes on parent container repository ... "
# update the original container repo
git push origin master