if [[ "$(uname -s)" = "Darwin" && "$(uname -m)" = "arm64" ]]; then
    PATH="/opt/homebrew/bin:$PATH:$HOME/bin:$HOME/.local/bin"

    export LDFLAGS="-L/opt/homebrew/opt/readline/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/readline/include"
else
    PATH="$PATH:$HOME/bin"
fi
typeset -U PATH path
export PATH
