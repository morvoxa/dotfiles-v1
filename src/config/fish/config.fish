if status is-interactive
    abbr -a ls "lsd -al"
    abbr -a xi "sudo xbps-install -S"
    abbr -a xs "sudo xbps-query -Rs"
    abbr -a xrm "sudo xbps-remove -R"
    abbr -a xoo "sudo xbps-remove -OOo"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end

# pnpm
set -gx PNPM_HOME "/home/mor/.local/share/pnpm"
set -gx CARGO_HOME "/home/mor/.cargo/bin"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$CARGO_HOME" "$PNPM_HOME" $PATH
end
# pnpm end
