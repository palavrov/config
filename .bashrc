# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

######## APA

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
C_BRANCH="\e[91m"

# https://redandblack.io/blog/2020/bash-prompt-with-updating-time/
C_DELIMETER="\e[m"
T_DIRECTORY="\w"
C_DIRECTORY="\e[33;1m"
T_USER="\u"
C_USER="\e[36m"
T_HOST="\h"
C_HOST="\e[32m"
T_DOUBLE_SPACE="  "
T_NEWLINE="\n"
NO_COLOR="\e[00m"
PRINTING_OFF="\["
PRINTING_ON="\]"
C_PROPMT="\e[0;33m"
PS1_PROMPT="\$"
PS2_PROMPT=">"
RESTORE_CURSOR_POSITION="\e[u"
SAVE_CURSOR_POSITION="\e[s"
T_SPACE=" "
T_TIMESTAMP="\A"
T_TIMESTAMP_PLACEHOLDER="--:--"

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
    "$C_PROPMT" "$T_TIMESTAMP" "$NO_COLOR"
    "$RESTORE_CURSOR_POSITION"
)
export PS0=$(IFS=; echo "${PS0_ELEMENTS[*]}")

PS1_ELEMENTS=(
    # Empty line after last command.
    "$T_NEWLINE"
    # First line of prompt.
    "$PRINTING_OFF" "$C_PROPMT"    "$PRINTING_ON" "$T_TIMESTAMP" "$T_DOUBLE_SPACE"
    "$PRINTING_OFF" "$C_USER"      "$PRINTING_ON" "$T_USER"
    "$PRINTING_OFF" "$C_DELIMETER" "$PRINTING_ON" "@"
    "$PRINTING_OFF" "$C_HOST"      "$PRINTING_ON" "$T_HOST"
    "$PRINTING_OFF" "$C_DELIMETER" "$PRINTING_ON" ":"
    "$PRINTING_OFF" "$C_DIRECTORY" "$PRINTING_ON" "$T_DIRECTORY"
    "$PRINTING_OFF" "$C_DELIMETER" "$PRINTING_ON" "$T_SPACE"
    "$PRINTING_OFF" "$C_BRANCH"    "$PRINTING_ON" "\$(parse_git_branch)"
    "$PRINTING_OFF" "$NO_COLOR"    "$PRINTING_ON" "$T_NEWLINE"
    # Second line of prompt.
    "$PRINTING_OFF" "$C_PROPMT" "$PRINTING_ON" "$PS1_PROMPT" "$T_SPACE"
    "$PRINTING_OFF" "$NO_COLOR" "$PRINTING_ON"
)
export PS1=$(IFS=; echo "${PS1_ELEMENTS[*]}")

PS2_ELEMENTS=(
    "$PRINTING_OFF" "$C_PROPMT" "$PRINTING_ON" "$PS2_PROMPT" "$T_SPACE"
    "$PRINTING_OFF" "$NO_COLOR" "$PRINTING_ON"
)
export PS2=$(IFS=; echo "${PS2_ELEMENTS[*]}")

shopt -s histverify

# https://stackoverflow.com/a/3539630/168872
export EDITOR=vim

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

# Enable config autocomplete
# https://github.com/github/hub/blob/3021e584ee14ebe115a3634fe983d59f56d8e103/etc/hub.bash_completion.sh#L365
complete -o default -o nospace -F __git_wrap__git_main config

export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK_HOME=/usr/local/share/android-ndk
export PATH="/usr/local/sbin:$PATH"
