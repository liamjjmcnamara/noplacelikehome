export BASH_PROFILE_SOURCED="true"

# Detect OS
OS=`uname`

# Detect host
HOST=`hostname`
if [ $HOST == "C02S82H7G8WN"  ]; then
HOST="yukon"
fi

# Pull the bashrc
if [ -f ~/.bashrc  ]; then
	. ~/.bashrc
fi

export PATH="$PATH:/usr/local/bin"

export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=2000
export PYTHONPATH="."
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR="vim"
export PATH="/usr/local/sbin:$PATH:$HOME/bin"
export GPG_TTY=$(tty)

export PS1="[$HOST]<\W>"

# if mac
if [ $OS == "Darwin"  ]; then
	alias ls="gls --color=yes"
fi
alias l="ls -l"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias lt="ls --sort=time"
alias d="docker"
alias g="git"
alias xg="xargs grep -d skip"
alias gca="git commit -a"
alias docker_purge="docker rm $( docker ps -q -f status=exited )"
alias noplace='echo "git clone https://github.com/liamjjmcnamara/noplacelikehome.git"'

git config --global alias.stat 'status --short --branch'
git config --global alias.glog 'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
shopt -s cdspell

if [ -e ~/.kerl/.kerlrc ]; then
  . ~/.kerl/.kerlrc
fi
if [ -e /usr/local/erlang/kredotp/activate ]; then
  source /usr/local/erlang/kredotp/activate
fi

# Allow local specifics
if [ -e ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi

export PATH="$HOME/.cargo/bin:$PATH"
