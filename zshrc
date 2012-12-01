path=$PATH
path="${path}:/bin"
path="${path}:/sbin"
path="${path}:/usr/bin"
path="${path}:/usr/sbin"
path="${path}:/usr/local/bin"
path="${path}:/usr/local/sbin"
path="${path}:/opt/local/bin"
path="${path}:/opt/local/sbin"
path="${path}:/usr/local/git/bin"
path="${path}:/usr/local/go/bin"
path="${path}:${HOME}/bin"
path="${path}:${HOME}/scripts"

export PATH=$path

manpath=$MANPATH
manpath="${manpath}:/usr/local/man"
manpath="${manpath}:/usr/share/man"
manpath="${manpath}:/opt/local/share/man"
manpath="${manpath}:/usr/local/git/man"

export MANPATH=$manpath

THEIGHT=26
TWIDTH=102

alias h=history
alias p=popd
alias j='jobs -l'
alias less='less -X'
alias grep='grep --color=auto'
alias sm='echo -ne "\e[8;${THEIGHT};${TWIDTH}t"'
alias allsmall='xwininfo -children -root |perl -ne '\''if (m,(pts/\d+),) { `echo -ne "\e[8;'${THEIGHT}';'${TWIDTH}'t" > /dev/$1` }'\'''
alias pushdotfiles='cd ${HOME}/.dotfiles && git commit -a && git push ; popd'
alias pulldotfiles='cd ${HOME}/.dotfiles && git pull && . ${HOME}/.zshrc ; popd'

if [ `uname` = 'Linux' ]; then
  alias ls="ls -F --color=auto"
else
  alias ls="ls -GF"
fi

export BLOCKSIZE=K
export LSCOLORS=ExHxxxxxcx
export PAGER="less -X"
export EDITOR=vim
export VISUAL=vim

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Use vi mode and then put a bunch of stuff back to emacs
bindkey -v
bindkey  kill-whole-line
bindkey  yank
bindkey  beginning-of-line
bindkey  end-of-line
bindkey  history-incremental-search-backward
bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history

precmd () {print -Pn "\e]0;[%n@%m : %l]\a"}
export PS1="[%B%n%b] %m %l [%! %B%D{%I:%M}%b][%/] "

# History settings
setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_ignore_dups
export SAVEHIST=2147483648
export HISTFILE=~/.history
export HISTSIZE=16384

setopt ignoreeof
setopt automenu
unsetopt menucomplete
setopt autopushd
setopt clobber
unsetopt correct
unsetopt correctall
setopt interactivecomments
setopt listbeep
setopt listtypes
setopt markdirs
setopt notify
setopt printexitvalue
setopt pushdignoredups
setopt pushdsilent
setopt rmstarsilent
unsetopt nomatch

function urlperf {
  curl -N -s -o /dev/null -w "code\t\t\t%{http_code}\ntime_total\t\t%{time_total}\ntime_namelookup\t\t%{time_namelookup}\ntime_connect\t\t%{time_connect}\ntime_pretransfer\t%{time_pretransfer}\ntime_starttransfer\t%{time_starttransfer}\nsize_download\t\t%{size_download}\nspeed_download\t\t%{speed_download}\n" $*
}

function localtime {
  perl -e '$tmp = localtime('$1'); print "$tmp\n"'
}

if [ -f /etc/zsh_command_not_found ]; then
  . /etc/zsh_command_not_found
fi

if [ -f ${HOME}/.zshrc_local ]; then
  . ${HOME}/.zshrc_local
fi
