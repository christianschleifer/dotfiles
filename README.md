# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Homebrew and mise

On an Apple Silicon Mac, install Homebrew and apply these dotfiles with chezmoi,
then install the packages:

```sh
brew bundle --file="$HOME/.Brewfile"
```

Homebrew installs tools; mise selects the default Python, Node.js, and Java
versions.

## Fish plugins

Plugins are listed in `dot_config/private_fish/fish_plugins`. With Fisher
installed, run `fisher update` in Fish after applying the dotfiles.
