export PS1="\[\]\[\033[38;5;14m\][\[\033[38;5;10m\]\u\[\033[38;5;14m\]@\[\033[38;5;220m\]\h\[\033[38;5;14m\]:\[\033[38;5;183m\]\w\[\033[38;5;14m\]]\[\033[38;5;15m\]\[$(tput bold)\]\[\033[38;5;213m\]🗘\[$(tput sgr0)\] \[\033[38;5;219m\]\T\[$(tput sgr0)\] \[\033[38;5;190m\]\$\[\033[38;5;15m\] \[\]"

alias cpv='rsync -ah --info=progress2'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gh='history|grep'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -alFhG --color'
alias ls='ls -aFhG --color'
alias tailf='tail -f'
