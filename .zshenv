typeset -U PATH path
path=("$HOME/bin" "$HOME/.cask/bin" "$HOME/.local/bin"
      "/usr/local/opt/postgresql@9.5/bin" "/usr/local/sbin" "$path[@]")
export PATH
