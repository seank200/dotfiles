# Neovim Configuration

My Neovim configuration

![screenshot](screenshot.png)

## Config Overview

- Syntax highlighting, auto-complete suggestions
- Format on save and linter messages
- Fuzzy file and text searching
- Diff and conflict viewer
- Smart split/resizing: (plays nicely with `tmux`)

## Requirements

- [Neovim](https://neovim.io): Latest stable release (tested on 0.9.4)
- [Git](https://git-scm.com)
- [GNU Make](https://www.gnu.org/software/make/)
- [fzf](https://github.com/junegunn/fzf#installation): Improve fuzzy search performance
- [rg](https://github.com/BurntSushi/ripgrep#installation): Search text within directory files (and more)
- [gnu-sed](https://www.gnu.org/software/sed/) ([Homebrew](https://formulae.brew.sh/formula/gnu-sed))
- [NodeJS & NPM](https://nodejs.org): Building some of the dependencies
- [Nerd fonts](https://www.nerdfonts.com) patched font
    - Installation instructions at the [Nerd Fonts repo](https://github.com/ryanoasis/nerd-fonts)

### macOS (Homebrew)

```bash
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
```

```bash
brew install neovim fzf ripgrep gnu-sed
```

## Clean up

If you have existing configurations, run the following first to remove them.

```bash
if [[ -d ~/.config/nvim ]]; then; mv ~/.config/nvim ~/.config/nvim.bak; fi
if [[ -d ~/.local/share/nvim ]]; then; rm -rf ~/.local/share/nvim; fi
if [[ -d ~/.local/state/nvim ]]; then; rm -rf ~/.local/state/nvim; fi
if [[ -d ~/.cache/nvim ]]; then; rm -rf ~/.cache/nvim; fi
```

Launch Neovim and confirm that it has been restored to default configurations.

## Install Config

```bash
git clone https://github.com/seanK200/nvim-config.git ~/.config/nvim
```

## (Optional) Install Neovim Providers

```bash
pip install -U neovim
npm install -g neovim
```

## Troubleshooting

If some dependencies fail to install, re-launch Neovim with the following commands.

```bash
nvim +PackerSync
```

Check that everything went well with the `checkhealth` Neovim command. You should see no `ERROR` messages.

```vim
:checkhealth
```

