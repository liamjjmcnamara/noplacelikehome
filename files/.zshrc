# oh my zsh
export ZSH=$HOME/.oh-my-zsh
plugins=(git osx)

if [ -e $ZSH/oh-my-zsh.sh ]; then
  source $ZSH/oh-my-zsh.sh
fi

export PATH="/usr/local/sbin:$PATH"
export PS1=$'[%{\e[97m%}yukon%{\e[0m%}]<%{\e[97m%}%~%b%{\e[0m%}>'

setopt PROMPT_SUBST
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CDABLE_VARS
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH
unsetopt LISTAMBIGUOUS

# set VIMODE according to the current mode
# https://dougblack.io/words/zsh-vi-mode.html
function zle-line-init zle-keymap-select {
    PS1=$'%{$FG[007]%}[%{$FG[015]%}yukon%{\e[0m%}%{$FG[007]%}]<%{\e[97m%}%~%b%{\e[0m%}%{$FG[007]%}>%{$FG[015]%}'
    case $KEYMAP in
        #vicmd|main) PS1=$'[%{$FG[10]%}yukon%{\e[0m%}]<%{\e[97m%}%~%b%{\e[0m%}>';;
        main) PS1=$'%{$FG[136]%}[%{$FG[015]%}yukon%{\e[0m%}%{$FG[136]%}]<%{\e[97m%}%~%b%{\e[0m%}%{$FG[136]%}>%{$FG[015]%}';;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

SAVEHIST=10000
HISTFILE=~/.zsh_history
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/:'
KEYTIMEOUT=1

alias ls="gls --color=auto"
alias l="ls -l"
alias tt="tree -C -L 2 -F -A"
alias t="tt"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias lt="ls --sort=time"
alias c="cd"
alias v="vi"
alias d="docker"
alias g="git"
alias gs="git status"
alias gr="grep -sn"
alias xg="xargs grep -sn"
alias fxg="find . | xargs grep -sn"
alias gca="git commit -a"
alias docker_purge="docker rm $( docker ps -q -f status=exited )"
alias noplace='echo "git clone https://github.com/liamjjmcnamara/noplacelikehome.git"'
alias r3="rebar3"

git config --global alias.stat 'status --short --branch'
git config --global alias.glog 'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
git config --global alias.co checkout
git config --global alias.cob 'checkout -b'
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.cam 'commit -S -am'
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global commit.verbose true

# label a window in tmux and set git status
if [[ -n $TMUX  ]]; then 
  PROMPT_COMMAND='$(tmux rename-window $(pwd|sed "s,$HOME,~,"|sed "s,.*/,," )/)'
  if [ -e ~/.tmux-git/tmux-git-zsh.sh ]; then
    source ~/.tmux-git/tmux-git-zsh.sh
  fi
fi
precmd() { eval "$PROMPT_COMMAND" }

# Vi mode
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^[[A"  up-line-or-history
bindkey "^[[B"  down-line-or-history
bindkey "^[[3~" delete-char
bindkey '[C' forward-word
bindkey '[D' backward-word
bindkey '^e' end-of-line
CASE_SENSITIVE="true"

if [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -e  "~/.iterm2_shell_integration.zsh" ]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Pull kerl settings
if [ -e ~/.kerl/.kerlrc ]; then
  source ~/.kerl/.kerlrc
fi

# Erlang activation
if [ -e /usr/local/erlang/18.3/activate ]; then
  source /usr/local/erlang/18.3/activate
fi

# kubernetes shell completion
source <(kubectl completion zsh)

if [ -e ~/.dircolors ]; then
  eval "$(dircolors ~/.dircolors)"
fi

# Allow local specifics
if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

