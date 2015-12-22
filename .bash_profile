PS1="\[\e[37;1m\][\[\e[32;1m\]\u\[\e[33;1m\]@\[\e[32;1m\]\h \[\e[33;1m\]- \[\e[34;1m\]\w\[\e[37;1m\]]\[\e[32;1m\]$ \[\e[0m\]"

# For 'homebrew' based bash
#alias ls='ls -GFh'
#alias ll='ls -lGFh'
#alias la='ls -laGFh'

export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH=/mongodb/bin:$PATH

export JAVA_HOME=$(/usr/libexec/java_home)

# EC2
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.5.1
export PATH=$PATH:$EC2_HOME/bin
export AWS_ACCESS_KEY=
export AWS_SECRET_KEY=

test -e ~/.dircolors && \ eval 'dircolors -b ~/.dircolors'
alias ls="ls -aFh --color=always"
alias ll="ls -alFh --color=always"
alias grep="grep --color=always"
alias egrep="egrep --color=always"
