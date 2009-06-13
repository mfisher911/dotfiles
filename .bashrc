if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_`hostname` ]; then
    . ~/.bash_`hostname`
fi

export PATH=~/bin:${PATH}
