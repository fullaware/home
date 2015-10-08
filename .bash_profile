PS1="\[\e[37;1m\][\[\e[32;1m\]\u\[\e[33;1m\]@\[\e[32;1m\]\h \[\e[33;1m\]- \[\e[34;1m\]\w\[\e[37;1m\]]\[\e[32;1m\]$ \[\e[0m\]"

#alias ls='ls -GFh'
#alias ll='ls -lGFh'
#alias la='ls -laGFh'

export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH=/mongodb/bin:$PATH

test -e ~/.dircolors && \ eval 'dircolors -b ~/.dircolors'
alias ls="ls -aFh --color=always"
alias ll="ls -alFh --color=always"
alias grep="grep --color=always"
alias egrep="egrep --color=always"
