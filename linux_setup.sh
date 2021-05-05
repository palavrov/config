#!/bin/bash

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
git clone -b ubuntu --bare https://github.com/palavrov/config.git $HOME/.config.git
function config {
    git --git-dir=$HOME/.config.git/ --work-tree=$HOME $@
}

function mvp () {
    dir="$2"
    tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -a "$dir" ] ||
    mkdir -p "$dir" &&
    mv "$@"
}

config checkout

if [ $? = 0 ]; then
    echo "Checked out config.";
else
    mkdir -p .config-backup
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mvp {} .config-backup/{}
fi;
config checkout
config submodule update --init --recursive
config config status.showUntrackedFiles no

# Cleanup
# rm -rf .config.git/ .bash_profile  .bashrc .gitconfig .gitmodules  .ssh/config .ssh/sockets/ .vim/ .viminfo .vimrc  osx_setup.sh README.md
