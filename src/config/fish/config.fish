if status is-interactive
    abbr -a ls "lsd -al"
    abbr -a xi "sudo xbps-install -S"
    abbr -a xs "sudo xbps-query -Rs"
    abbr -a xrm "sudo xbps-remove -R"
    abbr -a xoo "sudo xbps-remove -OOo"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end

if test -f /.containersetupdone
    set -gx PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
end
