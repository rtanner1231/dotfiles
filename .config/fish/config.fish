if status is-interactive
    # Commands to run in interactive sessions can go here
end

export NVIMQueryKey=Adfsgh344564

set -gx $EDITOR "nvim"
set fzf_dir_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

starship init fish | source
zoxide init fish | source
fzf --fish | source
