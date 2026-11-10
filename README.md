# Dotfiles

This repository contains my dotfiles used to configure the tools I use for programming. 

The files are managed using [chezmoi](https://www.chezmoi.io/).

Fish plugins are listed in `dot_config/private_fish/fish_plugins`. Install Fisher
separately, then run `fisher update` in fish to install or update the listed plugins.
Fisher itself is intentionally omitted from the plugin list. Chezmoi does not
install plugins automatically.

Installed plugin files and fish's `fish_variables` remain unmanaged.
