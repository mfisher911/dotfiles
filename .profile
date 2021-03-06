# $FreeBSD: src/share/skel/dot.profile,v 1.23.2.1 2009/08/03 08:13:06 kensmith Exp $
#
# .profile - Bourne Shell startup script for login shells
#
# see also sh(1), environ(7).
#

# remove /usr/games if you want
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:$HOME/bin; export PATH

# Setting TERM is normally done through /etc/ttys.  Do only override
# if you're sure that you'll never log in via telnet or xterm or a
# serial line.
# Use cons25l1 for iso-* fonts
# TERM=cons25; 	export TERM

BLOCKSIZE=K;	export BLOCKSIZE
EDITOR=vi;   	export EDITOR
PAGER=more;  	export PAGER

# set ENV to a file invoked each time sh is started for interactive use.
ENV=$HOME/.shrc; export ENV

# Keep things simple for Emacs/tramp
case "$TERM" in
"dumb")
    PS1="$ "; return;
esac

if [ -x /usr/games/fortune ] ; then /usr/games/fortune -o ; fi

case $- in *i*)
    # interactive, so switch to zsh
    which zsh > /dev/null 2>&1 && tty > /dev/null 2>&1 && exec zsh -l
    ;;
esac
