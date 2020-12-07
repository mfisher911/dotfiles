#!/usr/local/bin/zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1500
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST   # prune duplicate lines from history first
setopt HIST_IGNORE_DUPS         # and don't save new dupes
setopt HIST_NO_STORE            # don't store history/fc commands
setopt HIST_REDUCE_BLANKS       # remove extraneous whitespace
setopt INC_APPEND_HISTORY       # don't wait until the shell quits to save
setopt SHARE_HISTORY            # share history between sessions
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mfisher/.zshrc'

autoload -U zmv
# End of lines added by compinstall
# autoload -U promptinit && promptinit

# probe for ZSH functions: http://www.zsh.org/mla/users/2009/msg00984.html
function_exists () {
    local -a files
    # This expands occurrences of $1 anywhere in $fpath,
    # removing files that don't exist.
    files=(${^fpath}/$1(N))
    # Success if any files exist.
    (( ${#files} ))
}

# {{{ work around zsh hang with Emacs/TRAMP
# http://www.emacswiki.org/emacs/TrampMode
if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    if function_exists precmd; then
        unfunction precmd
    fi
    if function_exists preexec; then
        unfunction preexec
    fi
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

function precmd() {
    case $TERM in
        screen*|xterm*)
            precmd () {print -Pn "\e]0;%m: %~\a"}
            ;;
    esac
}

alias h="history 25"
alias ll="/bin/ls -lA"
alias sx="$(which screen) -x"
alias smaller="/usr/sbin/vidcontrol 80x43"
alias urmcpw="apg -M SNCL -E '[]{}#%^*+=_\|~<>' -m 10 -x 12 -t"

export PAGER=less
export LESS=FiRX
export BLOCKSIZE=1k
export PARINIT="rTbgqR B=.?_A_a Q=_s>|"
export LC_CTYPE="en_US.UTF-8"

# {{{ Source non-githubbed info.
function {
    local hostname=${$(hostname -s)/vpn-client-*/sonm17mfisher4}
    if [ -e ~/.zshrc.$hostname ]
    then
        source ~/.zshrc.$hostname
    fi
}
# }}}

# {{{ semi-common Mac desktop needs
#
if [ $(/usr/bin/uname -s) = "Darwin" ]
then
    alias flushdns="sudo killall -HUP mDNSResponder"

    # load zsh completions if they're present
    [ -d /usr/local/share/zsh-completions ] && \
        fpath=(/usr/local/share/zsh-completions $fpath)

    # pulls the SSH_AGENT_PID and SSH_AUTH_SOCK environment variables,
    # reformats them as setenv arguments, and places them on the clipboard
    # for pasting
    function copy_ssh_env_screen() {
        /usr/bin/printenv | /usr/bin/grep SSH_A | \
            /usr/bin/awk '{print "export " $1}'| /usr/bin/pbcopy
    }

    function upgrade_emacs () {
        # note: have to do brew tap d12frosted/emacs-plus first
	brew fetch --HEAD emacs-plus@28 && brew uninstall emacs-plus@28
	brew install emacs-plus@28 --with-ctags \
            --with-modern-black-variant-icon
    }

    function mssh () {
        mkdir /Volumes/$1 > /dev/null 2>&1
        if [ $? != 0 ]; then
            sudo -p '[sudo] ' chgrp admin /Volumes && sudo chmod g+w /Volumes
            mkdir /Volumes/$1
        fi
        sshfs -o defer_permissions $1:/ /Volumes/$1
    }
fi
# }}}

function pipupgrade() {
    pip3 install -U $(pip3 list --outdated| awk 'NR>2 {print $1}')
}

if [ $(/usr/bin/uname -s) = "FreeBSD" ]
then
    # run portmaster to search for needed updates
    function pmold() {
          portmaster -L | \
          egrep -B1 '(ew|ort) version|Aborting|installed|dependencies|IGNORE|marked|Reason:|MOVED|deleted|exist|update' | \
          grep -v '^--'
    }

    # load zsh completions if they're present
    [ -d ~/.zsh_packages/zsh-completions ] && \
         fpath=(~/.zsh_packages/zsh-completions $fpath)
fi

# call as new-ssl hostname   -- don't use FQDN
function new-ssl() {
    sudo openssl req -out $*.csr -new -newkey rsa:2048 -nodes -keyout $*.key \
        -subj "/C=US/ST=New-York/L=Rochester/O=University of Rochester/OU=School of Nursing/CN=$*.son.rochester.edu"
    sudo chmod 600 $*.key
}

alias trace_response="curl --insecure --location --verbose --silent -D - -o /dev/null"

# http://chneukirchen.org/blog/archive/2011/02/10-more-zsh-tricks-you-may-not-know.html
# Complete in history with M-/, M-,
zstyle ':completion:history-words:*' list no 
zstyle ':completion:history-words:*' menu yes
zstyle ':completion:history-words:*' remove-all-dups yes
bindkey "\e/" _history-complete-older
bindkey "\e," _history-complete-newer

## move to the end so that they run after the zsh-completions package
## is loaded
autoload -Uz compinit
compinit
