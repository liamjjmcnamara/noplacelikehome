export LANG='en_US.UTF-8'

# oh my zsh
plugins=(git osx)
export ZSH=$HOME/.oh-my-zsh
if [ -e $ZSH/oh-my-zsh.sh ]; then
  source $ZSH/oh-my-zsh.sh
fi

export PATH="/usr/local/sbin:$PATH"
export PS1=$'[%{\e[97m%}yukon%{\e[0m%}]<%{\e[97m%}%~%b%{\e[0m%}>'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export TILLER_NAMESPACE="id"
export HELM_HOME="~/.helm"
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/:'
export SEPCHARS='[/ ]'
export KEYTIMEOUT=1
export CASE_SENSITIVE="true"
export PROMPT_EOL_MARK=""

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
    case $KEYMAP in
        vicmd)      PS1=$'%{$FG[007]%}[%{$FG[015]%}yukon%{\e[0m%}%{$FG[007]%}]<%{\e[97m%}%~%b%{\e[0m%}%{$FG[007]%}>%{$FG[015]%}'
                    echo -ne "\e[4 q"
                    ;;
        viins|main) PS1=$'%(?.%{$FG[136]%}.%{$FG[001]%})[%{$FG[015]%}yukon%{\e[0m%}%(?.%{$FG[136]%}.%{$FG[001]%})]<%{\e[97m%}%~%b%{\e[0m%}%(?.%{$FG[136]%}.%{$FG[001]%})>%{$FG[015]%}'
                    echo -ne "\e[2 q"
                    ;;
    esac
    zle reset-prompt
}

my-forward-word() {
    if [[ "${BUFFER[CURSOR + 1]}" =~ "${SEPCHARS}" ]]; then
        (( CURSOR += 1 ))
        #return
    fi
    while [[ CURSOR -lt "${#BUFFER}" && ! "${BUFFER[CURSOR + 1]}" =~ "${SEPCHARS}" ]]; do
        (( CURSOR += 1 ))
    done
    while [[ CURSOR -lt "${#BUFFER}" && "${BUFFER[CURSOR + 1]}" =~ "${SEPCHARS}" ]]; do
        (( CURSOR += 1 ))
    done
}

my-backward-word() {
    while [[ CURSOR -gt 0 && "${BUFFER[CURSOR]}" =~ "${SEPCHARS}" ]]; do
        (( CURSOR -= 1 ))
    done
    while [[ CURSOR -gt 0 && ! "${BUFFER[CURSOR]}" =~ "${SEPCHARS}" ]]; do
        (( CURSOR -= 1 ))
    done
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N my-forward-word
zle -N my-backward-word

# Vi mode
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^[[A"  up-line-or-history
bindkey "^[[B"  down-line-or-history
bindkey "^[[3~" delete-char
bindkey '^e' end-of-line
bindkey '^k' up-line-or-history
bindkey '^j' down-line-or-history
#bindkey -v '^?' vi-backward-delete-char

bindkey '^[f' my-forward-word
bindkey '^[b' my-backward-word
#bindkey '^[f' vi-forward-word
#bindkey '^[b' vi-backward-word

alias ls="gls --color=auto"
alias l="ls -l"
alias tt="tree -C -L 2 -F -A"
alias t="tt"
alias tt3="tree -C -L 3 -F -A"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias lt="ls --sort=time"
alias c="cd"
alias v="vi"
alias vls="vi"
alias vimsession="vim -S ~/.vim/session.vim"
alias d="docker"
alias g="git"
alias gs="git status"
alias gr="grep -sn"
alias xg="xargs grep -sn"
alias fxg="find . | xargs grep -sn"
alias gca="git commit -a"
alias docker_purge='docker rm $( docker ps -q -f status=exited )'
alias noplace='echo "git clone https://github.com/liamjjmcnamara/noplacelikehome.git"'
alias r3="rebar3"
alias prep='rebar3 dialyzer && elvis rock && echo "\n\033[0;32mLooks good!\033[0;0m\n"'

# label a window in tmux and set git status
if [[ -n $TMUX  ]]; then
  PROMPT_COMMAND='$(tmux rename-window $(pwd|sed "s,$HOME,~,"|sed "s,.*/,," )/)'
  if [ -e  ~/.tmux/tmux-git-zsh.sh ]; then
    source ~/.tmux/tmux-git-zsh.sh
  fi
fi
precmd() { eval "$PROMPT_COMMAND" }


if [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -e ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^ ' autosuggest-accept
fi

if [ -e  "~/.iterm2_shell_integration.zsh" ]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

if [ -e ~/.dircolors ]; then
  eval $(dircolors ~/.dircolors)
fi

# Pull kerl settings
if [ -e ~/.kerl/.kerlrc ]; then
  source ~/.kerl/.kerlrc
fi

# Erlang activation
if [ -e /usr/local/erlang/20.3.1+kred1/activate ]; then
  source /usr/local/erlang/20.3.1+kred1/activate
fi

export ERL_AFLAGS="-kernel shell_history enabled"
alias erl='erl -config ~/.erlhistory.config'

unsetopt share_history

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Allow local specifics
if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
