if status is-interactive
    abbr -a ls "lsd -al"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end

if test -f /run/.containerenv
    set -g fish_user_paths
    set -gx PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
end
