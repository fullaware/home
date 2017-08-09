# export PS1="\[\e[37;1m\][\[\e[32;1m\]\u\[\e[33;1m\]@\[\e[32;1m\]\h \[\e[33;1m\]- \[\e[34;1m\]\w\[\e[37;1m\]]\[\e[32;1m\]$ \[\e[0m\]"
export PS1="\[$(tput bold)\]\[\033[38;5;14m\][\[\033[38;5;10m\]\u\[\033[38;5;14m\]@\[\033[38;5;220m\]\h\[\033[38;5;14m\]:\[\033[38;5;183m\]\w\[\033[38;5;14m\]]\[\033[38;5;15m\] \[\033[38;5;190m\]\\$\[\033[38;5;15m\] \[$(tput sgr0)\]"

# For 'homebrew' based bash
#alias ls='ls -GFh'
#alias ll='ls -lGFh'
#alias la='ls -laGFh'

export PATH=/usr/local/bin:/mongodb/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

#JAVA
export JAVA_HOME=$(/usr/libexec/java_home)

# EC2
export EC2_HOME=/usr/local/ec2
export PATH=$PATH:$EC2_HOME/bin
export AWS_ACCESS_KEY=
export AWS_SECRET_KEY=

test -e ~/.dircolors && \ eval 'dircolors -b ~/.dircolors'
alias ls="ls -aFh --color=always"
alias ll="ls -alFh --color=always"
alias grep="grep --color=always"
alias egrep="egrep --color=always"
