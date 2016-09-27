
# added by Anaconda 2.0.1 installer
#export PATH="/usr/local/python/anaconda/bin:/usr/local/maven/bin:$PATH:/usr/local/android-ndk"
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=2000
export JAVA_HOME=$(/usr/libexec/java_home)

export PYTHONPATH="."

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias ls="gls --color=yes"
alias l="ls -l"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias lt="ls --sort=time"
alias d="docker"
alias g="grep -d skip"
alias gca="git commit -a"

# nice informative PS1
export PS1="\[\033[0;37m\][\[\033[1;37m\]yukon\[\033[0;37m\]]<\[\033[1;37m\]\W\[\033[0;37m\]>"
# only set CDPATH in interactive shells
if test “${PS1+set}”; then CDPATH=".:~"; fi
# avoid cd output
#alias cd='>/dev/null cd'



#export NDKROOT="/usr/local/android-ndk/"

#export ANDROIDSDK="/usr/local/android-sdks/"
#export ANDROIDNDK="/usr/local/android-ndk/"
#export ANDROIDNDKVER=r8c
#export ANDROIDAPI=14
#export NDK_ROOT=/usr/local/android-ndk

#export SCALAHOME=/usr/local/Cellar/scala/2.11.5/

#export DOCKER_CERT_PATH=/Users/ljjm/.boot2docker/certs/boot2docker-vm
#export DOCKER_TLS_VERIFY=1
#export DOCKER_HOST=tcp://192.168.59.103:2376
#export DOCKER_HOST=tcp://localhost:4243

#export PATH=$PATH:/usr/local/opt/go/libexec/bin
#export GOPATH="/Users/ljjm/code/go"


export EDITOR="vim"
export PATH="/usr/local/sbin:$PATH"

# added by Anaconda2 2.4.1 installer
#export PATH="/usr/local/python/conda/bin:$PATH"

export HOMEBREW_GITHUB_API_TOKEN="00f207100b00ecbb70c730d08feeef07760e954a"

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

. ~/.kerl/.kerlrc

if [[ \$TMUX  ]]; then source ~/.tmux-git/tmux-git.sh; fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

. /usr/local/erlang/R16B03-1/activate
