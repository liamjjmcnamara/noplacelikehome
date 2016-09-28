
# Pull the bashrc
if [ -f ~/.bashrc  ]; then
	. ~/.bashrc
fi

export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=2000
export PYTHONPATH="."
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export JAVA_HOME=$(/usr/libexec/java_home)
export EDITOR="vim"
export PATH="/usr/local/sbin:$PATH:$HOME/bin"

#export DOCKER_CERT_PATH=/Users/ljjm/.boot2docker/certs/boot2docker-vm
#export DOCKER_TLS_VERIFY=1
#export DOCKER_HOST=tcp://192.168.59.103:2376
#export DOCKER_HOST=tcp://localhost:4243


# nice informative PS1
export PS1="\[\033[0;37m\][\[\033[1;37m\]\H\[\033[0;37m\]]<\[\033[1;37m\]\W\[\033[0;37m\]>"
# only set CDPATH in interactive shells
if test “${PS1+set}”; then CDPATH=".:~"; fi
# avoid cd output
#alias cd='>/dev/null cd'

# if mac
# alias ls="gls --color=yes"
alias l="ls -l"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias lt="ls --sort=time"
alias d="docker"
alias g="grep -d skip"
alias gca="git commit -a"
alias docker_purge="docker rm $( docker ps -q -f status=exited )"
alias noplace=''echo "git clone https://github.com/liamjjmcnamara/noplacelikehome.git"''

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

. ~/.kerl/.kerlrc

if [[ \$TMUX  ]]; then source ~/.tmux-git/tmux-git.sh; fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

