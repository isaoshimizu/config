# .zshrc
# Author: Isao Shimizu <isaoshimizu@gmail.com>

fpath=(~/.zfunctions ${fpath})

autoload -U compinit
compinit
autoload -U promptinit && promptinit
prompt pure

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors
#

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

export LANG=en_US.UTF-8

setopt hist_ignore_dups
setopt hist_ignore_space
setopt ALWAYS_TO_END

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey -e

export TERM=xterm-256color
export PURE_GIT_PULL=0

# aliases
case ${OSTYPE} in
  darwin*)
    eval `gdircolors ~/.dir_colors`
    alias ls='gls --color'
    alias la='gls -a --color'
    alias ll='gls -l --color'
    alias lla='gls -al --color'
    alias vim='/usr/local/bin/vim'
    alias emacs='/usr/local/bin/emacs'
    alias git='/usr/local/bin/git'
    alias sed='gsed'
    export PATH=~/bin:/usr/local/bin:$PATH:/usr/local/packer:/usr/local/Cellar/fping/3.8/sbin
    ;;
  linux*)
    eval `dircolors ~/.dir_colors`
    alias ls='ls --color'
    alias la='ls -a --color'
    alias ll='ls -l --color'
    alias lla='ls -al --color'
    export PATH=~/bin:/usr/local/bin:$PATH

    function ssh_window(){
      if [ "$TMUX" != "" ]; then
        eval server=\${$#}
        tmux new-window -n $server "/usr/bin/ssh $@"
      else
        /usr/bin/ssh $@
      fi
    }
    alias ssh=ssh_window
    ;;
esac
alias vi='vim'
alias history='history 1'
alias lv='lv -c -T8192'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
alias jar='jar -J-Dfile.encoding=UTF-8'
alias kt='bundle exec kitchen'
alias vim_neobundle_install='vim +NeoBundleInstall! +qall'
alias df='df -h'
alias du='du -h'
alias gist='gist -c -o -p'
# git alias
alias g='git'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# editor
export EDITOR=vim
export SVN_EDITOR=vim

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# golang
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# AWS CLI
#source /usr/local/share/zsh/site-functions/_aws

## nodebrew
export PATH="$HOME/.nodebrew/current/bin:$PATH"
#
# docker
export DOCKER_HOST=tcp://localhost:4243

# Google Cloud SDK
export PATH=~/google-cloud-sdk/bin:$PATH

function print_known_hosts (){
  if [ -f $HOME/.ssh/known_hosts ]; then
    cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
  fi
}
_cache_hosts=($( print_known_hosts ))

agent="$HOME/tmp/ssh-agent-$USER"
if [ -S "$SSH_AUTH_SOCK" ]; then
    case $SSH_AUTH_SOCK in
    /tmp/*/agent.[0-9]*)
        ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    esac
elif [ -S $agent ]; then
    export SSH_AUTH_SOCK=$agent
else
    echo "no ssh-agent"
fi

# gvm
[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"

keychain --nogui --quiet ~/ssh-keys/siau_id_rsa
source ~/.keychain/$HOST-sh
