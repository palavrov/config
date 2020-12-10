#!/usr/bin/bash

# Show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles TRUE

# Disable Press & Hold character picker i.e. adding accents with ' and :
defaults write -g ApplePressAndHoldEnabled -bool false

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew tap codigi/homebrew-codigi
brew install bash-completion
brew install firefox opera google-chrome vivaldi brave-browser dissenter-browser
brew install skype viber telegram telegram-desktop amazon-chime zoomus slack
brew install deepl
brew install stremio kodi spotify
brew install gog-galaxy

# Development
brew install vim visual-studio-code
brew install git hub bash-git-prompt git-gui git-delta
brew install unrar xz
brew install nodejs sqlite
brew install binwalk lsusb minicom nmap wget
brew install hex-fiend meld xquartz
brew install paragon-ntfs paragon-extfs
brew install prolific-pl2303 ftdi-vcp-driver wch-ch34x-usb-serial-driver
brew install gcc-arm-embedded gdbm
brew install --cask balenaetcher bluetility packetsender saleae-logic wireshark
# Segger tools
brew install --cask segger-embedded-studio-for-arm segger-jlink segger-ozone
# Nordic tools
brew install --cask nordic-nrf-command-line-tools nordic-nrf-connect
# Android development
brew install --cask openjdk android-file-transfer android-sdk android-platform-tools android-studio android-ndk

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
