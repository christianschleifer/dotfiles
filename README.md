# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Git signing and GitHub SSH

Set `work = "true"` in chezmoi's `[data]` configuration on work machines. This
disables automatic commit signing and leaves the machine's SSH config unmanaged.

Personal Macs use SSH commit signing with `~/.ssh/github.pub` and its matching
private key at `~/.ssh/github`. The managed SSH config uses that pair for GitHub.

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
