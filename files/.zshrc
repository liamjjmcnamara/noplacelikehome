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
export LESS='-F -i -J -M -R -W -x4 -X -z-4'
export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export AWS_DEFAULT_REGION="eu-west-1"

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
        viins|main) echo -ne "\e[2 q"
                    export SPACESHIP_CHAR_COLOR_SUCCESS="136"
                    ;;
        vicmd)      echo -ne "\e[4 q"
                    export SPACESHIP_CHAR_COLOR_SUCCESS="grey"
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
bindkey '^[f' my-forward-word
bindkey '^[b' my-backward-word
bindkey '^R' history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^[[A"  up-line-or-history
bindkey "^[[B"  down-line-or-history
bindkey "^[[3~" delete-char
bindkey '^e' end-of-line
bindkey '^k' up-line-or-history
bindkey '^j' down-line-or-history
bindkey -r -M viins '^W'
bindkey -Mviins '^W' backward-delete-word
#bindkey -v '^?' vi-backward-delete-char

#bindkey '^[f' vi-forward-word
#bindkey '^[b' vi-backward-word

alias ls="gls --color=auto"
alias l="ls -l"
alias s='dirs -v | head -5'
alias tt="tree -C -L 2 -F -A"
alias t="tt"
alias tt3="tree -C -L 3 -F -A"
alias ttt="tree -C -L 3 -F -A"
alias tt4="tree -C -L 4 -F -A"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias lt="ls --sort=time"
alias c="cd"
alias v="vi"
alias vls="vi"
alias vimsession="vim -S ~/.vim/session.vim"
alias d="docker"
alias bu="brew upgrade"
alias g="git"
alias gs="git status"
alias gp="git pull"
alias gr="grep -sn"
alias xg="xargs grep -sn"
alias fxg="find . | xargs grep -sn"
alias gxf="find . | xargs grep -sn"
alias gca="git commit -a"
alias docker_purge='docker rm $( docker ps -q -f status=exited )'
alias noplace='echo "git clone https://github.com/liamjjmcnamara/noplacelikehome.git"'
alias r3="rebar3"
alias prep='rebar3 dialyzer && elvis rock && echo "\n\033[0;32mLooks good!\033[0;0m\n"'

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# label a window in tmux and set git status
if [[ -n $TMUX  ]]; then
  PROMPT_COMMAND='$(tmux rename-window $(pwd|sed "s,$HOME,~,"|sed "s,.*/,," )/)'
fi
precmd() { eval "$PROMPT_COMMAND" }


if [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -e /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^ ' autosuggest-accept
fi

if [ -e  "~/.iterm2_shell_integration.zsh" ]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

#if [ -e ~/.dircolors ]; then
  #eval $(dircolors ~/.dircolors)
#fi

# Pull kerl settings
if [ -e ~/.kerl/.kerlrc ]; then
  source ~/.kerl/.kerlrc
fi

# Enable python install shim layer
pyenv init

# Erlang activation
if [ -e /usr/local/erlang/21.1/activate ]; then
  source /usr/local/erlang/21.1/activate
fi

export ERL_AFLAGS="-kernel shell_history enabled"
alias erl='erl -config ~/.erlhistory.config'

unsetopt share_history

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
export SPACESHIP_PROMPT_ORDER=(time dir git exec_time battery line_sep exit_code char)

export SPACESHIP_PROMPT_ADD_NEWLINE=false

export SPACESHIP_CHAR_COLOR_FAILURE="160"
export SPACESHIP_CHAR_COLOR_SUCCESS="136"
export SPACESHIP_TIME_SHOW="true"
export SPACESHIP_TIME_COLOR="grey"
export SPACESHIP_TIME_FORMAT=""
export SPACESHIP_TIME_PREFIX=""
export SPACESHIP_TIME_SUFFIX=""

export SPACESHIP_DIR_PREFIX="<"
export SPACESHIP_DIR_SUFFIX="> "
export SPACESHIP_DIR_COLOR="33"
export SPACESHIP_DIR_TRUNC="6"
export SPACESHIP_DIR_TRUNC_PREFIX="…/"

export SPACESHIP_GIT_PREFIX=""
export SPACESHIP_GIT_BRANCH_COLOR="136"
export SPACESHIP_GIT_STATUS_COLOR="160"

export SPACESHIP_EXEC_TIME_ELAPSED="5"
export SPACESHIP_EXEC_TIME_COLOR="white"

export SPACESHIP_BATTERY_THRESHOLD="15"

# Allow local specifics
if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
