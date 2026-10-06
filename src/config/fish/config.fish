if status is-interactive
  #for void
    abbr -a ls "lsd -al"
    abbr -a xi "sudo xbps-install -S"
    abbr -a xs "sudo xbps-query -Rs"
    abbr -a xrm "sudo xbps-remove -R"
    abbr -a xoo "sudo xbps-remove -OOo"
  # for distrobox

    abbr -a di "sudo dnf install -y"
    abbr -a ds "sudo dnf search"
    abbr -a drm "sudo dnf remove"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end
#path manager distrobox
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx CARGO_HOME "$HOME/.cargo/bin"
set -gx LOCAL_HOME "$HOME/.local/bin"

if test -f /.containersetupdone
  set -gx PATH "$CARGO_HOME" "$PNPM_HOME" "$LOCAL_HOME" $PATH
  else
  set -gx PATH "$LOCAL_HOME" $PATH
end
