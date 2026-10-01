# start tmux in UTF-8 mode (without -u, braille shows up as underscores)
if status is-interactive
    if not set -q TMUX
        exec tmux -u
    end
end

# show the fetch once, inside tmux
if status is-interactive; and set -q TMUX
    fastfetch
end
