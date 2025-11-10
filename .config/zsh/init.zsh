export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"


# ========= Define Utility Functions ========
function __pathprepend() {
	[ -d "$1" ] && export PATH="$1:$PATH"
}


# ======== Homebrew ========
if [ -d "/opt/homebrew/bin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "$(brew --prefix)/share/zsh/site-functions" ]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
fi


# ======== Plugin Manager (zinit) ========
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"


# History
HISTSIZE=9999999
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward


# zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_FUZZY='true'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up  # up arrow
bindkey '^[[B' history-substring-search-down  # down arrow

# zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions
bindkey '^f' autosuggest-accept
zstyle ':autocomplete:*' min-input 3

# sindresorhus/pure
zinit ice compile src'pure.zsh'
zinit light sindresorhus/pure

autoload -Uz promptinit; promptinit
prompt_newline='%666v'
PROMPT=" $PROMPT"

print() { # No newlines between propmts 
  [[ $# -eq 0 && ${funcstack[-1]} = prompt_pure_precmd ]] || builtin print "$@"
}


zinit light zsh-users/zsh-completions

zinit light zdharma-continuum/fast-syntax-highlighting

zinit snippet OMZP::gitignore

zinit snippet OMZP::sudo


# ======== Autocomplete ========
zstyle ':completion:*' menu no					# show menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'		# case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"		# colored ls
autoload -Uz compinit && compinit


__pathprepend "$HOME/.local/bin"
__pathprepend "$HOMEBREW_PREFIX/opt/openjdk@17/bin"
__pathprepend "$HOMEBREW_PREFIX/opt/postgresql@16/bin"

if [[ -d $NVM_DIR ]]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [[ -d $PYENV_ROOT ]]; then
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi


if command -v fzf &> /dev/null
then
	export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
	export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type=d"

	# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
	# - The first argument to the function ($1) is the base path to start traversal
	# - See the source code (completion.{bash,zsh}) for the details.
	_fzf_compgen_path() {
		fd --hidden --exclude .git . "$1"
	}

	# Use fd to generate the list for directory completion
	_fzf_compgen_dir() {
		fd --type=d --hidden --exclude .git . "$1"
	}

	source <(fzf --zsh)
	
	zinit light Aloxaf/fzf-tab

	if command -v eza &> /dev/null
	then
		zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=auto --git -a -1 $realpath'
	else
		zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color -1 $realpath'
	fi
fi

if command -v zoxide &> /dev/null
then
	eval "$(zoxide init --cmd cd zsh)"
fi

if command -v eza &> /dev/null
then
	alias ls="eza --color=never --icons=never --group-directories-first --git"
fi

if command -v nvim &> /dev/null
then
  export EDITOR="nvim"
fi

alias tree="ls --tree"
