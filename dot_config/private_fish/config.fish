set -g fish_greeting 'Hey, Christian!'
fish_vi_key_bindings

bind \cf accept-autosuggestion
bind -M insert \cf accept-autosuggestion
bind -M insert \cr history-pager repaint-mode
bind -m insert \cr history-pager repaint-mode


bind -M insert \cj down-or-search
bind -M insert \ck up-or-search

fish_add_path /usr/local/bin 
fish_add_path /opt/homebrew/bin
fish_add_path /Users/christian/.local/bin
fish_add_path /Users/christian/go/bin
fish_add_path /Users/christian/.cargo/bin

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -al'
end

set -Ux VISUAL 'nvim'
set -Ux EDITOR $VISUAL
