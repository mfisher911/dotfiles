if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_`hostname` ]; then
    . ~/.bash_`hostname`
fi

export PATH=~/bin:${PATH}
export PAGER=less
export RSYNC_RSH=ssh

# add tab-completion for sshing to various hosts
# http://blog.zerodogg.org/2007/04/21/bash-ssh-host-completion/
complete -C "perl -le'\$p=qq#^\$ARGV[1]#;@ARGV=q#$HOME/.ssh/config#;/\$p/&&/^\D/&&not(/[*?]/)&&print for map{split/\s+/}grep{s/^\s*Host(?:Name)?\s+//i}<>'" ssh

# add tab-completion for git
# http://openmelody.org/blog/2010/01/git-tip-auto-completion-for-local-branches-and-remotes
complete -f -W "$(echo `git branch | sed -e s/[\ \*]//g | cut -f 1 -d ' ' | uniq`; \
    echo `git remote | sed -e s/[\ \*]//g | cut -f 1 -d ' ' | uniq`; \
    echo `git | tail -23 | head -21 | cut -d ' ' -f 4`);" git

# properly source .gpg-agent-info for ssh-keychain
if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
fi
