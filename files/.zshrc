# oh my zsh
export ZSH=/Users/liam.mcnamara/.oh-my-zsh
plugins=(git osx)
source $ZSH/oh-my-zsh.sh

setopt PROMPT_SUBST
#export PS1=$'\ek$(basename $(pwd))\e\\[%{\e[97m%}yukon%{\e[0m%}]<%{\e[97m%}%~%b%{\e[0m%}>'
export PS1=$'[%{\e[97m%}yukon%{\e[0m%}]<%{\e[97m%}%~%b%{\e[0m%}>'

# set VIMODE according to the current mode
# https://dougblack.io/words/zsh-vi-mode.html
function zle-line-init zle-keymap-select {
    #RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    #RPS2=$RPS1
    PS1=$'%{$FG[007]%}[%{$FG[015]%}yukon%{\e[0m%}%{$FG[007]%}]<%{\e[97m%}%~%b%{\e[0m%}%{$FG[007]%}>%{$FG[015]%}'
    case $KEYMAP in
        #vicmd|main) PS1=$'[%{$FG[10]%}yukon%{\e[0m%}]<%{\e[97m%}%~%b%{\e[0m%}>';;
        main) PS1=$'%{$FG[136]%}[%{$FG[015]%}yukon%{\e[0m%}%{$FG[136]%}]<%{\e[97m%}%~%b%{\e[0m%}%{$FG[136]%}>%{$FG[015]%}';;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

bindkey -v

export ERL_LIBS=..
export REBAR_DEPS_DIR=..

SAVEHIST=10000
HISTFILE=~/.zsh_history
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/:'
KEYTIMEOUT=1

eval "$(dircolors ~/.dircolors)"
alias ls="gls --color=auto"
alias l="ls -l"
alias tt="tree -C -L 2 -F -A"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias id='cd ~/code/id'
alias lt="ls --sort=time"
alias v="vi"
alias d="docker"
alias g="git"
alias xg="xargs grep -sn"
alias gca="git commit -a"
alias docker_purge="docker rm $( docker ps -q -f status=exited )"
alias noplace='echo "git clone https://github.com/liamjjmcnamara/noplacelikehome.git"'
alias r3="rebar3"

git config --global alias.stat 'status --short --branch'
git config --global alias.glog 'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
git config --global alias.co checkout
git config --global alias.cob 'checkout -b --'
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.cam 'commit -am --'
git config --global alias.st status


if [ -e ~/.kerl/.kerlrc ]; then
  . ~/.kerl/.kerlrc
fi
if [ -e /usr/local/erlang/18.3/activate ]; then
  . /usr/local/erlang/18.3/activate
fi

# label a window in tmux and set git status
if [[ -n $TMUX  ]]; then 
  PROMPT_COMMAND='$(tmux rename-window $(pwd|sed "s,$HOME,~,"|sed "s,.*/,," )/)'
  if [ -e ~/.tmux-git/tmux-git-zsh.sh ]; then
    source ~/.tmux-git/tmux-git-zsh.sh
  fi
fi
precmd() { eval "$PROMPT_COMMAND" }

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#bindkey -v '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
bindkey    "^[[3~" delete-char

source <(kubectl completion zsh)

CASE_SENSITIVE="true"

# Allow local specifics
if [ -e ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi
