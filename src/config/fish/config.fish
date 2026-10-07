if status is-interactive
  #for void
    abbr -a ls "lsd -al"
    abbr -a xis "sudo xbps-install -S"
    abbr -a xs "sudo xbps-query -Rs"
    abbr -a xrm "sudo xbps-remove -R"
    abbr -a xoo "sudo xbps-remove -OOo"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PNPM_PATH "$HOME/.local/share/pnpm/bin"
set -gx CARGO_HOME "$HOME/.cargo/bin"
set -gx LOCAL_HOME "$HOME/.local/bin"
set -gx PATH "$CARGO_HOME" "$PNPM_PATH" "$LOCAL_HOME" $PATH
