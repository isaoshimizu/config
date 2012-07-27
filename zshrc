# .tmux.conf
# Author: Isao Shimizu <isaoshimizu@gmail.com>

fpath=(~/zsh-4.3.7/func ${fpath})

autoload -U compinit
compinit
setopt COMPLETE_IN_WORD

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups
setopt hist_ignore_space
setopt ALWAYS_TO_END

alias ls='/bin/ls --color'
alias la='/bin/ls -a --color'
alias ll='/bin/ls -l --color'
alias lla='/bin/ls -al --color'
alias vi='vim'
alias history='history 1'

export EDITOR=vim
export SVN_EDITOR=vim

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^F' history-incremental-search-backward
bindkey -e

alias df='df -h'
alias du='du -h'
alias screen='~/screen-4.1.0'
alias tmux='~/tmux-1.6 -2'
alias vim='~/vim73-20120308/bin/vim'
alias zsh='~/zsh-4.3.7/zsh'

eval `dircolors ~/.dir_colors`

#case "$TERM" in
#xterm*|kterm*|rxvt*)
#    ;;
#    screen*)
#        printf "\033P\033]0;$USER@$HOSTNAME\007\033\\"
#    ;;
#esac

function ssh_window(){
    eval server=\${$#}
    ssh-keygen -q -R $server 2>/dev/null
    tmux new-window -n $server "TERM=screen-256color /usr/bin/ssh $@"
}
alias ssh=ssh_window

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

case ${UID} in
0)
    PROMPT="%B%{[27m%}%/#%{[m%}%b "
    PROMPT2="%B%{[27m%}%_#%{[m%}%b "
    SPROMPT="%B%{[27m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[27m%}%/%%%{[m%} "
    PROMPT2="%{[27m%}%_%%%{[m%} "
    SPROMPT="%{[27m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
RPROMPT="%1(v|%F{green}%1v%f|)"

case "${TERM}" in
kterm*|xterm)
    precmd() {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

if [ $SHLVL = 1 ]; then
  tmux attach || tmux -f $HOME/.tmux.conf
fi

[ -f ~/.zshrc.inc ] && source ~/.zshrc.inc
