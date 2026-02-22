# Chezmoi Dotfiles Repository

## What This Is
Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/). Configures: Neovim, Fish shell, Tmux, Alacritty, Git, and IdeaVim.

## Chezmoi Conventions
- `dot_` prefix → becomes `.` when deployed (e.g., `dot_gitconfig` → `.gitconfig`)
- `private_` prefix → restrictive file permissions
- `.tmpl` suffix → Go template, processed by chezmoi before deployment
- Templates use `{{ .variable }}` syntax and chezmoi data (OS, hostname, custom vars)
- **Do not rename files** without understanding chezmoi naming — the prefix/suffix system is how chezmoi maps source to target paths

## Project Structure
```
dot_config/
  nvim/                    # Neovim config (Lua)
    init.lua               # Entry point → requires christianschleifer module
    lua/christianschleifer/
      init.lua             # Main module: loads set, remap, lazy_init; sets up autocmds
      set.lua              # Editor settings (line numbers, search, splits, etc.)
      remap.lua            # Core keybindings (leader = Space)
      lazy_init.lua        # lazy.nvim plugin manager bootstrap
      lazy/                # Plugin specs (one file per plugin/group)
  alacritty/alacritty.toml # Terminal config
  private_fish/config.fish.tmpl  # Fish shell (templated for work/personal)
dot_gitconfig.tmpl         # Git config (templated for user identity/signing)
dot_tmux.conf.tmpl         # Tmux config (templated for OS differences)
dot_ideavimrc              # JetBrains Vim emulation
```

## Neovim Architecture
- Plugin manager: **lazy.nvim** (auto-bootstraps if missing)
- Plugin specs live in `lua/christianschleifer/lazy/` — each file returns a lazy.nvim spec table
- LSP servers: rust_analyzer, pyright, lua_ls, marksman, jsonls, jdtls
- Completion: blink.cmp (not nvim-cmp)
- Formatter: conform.nvim (stylua, black, jq, prettier, google-java-format)
- Color scheme: tokyonight
- Leader key: Space

## Key Patterns
- **OS-conditional config**: Templates check `{{ .chezmoi.os }}` for darwin vs linux differences (shell paths, clipboard, mouse)
- **Work/personal split**: Fish config has `{{ if eq .chezmoi.config.data.work "true" }}` conditional blocks
- **Neovim plugins**: Each plugin file in `lazy/` is self-contained with its own config/keybindings — keep this pattern when adding plugins
- **Format on save**: Enabled via conform.nvim for most languages (disabled for C/C++)

## When Editing
- After changing source files, run `chezmoi apply` to deploy (or `chezmoi diff` to preview)
- Neovim plugin files are self-contained — add new plugins as new files in `dot_config/nvim/lua/christianschleifer/lazy/`
- Template files (`.tmpl`) must be valid Go templates — test with `chezmoi execute-template`
- The `.chezmoiignore` file excludes `README.md` from deployment
