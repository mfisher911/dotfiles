function upgrade_emacs
    set -f old_emacsver "emacs-plus@31"
    set -f new_emacsver "emacs-plus@31"
    if brew fetch --HEAD $new_emacsver
        brew uninstall --ignore-dependencies $old_emacsver

        brew install $new_emacsver --with-retro-gnu-meditate-levitate-icon
    else
        echo "Could not fetch $new_emacsver"
    end
end
