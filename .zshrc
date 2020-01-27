autoload -U colors compinit promptinit
colors
compinit
promptinit

PROMPT="%{$fg_bold[green]%}%n@%m%{$reset_color%}%{$fg[black]%}:%{$fg_bold[blue]%}%~%{$fg_bold[magenta]%}%{$reset_color%}
%(!.%%.\$) "

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
export GIT_EDITOR=nvim

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^w' backward-kill-word

export FZF_DEFAULT_COMMAND='ag -g ""'

# --------------------------------------
# Functions + Aliases

function mcd() { mkdir -p $1 && cd $1 }

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='ls -G'
alias ll='ls -aFo'
alias l='ls -1aF'
alias cp='cp -i'
alias mv='mv -i'

alias vim='nvim'
alias tmux='tmux -2'
alias ta='tmux a'
alias tm='TMUX= tmux'
alias vimrc='vim ~/.vimrc'
alias vt='vim ~/.tmux.conf'
alias vz='vim ~/.zshrc'

function tmd() {
    tmux new-session -d
    tmux rename-session main
    tmux rename-window code
    tmux new-window
    tmux rename-window git
    tmux split-window -h
    tmux select-window -t 1
    tmux new-session -d
    tmux rename-session misc
    tmux attach-session -t main
}

alias ga='git add'
alias gaf='FILE=$(echo "$(git ls-files --others --exclude-standard; git diff --name-only)" | fzf -m --height=8) && git add $(echo $FILE)'
alias gap='ga -p'
alias ga.='ga .'
alias ga.ds='ga . && gds'
alias gb='git branch'
alias gbdm='gb --merged | grep -v "\(^\*\)\|\(^  master$\)" | xargs git branch -d'
alias gbn='git rev-parse --abbrev-ref HEAD'
alias gc='git commit'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gds='gd --staged'
alias gf='git fetch'
alias gl='git log'
alias gm='git merge'
alias gmm='gm master'
alias gmp='gm -'
alias go='git checkout'
alias gob='go -b'
alias gof='FILE=$(git diff --name-only | fzf --height=8) && git checkout $FILE'
alias gom='go master'
alias gop='go -'
alias gomu='gom && gu'
alias gp='git push'
alias gpu='gbn | xargs git push --set-upstream origin'
alias gr='git reset'
alias grf='FILE=$(git diff --staged --name-only | fzf --height=8) && git reset $FILE'
alias gs='git status'
alias gst='git stash'
alias gstl='gst list'
alias gstp='gst pop'
alias gu='git pull --rebase'
alias :q='exit'
alias :Q='exit'
alias v='FILE=$(fzf -m --height=8) && vim $FILE'

# --------------------------------------
# project-specific
alias code='cd ~/Code'
alias tb='cd ~/Code/trialbooker && workon tb'
alias pg='postgres -D /usr/local/var/postgres'
