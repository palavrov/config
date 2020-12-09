#!/usr/bin/bash

# Show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles TRUE

# Disable Press & Hold character picker i.e. adding accents with ' and :
defaults write -g ApplePressAndHoldEnabled -bool false

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew tap codigi/homebrew-codigi
brew install nodejs git hub bash-completion
brew install --with-override-system-vi vim
brew cask install firefox opera google-chrome vivaldi
brew cask install skype viber telegram telegram-desktop
brew cask install slack
brew cask install stremio kodi spotify

brew install yarn
yarn global add yarn-completions

# Development
brew install binwalk lsusb minicom
brew cask install pl2303 paragon-ntfs paragon-extfs

# Android development
# brew cask install java
# brew install android-sdk

# TTK QT development
# brew install qt5 --with-qtwebkit
# brew link --force qt5
# sudo ln -s -f /usr/local/Cellar/qt5/5.9.1/mkspecs /usr/local/mkspecs
# sudo ln -s -f /usr/local/Cellar/qt5/5.9.1/plugins /usr/local/plugins
# brew install boost qtftp tufao

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
hub clone --bare palavrov/config $HOME/.cfg
function config {
    hub --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
config checkout
if [ $? = 0 ]; then
    echo "Checked out config.";
else
    mkdir -p .config-backup
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config submodule update --init --recursive
config config status.showUntrackedFiles no

# Setup VIM

# cd ~/.vim/pack/common/start/tern_for_vim && npm install
# cd ~/.vim/pack/common/start/vim-js-context-coloring && npm install

# Cleanup
# rm -rf .cfg/ .bash_profile  .bashrc .gitconfig .gitmodules  .ssh/config .ssh/sockets/ .vim/ .viminfo .vimrc  osx_setup.sh README.md
