# Install(if necessary) and load zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Snippets
zinit snippet OMZP::gitignore
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase # erase duplicates inside the history file
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# zsh-completions: Load completions
autoload -U compinit && compinit
zinit cdreplay -q

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colored
zstyle ':completion:*' menu no

# junegunn/fzf
if command -v fzf &> /dev/null
then
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

  eval "$(fzf --zsh)"

  zinit light Aloxaf/fzf-tab

  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
else
  echo "zshrc: Command 'fzf' not found. Skipping configuration"
fi

# ajeetdsouza/zoxide
if command -v zoxide &> /dev/null
then
  eval "$(zoxide init --cmd cd zsh)"
else
  echo "zshrc: Command 'zoxide' not found. Skipping configuration"
fi

# eza-community/eza
if command -v eza &> /dev/null
then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=auto --git -a -1 $realpath'
  alias ls="eza --git --icons=auto --group-directories-first"
else
  echo "zshrc: Command 'eza' not found. Skipping configuration"
fi

# Keybindings
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Oh My Posh
if command -v oh-my-posh &> /dev/null
then
  if [[ -d "${HOME}/.config/ohmyposh" ]];then
    OMP_CONFIG_PATH="${HOME}/.config/ohmyposh/catppuccin_macchiato_custom.yaml"
  else
    OMP_CONFIG_PATH="$(brew --prefix oh-my-posh)/themes/catppuccin_macchiato.omp.json"
  fi
  if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $OMP_CONFIG_PATH)"
  fi
else
  echo "zshrc: Command 'oh-my-posh' not found"
fi
