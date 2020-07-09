# OSX Lion ssh logon:
# -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8)
export LC_CTYPE="en_US.UTF-8"

# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# http://osxdaily.com/2013/02/05/improve-terminal-appearance-mac-os-x/
# http://apple.stackexchange.com/a/33679
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -F '

# https://blog.balthazar-rouberol.com/shell-productivity-tips-and-tricks.html
set -o vi

# https://medium.com/@thucnc/how-to-show-current-git-branch-with-colors-in-bash-prompt-380d05a24745
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
BRANCH_COLOR="\e[91m"

# https://redandblack.io/blog/2020/bash-prompt-with-updating-time/
DELIMETER_COLOR="\e[m"
DIRECTORY="\w"
DIRECTORY_COLOR="\e[33;1m"
USER="\u"
USER_COLOR="\e[36m"
HOST="\h"
HOST_COLOR="\e[32m"
DOUBLE_SPACE="  "
NEWLINE="\n"
NO_COLOUR="\e[00m"
PRINTING_OFF="\["
PRINTING_ON="\]"
PROMPT_COLOUR="\e[0;33m"
PS1_PROMPT="\$"
PS2_PROMPT=">"
RESTORE_CURSOR_POSITION="\e[u"
SAVE_CURSOR_POSITION="\e[s"
SINGLE_SPACE=" "
TIMESTAMP="\A"
TIMESTAMP_PLACEHOLDER="--:--"

move_cursor_to_start_of_ps1() {
    command_rows=$(history 1 | wc -l)
    if [ "$command_rows" -gt 1 ]; then
        let vertical_movement=$command_rows+1
    else
        command=$(history 1 | sed 's/^\s*[0-9]*\s*//')
        command_length=${#command}
        ps1_prompt_length=${#PS1_PROMPT}
        let total_length=$command_length+$ps1_prompt_length
        let lines=$total_length/${COLUMNS}+1
        let vertical_movement=$lines+1
    fi
    tput cuu $vertical_movement
}

PS0_ELEMENTS=(
    "$SAVE_CURSOR_POSITION"
    "\$(move_cursor_to_start_of_ps1)"
    "$PROMPT_COLOUR" "$TIMESTAMP" "$NO_COLOUR"
    "$RESTORE_CURSOR_POSITION"
)
export PS0=$(IFS=; echo "${PS0_ELEMENTS[*]}")

PS1_ELEMENTS=(
    # Empty line after last command.
    "$NEWLINE"
    # First line of prompt.
    "$PRINTING_OFF" "$PROMPT_COLOUR"   "$PRINTING_ON" "$TIMESTAMP" "$DOUBLE_SPACE"
    "$PRINTING_OFF" "$USER_COLOR"      "$PRINTING_ON" "$USER"
    "$PRINTING_OFF" "$DELIMETER_COLOR" "$PRINTING_ON" "@"
    "$PRINTING_OFF" "$HOST_COLOR"      "$PRINTING_ON" "$HOST"
    "$PRINTING_OFF" "$DELIMETER_COLOR" "$PRINTING_ON" ":"
    "$PRINTING_OFF" "$DIRECTORY_COLOR" "$PRINTING_ON" "$DIRECTORY"
    "$PRINTING_OFF" "$DELIMETER_COLOR" "$PRINTING_ON" "$SINGLE_SPACE"
    "$PRINTING_OFF" "$BRANCH_COLOR"    "$PRINTING_ON" "\$(parse_git_branch)"
    "$PRINTING_OFF" "$NO_COLOUR"       "$PRINTING_ON" "$NEWLINE"
    # Second line of prompt.
    "$PRINTING_OFF" "$PROMPT_COLOUR"   "$PRINTING_ON" "$PS1_PROMPT" "$SINGLE_SPACE"
    "$PRINTING_OFF" "$NO_COLOUR"       "$PRINTING_ON"
)
export PS1=$(IFS=; echo "${PS1_ELEMENTS[*]}")

PS2_ELEMENTS=(
    "$PRINTING_OFF" "$PROMPT_COLOUR"   "$PRINTING_ON" "$PS2_PROMPT" "$SINGLE_SPACE"
    "$PRINTING_OFF" "$NO_COLOUR"       "$PRINTING_ON"
)
export PS2=$(IFS=; echo "${PS2_ELEMENTS[*]}")

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='hub --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Enable config autocomplete
# https://github.com/github/hub/blob/3021e584ee14ebe115a3634fe983d59f56d8e103/etc/hub.bash_completion.sh#L365
complete -o default -o nospace -F _git config

export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH="/usr/local/sbin:$PATH"
