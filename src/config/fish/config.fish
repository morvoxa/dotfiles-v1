if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a si "sudo pacman -Sy"
    abbr -a ls "lsd -al"
    abbr -a ss "sudo pacman -Ss"
    abbr -a srm "sudo pacman -Rs"
    abbr -a scl "sudo pacman -Scc"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end
