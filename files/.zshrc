# oh my zsh
export ZSH=/Users/liam.mcnamara/.oh-my-zsh
plugins=(git osx docker)
source $ZSH/oh-my-zsh.sh


setopt PROMPT_SUBST
#export PS1=$'\ek$(basename $(pwd))\e\\[%{\e[97m%}yukon%{\e[0m%}]<%{\e[97m%}%~%b%{\e[0m%}>'
export PS1=$'[%{\e[97m%}yukon%{\e[0m%}]<%{\e[97m%}%~%b%{\e[0m%}>'

SAVEHIST=10000
HISTFILE=~/.zsh_history

alias ls="gls --color=yes"
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
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status


if [ -e ~/.kerl/.kerlrc ]; then
  . ~/.kerl/.kerlrc
fi
if [ -e /usr/local/erlang/r16b03-1/activate ]; then
  . /usr/local/erlang/r16b03-1/activate
fi
alias erl-r16=". /usr/local/erlang/r16b03-1/activate"

# label a window in tmux and set git status
#if [[ -n $TMUX  ]]; then 
#  PROMPT_COMMAND='$(tmux rename-window $(pwd|sed "s,$HOME,~,"|sed "s,.*/,," )/)'
#  if [ -e ~/.tmux-git/tmux-git.sh ]; then
#    source ~/.tmux-git/tmux-git.sh
#  fi
#fi
# precmd() { eval "$PROMPT_COMMAND" }

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Allow local specifics
if [ -e ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi
