#!/usr/bin/env bash
set -e

magenta='\033[31m'
red='\033[35m'
NC='\033[0m'

echo "\nPulling latest updates from main Github repo and all its submdoules \n";
# Pulling recent updates from the upstream and check for changes
#git pull origin master

# Pulling all the recent updates from all the submodules
#git submodule foreach git pull origin master

echo "Would you like to push back changes to forked repositories. Please enter ${red}[Forked remote name]${NC} or ${magenta}"N"${NC} to skip: " && read
echo "";
if [[ ! $REPLY =~ ^[nN]$ ]]; then
	echo "Pushing back any changes to the forket repositories\n"
	grep path .gitmodules | sed 's/.*= //' | while read -r line ; do
    if [[ $line != "gitignore" ]]; then
	    # update the forked github repo
	    echo "pushing changes on repository: ${magenta}$line${NC} on remote: ${red}$REPLY${NC}";
	    git -c $line add --all
	    git -c $line commit -m "automatic updating of repository via update script"
	    git -c $line push $REPLY master
	    sleep 10s
  	fi
	done
fi

echo "\nPushing changes on parent container repository ... "
# update the original container repo
git push origin master