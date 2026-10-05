if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a si "sudo pacman -Sy"
    abbr -a ls "lsd -al"
    abbr -a ss "sudo pacman -Ss"
    abbr -a srm "sudo pacman -Rs"
    abbr -a scl "sudo pacman -Scc"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end

if test -f /run/.containerenv
    # Kosongkan universal paths host agar tidak disisipkan otomatis di dalam container
    set -g fish_user_paths
    
    # Reset PATH ke standard default container
    set -gx PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
end
