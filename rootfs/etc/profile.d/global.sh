#!/bin/bash

# LSB_RELEASE
export `cat /etc/lsb-release | grep -v DESCRIPTION`

# Default language
export LC_ALL=C.UTF-8

# Default editor
export EDITOR='/bin/nano'

# Default aliases
alias l='ls -lA --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tree='tree --dirsfirst -C'
