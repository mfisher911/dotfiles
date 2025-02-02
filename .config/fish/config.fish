# -*- mode:fish -*-
if status is-interactive
    # Commands to run in interactive sessions can go here

    # https://superuser.com/a/944589/14385
    function bind_bang
        switch (commandline -t)[-1]
            case "!"
                commandline -t -- $history[1]
                commandline -f repaint
            case "*"
                commandline -i !
        end
    end

    function bind_dollar
        switch (commandline -t)[-1]
            case "!"
                commandline -f backward-delete-char history-token-search-backward
            case "*"
                commandline -i '$'
        end
    end

    function fish_user_key_bindings
        bind ! bind_bang
        bind '$' bind_dollar
    end

    set -gx VISUAL /opt/homebrew/bin/emacsclient -quw 15
    set -gx EDITOR /opt/homebrew/bin/emacsclient -quw 15

end
