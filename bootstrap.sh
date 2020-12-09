
#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;
git submodule update --init

function doIt() {
	exclude_options=""
  if [ -d ~/.vim/janus ]; then
		exclude_options="--exclude .vimrc --exclude .vim --exclude .gvimrc"
		echo "Warning! I stopped using Janus, please uninstall it, or simply copy .vim* over manually"
  fi
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "EXAMPLES.md" --exclude "LICENSE-MIT.txt" ${exclude_options} -avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;