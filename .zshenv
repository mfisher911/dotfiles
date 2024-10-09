if [[ "$(uname -s)" = "Darwin" && "$(uname -m)" = "arm64" ]]; then
    PATH="/opt/homebrew/bin:$PATH:$HOME/bin:$HOME/.local/bin"

    export LDFLAGS="-L/opt/homebrew/opt/readline/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/readline/include"
    export COMPlus_EnableDiagnostics=0  # for MS Python LSP
else
    PATH="$PATH:$HOME/bin:$HOME/.local/bin"
fi
typeset -U PATH path
export PATH
export GEM_HOME=~/.ruby/gems
export TMPDIR=$HOME/.tmp
export XDG_RUNTIME_DIR=$HOME/.tmp
