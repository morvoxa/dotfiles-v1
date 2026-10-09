if status is-interactive
  #for void
    abbr -a si "sudo pacman -S"
    abbr -a ss "sudo pacman -Ss"
    abbr -a srm "sudo pacman -Rs"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end

set -gx PNPM_PATH "$HOME/.local/share/pnpm"
set -gx CARGO_HOME "$HOME/.cargo/bin"
set -gx LOCAL_HOME "$HOME/.local/bin"
set -gx PATH "$CARGO_HOME" "$PNPM_PATH" "$LOCAL_HOME" $PATH
