# Setup Dotfile Tracking

Beforehand
- Setup Git
- Learn how Git commands work

### Setup:
This creates a bare git repo for you to link where your files are

	git init --bare $HOME/.dotfiles

Creates an alias 'dotfiles' to skip having to write out the full git line over and over

	alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

Stops untracked files from showing up in your status and searches

	dotfiles config --local status.showUntrackedFiles no

Adds the alias to your .zshrc file, recreating it for every shell session.

	echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc

#### Things to Remember
Need to setup the repo on your account
	
	dotfiles remote add https://github.com/UserName/RepoName.git

And then to push the first time, and set up the generic git push system
	
	dotfiles push --set-upstream origin master

### Usage: 
Usage is pretty much exactly like using git. All of these commands work exactly the same, but you use dotfiles not git.

	dotfiles status
	dotfiles add .vimrc
	dotfiles commit -m "Add vimrc"
	dotfiles add .bashrc
	dotfiles commit -m "Add bashrc"
	dotfiles push

TODO
### New Machine:

	alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
	echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
	echo ".dotfiles" >> .gitignore
	git clone --bare <git-repo-url> $HOME/.dotfiles
	dotfiles checkout
	dotfiles config --local status.showUntrackedFiles no

https://www.atlassian.com/git/tutorials/dotfiles
