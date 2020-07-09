# OSX Lion ssh logon:
# -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8)
export LC_CTYPE="en_US.UTF-8"

# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# http://osxdaily.com/2013/02/05/improve-terminal-appearance-mac-os-x/
# http://apple.stackexchange.com/a/33679
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -F '

# https://blog.balthazar-rouberol.com/shell-productivity-tips-and-tricks.html
set -o vi

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='hub --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Enable config autocomplete
# https://github.com/github/hub/blob/3021e584ee14ebe115a3634fe983d59f56d8e103/etc/hub.bash_completion.sh#L365
complete -o default -o nospace -F _git config

export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH="/usr/local/sbin:$PATH"
