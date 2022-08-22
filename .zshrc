autoload -U colors compinit promptinit
colors
compinit
promptinit

function set-prompt {
    V=""
    if [ -n "$VIRTUAL_ENV" ]; then
        BN=$(basename $VIRTUAL_ENV)
        V="($BN) "
    fi

    BR=$(gbn 2> /dev/null)
    if [ -n "$BR" ]; then
        BR="%{$fg_bold[magenta]%}$BR "
    fi

    PROMPT="$V$BR%{$fg_bold[green]%}%n@%m%{$reset_color%}%{$fg[black]%}:%{$fg_bold[blue]%}%~%{$fg_bold[magenta]%}%{$reset_color%}"$'\n'"$1 "
}

set-prompt '$'

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt inc_append_history
setopt share_history

setopt menu_complete
zstyle ':completion:*' menu select
zstyle ':completion:*' ignored-patterns '*?.pyc' '__pycache__' '*.class' '.zcompdump' '.zsh_history'

setopt NO_BEEP
export TERM=xterm-256color
export EDITOR=nvim
export GIT_EDITOR=nvim

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^?' backward-delete-char
bindkey '\e.' insert-last-word

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS='--bind ctrl-s:select-all'

function zle-line-init zle-keymap-select {
    set-prompt "${${KEYMAP/vicmd/N}/(main|viins)/\$}"
    # case $KEYMAP in
    # vicmd)
    #     echo -ne '\e[2 q'
    #     ;;
    # viins|main)
    #     echo -ne '\e[5 q'
    #     ;;
    # esac
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# --------------------------------------
# Functions + Aliases

function mcd() { mkdir -p $1 && cd $1 }

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='ls -Gh'
alias ll='ls -aFo'
alias l='ls -1aF'
alias cp='cp -i'
alias mv='mv -i'

alias vim='nvim'
alias tmux='tmux -2'
alias ta='tmux a'
alias tm='TMUX= tmux'
alias tx='tmuxinator start'
alias vimrc='vim ~/.vimrc'
alias vt='vim ~/.tmux.conf'
alias vz='vim ~/.zshrc'
alias :q='exit'
alias :Q='exit'
alias vim.="vim ."
alias bf='fzf | xargs bat'
alias sqlite3='echo "DONT FORGET" && echo "PRAGMA FOREIGN_KEYS = ON;" && echo "!!!!!!!!!!!!!!!!!!!!!!!!!" && echo && echo && sqlite3'
alias ga='git add'
alias gcd='cd $(git rev-parse --show-toplevel)'
alias gfiles='echo "$(git ls-files --others --exclude-standard ; git diff --name-only)"'
alias gaf='gcd ; gfiles | fzf -m --height=8 | xargs git add ; cd -'
alias gap='ga -p'
alias gapf='FILE=$(gfiles | fzf --height=8) && gap $FILE'
alias ga.='ga .'
alias ga.ds='ga . && gds'
alias gad='ga.ds'
alias ga.st='ga . && gst'
alias gb='git branch'
alias gbdm='git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D'
alias gbn='git rev-parse --abbrev-ref HEAD'
alias gc='git commit'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gds='gd --staged'
alias gf='git fetch'
alias gl='git log'
alias gm='git merge'
alias gmm='gm master'
alias go='git checkout'
alias gob='git checkout -b'
alias gof='gcd ; git diff --name-only | fzf --height=8 | xargs git checkout ; cd -'
alias gom='git checkout master'
alias gop='git checkout -'
alias gomu='gom && gu'
alias gomup='gom && gu && gop'
alias gp='git push'
alias gpu='gbn | xargs git push --set-upstream origin'
alias gr='git reset'
alias grf='gcd ; git diff --staged --name-only | fzf -m --height=8 | xargs git reset ; cd -'
alias grmf='gcd ; git diff --name-only --diff-filter=U | fzf -m --height=8 | xargs git rm ; cd -'
alias gs='git status'
alias gst='git stash'
alias gsts='git stash save'
alias gstk='git stash save --keep-index'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gu='git pull --rebase'

function gn() {
    echo $1
    git checkout -b $1 origin/master
}

alias s='yarn start'

# --------------------------------------
# project-specific
alias code='cd ~/Code'

# Carrots
CC=~/Code/carrot-cards
alias ccf="cd $CC/frontend"

# Clipchamp
alias cs='cd ~/Code/Clipchamp/ms/clipchamp-stack'
alias csf='cd ~/Code/Clipchamp/ms/clipchamp-stack/apps/create'
alias csb='cd ~/Code/Clipchamp/ms/clipchamp-stack/apps/business'
alias acs='cd ~/Code/Clipchamp/ms/another-clipchamp-stack'
alias acsf='cd ~/Code/Clipchamp/ms/another-clipchamp-stack/apps/create'
alias ycs='cd ~/Code/Clipchamp/ms/yet-another-clipchamp-stack'
alias ycsf='cd ~/Code/Clipchamp/ms/yet-another-clipchamp-stack/apps/create'
alias ms='cd ~/Code/Clipchamp/ms'

alias tb='cd ~/Code/trialbooker && workon tb'
alias pg='postgres -D /usr/local/var/postgresql@11'
alias ago='cd ~/Code/agoer/agoer'

function cstf {
    yarn test $1 --watch
}

# # The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/deco/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/deco/google-cloud-sdk/path.zsh.inc'; fi

# # The next line enables shell command completion for gcloud.
if [ -f '/Users/deco/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/deco/google-cloud-sdk/completion.zsh.inc'; fi

# python virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source virtualenvwrapper.sh
alias d='deactivate'

export CUSTOM_GAE_PROJECT_ID=clipdev-declan-haigh-swjga

# Go
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH

# npm
export PATH=$HOME/.npm-global/bin:$PATH

# rvm
# export PATH="$PATH:$HOME/.rvm/bin

export RUSH_PNPM_STORE_PATH=~/.rush-pnpm
