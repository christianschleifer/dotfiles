function dev
    # Create session, name first window 'main'
    tmux new-session -d -s default -n main
    
    # Create 'term' window in the background (-d) so focus stays on 'main'
    tmux new-window -d -t default -n term
    
    # Attach
    tmux attach-session -t default
end
