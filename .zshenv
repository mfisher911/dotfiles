if [[ "$(uname -a)" = "Darwin" && "$(uname -m)" = "arm64" ]]; then
    PATH="/opt/homebrew/bin:$PATH:$HOME/bin"
else
    PATH="$PATH:$HOME/bin"
fi
typeset -U PATH path
export PATH
