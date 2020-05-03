# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't wait for job termination notification
 set -o notify

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
 shopt -s cdspell

# History Options
# ###############
# HISTCONTROL (man 1 bash)
# ignoreboth    causes Bash not to store duplicate commands in history.
# ignorespace   to use a space to precede any command you don't want to remember in history.
# ignoredups    setting ignores repeated lines
# erasedups If that's set, no duplicates get entered in bash history at all (works on bash 3 or avove)
export HISTCONTROL=ignoredups:ignorespace:ignoreboth:erasedups
export HISTTIMEFORMAT="%h %d %H:%M:%S> "
export HISTFILE="$HOME/.bash_history_`hostname`"   # hostname appended to bash history filename
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:pwd:&:cd ~:cd ..:h:history' # Ignore the ls command as well

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#  number of commands to save in a history list.
# HISTSIZE: The number of commands to remember in the command history. The default value is 500.
HISTSIZE=5000                                       # bash history will save N commands
HISTFILESIZE=2000                                   # bash will remember N commands (number of lines)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Custom prompt with git support
color_prompt=yes

if [ "$color_prompt" = yes ]; then

  # GIT y git-completion.bash
  if [ -f ${HOME}/.git-completion.sh ]; then
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="auto"
    source ${HOME}/.git-completion.sh
  fi

  if [ -f ${HOME}/.custom_prompt.sh ]; then
    source ${HOME}/.custom_prompt.sh
  fi

else
    PS1='\n(\u\)-(jobs:\j)-(\w)\n(! \!)->  '
fi

unset color_prompt


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f "${HOME}/.bash_aliases" ]; then
   . ${HOME}/.bash_aliases
fi

# Functions definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_functions, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f "${HOME}/.bash_functions" ]; then
   . ${HOME}/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Para que complete después de sudo:
complete -cf sudo

# Deactivate PANGO (font and script smoothing library) to increase firefox rendering speed
export MOZ_DISABLE_PANGO=1

# Less Colors for Man Pages
#export LESS_TERMCAP_mb=$'\E[01;31m'                # begin blinking
#export LESS_TERMCAP_md=$'\E[01;38;5;74m'           # begin bold
#export LESS_TERMCAP_me=$'\E[0m'                    # end mode
#export LESS_TERMCAP_se=$'\E[0m'                    # end standout-mode
#export LESS_TERMCAP_so=$'\E[38;5;246m'             # begin standout-mode - info box
#export LESS_TERMCAP_ue=$'\E[0m'                    # end underline
#export LESS_TERMCAP_us=$'\E[04;38;5;146m'          # begin underline

# Get color support for 'less' & Man pages
# ###############
# tput Color Capabilities:

# tput setab [1-7] - Set a background color using ANSI escape
# tput setb [1-7] - Set a background color
# tput setaf [1-7] - Set a foreground color using ANSI escape
# tput setf [1-7] - Set a foreground color
# tput Text Mode Capabilities:

# tput bold - Set bold mode
# tput dim - turn on half-bright mode
# tput smul - begin underline mode
# tput rmul - exit underline mode
# tput rev - Turn on reverse mode
# tput smso - Enter standout mode (bold on rxvt)
# tput rmso - Exit standout mode
# tput sgr0 - Turn off all attributes
# Color Code for tput:

# 0 - Black
# 1 - Red
# 2 - Green
# 3 - Yellow
# 4 - Blue
# 5 - Magenta
# 6 - Cyan
# 7 - White

export LESS="-MWi -x4 --shift 5 -FRSX"
export LESSHISTFILE="-"                                         # no less history file
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)               # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)               # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)    # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
