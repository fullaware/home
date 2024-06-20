# Fancy shell colors
export PS1="\[$(tput bold)\]\[\033[38;5;14m\][\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]@\[$(tput sgr0)\]\[\033[38;5;220m\]\h\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]:\[$(tput sgr0)\]\[\033[38;5;183m\]\w\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

# Aliases
alias rsync='rsync -ah --info=progress2'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gh='history|grep'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -alFhG --color'
alias ls='ls -aFhG --color'
alias tailf='tail -f'

# kubectl config
mkdir -p ~/.kube/contexts
export KUBECONFIG=${HOME}/.kube/config:$(for YAML in $(find ${HOME}/.kube/contexts -name '*.yaml') ; do echo -n ":${YAML}"; done)
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k