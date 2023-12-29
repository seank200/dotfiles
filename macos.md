# Configuring macOS for Development

## Requirements

- [Python](https://www.python.org)
- [NodeJS](http://nodejs.org/)

## CLI

### Xcode Command Line Tools

```bash
xcode-select --install
```

### Homebrew

- [Homebrew](https://brew.sh): Package manager

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Terminal Emulator Setup (iTerm2)

[Nerd Fonts](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts): JetBrains Mono Nerd Font

```bash
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
```

[iTerm2](https://iterm2.com): Terminal Emulator

```bash
brew install --cask iterm2
```

[Catppuccin for iTerm](https://github.com/catppuccin/iterm): Color Scheme for iTerm2

```bash
git clone https://github.com/catppuccin/iterm.git ~/catppuccin/iterm
```

After install, configure iTerm2 profiles (colorscheme and patched font).

### CLI Tools

- [Github CLI](https://github.com/cli/cli): `gh`
- [Neovim](https://neovim.io)
    - [Installation Docs](https://github.com/neovim/neovim/blob/master/INSTALL.md)
    - NodeJS and Python providers for Neovim
- [tmux](https://github.com/tmux/tmux/wiki): Terminal Multiplexer
- [fzf](https://github.com/junegunn/fzf): Fuzzy Finder
- [ripgrep](https://github.com/BurntSushi/ripgrep): `rg` Improved grep
- [gnu-sed](https://www.gnu.org/software/sed/) ([Homebrew](https://formulae.brew.sh/formula/gnu-sed))
- [The Silver Searcher](https://github.com/ggreer/the_silver_searcher): `ag`
- [`wget`](https://www.gnu.org/software/wget/)

```bash
brew install gh neovim tmux fzf ripgrep the_silver_searcher gnu-sed wget
```

### Zsh

#### Install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Install [Powerlevel10k](https://github.com/romkatv/powerlevel10k#manual)

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i -E 's/ZSH_THEME=".+"$/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
```

#### Install Oh My Zsh Plugins

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### Activate

```bash
sed -i -E 's/plugins=\(.*\)/plugins=(zsh-autosuggestions zsh-syntax-highlighting gitignore)/'
```

### Dotfiles

```bash
git clone https://github.com/seank200/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
```

#### Neovim

```bash
if [[ -d ~/.config/nvim ]]; then; mv ~/.config/nvim ~/.config/nvim.bak; fi
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
ln -s ~/.config/dotfiles/nvim ~/.config/nvim
nvim
```

> Nerd Fonts must be installed and applied for configurations to be correctly rendered.

#### Tmux

Install Tmux Package Manager (TPM) first.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Link configuration files

```bash
if [[ -d ~/.config/tmux ]]; then; mv ~/.config/tmux ~/.config/tmux.bak; fi
ln -s ~/.config/dotfiles/tmux ~/.config/tmux
tmux source-file ~/.config/tmux/tmux.conf
```

Press `prefix + I` (capital i, as in Install) to fetch plugins using `tpm`.

## Development Environment

### Mongosh

### Anaconda

## Apps (Optional)

- [Alfred](https://www.alfredapp.com)
- [VSCode](https://code.visualstudio.com)

