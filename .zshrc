#!/usr/local/bin/zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mfisher/.zshrc'

autoload -Uz compinit
autoload -U zmv
compinit
# End of lines added by compinstall
# autoload -U promptinit && promptinit

# {{{ work around zsh hang with Emacs/TRAMP
# http://www.emacswiki.org/emacs/TrampMode
if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
else
    # fix arrow keys (from http://zsh.sourceforge.net/FAQ/zshfaq03.html#l25)
    bindkey "^[b" vi-backward-word
    bindkey "^[f" vi-forward-word
    bindkey "$(echotc kl)" backward-char
    bindkey "$(echotc kr)" forward-char
    bindkey "$(echotc ku)" up-line-or-history
    bindkey "$(echotc kd)" down-line-or-history
    bindkey '\e[A'  up-line-or-history
    bindkey '\e[B'  down-line-or-history
    bindkey '\e[C'  forward-char
    bindkey '\e[D'  backward-char
    bindkey '\eOA'  up-line-or-history
    bindkey '\eOB'  down-line-or-history
    bindkey '\eOC'  forward-char
    bindkey '\eOD'  backward-char
    # Keep my prompt similar to the one I'm used to:
    # user@machine: directory {history #}, % (# if root) 
    PS1="%n@%m: %~ {%h} %# "
fi
# }}}

alias apg="/usr/local/bin/apg -m 8 -x 8 -M NCL -t"
alias h="history 25"
alias ll="/bin/ls -lA"
alias sx="$(which screen) -x"
alias smaller="/usr/sbin/vidcontrol 80x43"

EDITOR=(/usr/local/bin/emacsclient -t)
export EDITOR # this split syntax appears to be necessary (space parsing)
export ALTERNATE_EDITOR=""
export PAGER=less
export LESS=FIRX
export BLOCKSIZE=1k
export IRCNICK=Spudnuts
export IRCNAME=mfisher
export KEY_RECEIVING_ADDRESS="mfisher@csh.rit.edu"
export PARINIT="rTbgqR B=.?_A_a Q=_s>|"
export LC_CTYPE="en_US.UTF-8"
export PATH=~/bin:${PATH}

# {{{ Source non-githubbed info.
if [ -e ~/.zshrc.`hostname` ]
then
    source ~/.zshrc.`hostname`
fi
# }}}

# {{{ semi-common Mac desktop needs
#
if [ $(/usr/bin/uname -s) = "Darwin" ]
then
    # pulls the SSH_AGENT_PID and SSH_AUTH_SOCK environment variables,
    # reformats them as setenv arguments, and places them on the clipboard
    # for pasting
    function copy_ssh_env_screen() {
        /usr/bin/printenv | /usr/bin/grep SSH_A | \
            /usr/bin/awk '{print "export " $1}'| /usr/bin/pbcopy
    }

    if [ -d ~/conkeror ]
    then
        function reload_conkeror() {
            echo "Removing the existing application."
            sudo rm -rf /Applications/conkeror.mozdev.org/conkeror.app
            echo "Installing the new application."
            sudo /Library/Frameworks/XUL.framework/xulrunner-bin --install-app $HOME/conkeror
        }

    # copied from http://paste.lisp.org/+1P2R
        function conkeror-history() {
            cp ~/Library/Application\ Support/conkeror/Profiles/*.default/places.sqlite /tmp
            echo "SELECT p.url FROM moz_places AS p, moz_historyvisits AS h WHERE p.url NOT LIKE '%googleads%' AND p.id = h.place_id ORDER BY h.visit_date DESC LIMIT 100;" | sqlite3 /tmp/places.sqlite |less
            rm /tmp/places.sqlite
        }
    fi
fi
# }}}
