# ========= Set XDG Path =========
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export EDITOR="nvim"

# ========= Define Utility Functions ========
function __pathprepend() {
	[ -d "$1" ] && export PATH="$1:$PATH"
}

function __git_symbols() {
	# Symbols
	local ahead='↑'
	local behind='↓'
	local diverged='↕'
	local no_remote=''
	local staged='+'
	local untracked='?'
	local modified='!'
	local moved='>'
	local deleted='x'
	local stashed='*'

	local output_symbols=''

	local git_status_v
	git_status_v="$(git status --porcelain=v2 --branch --show-stash 2>/dev/null)"

	# Parse branch information
	local ahead_count behind_count

	# AHEAD, BEHIND, DIVERGED
	if echo $git_status_v | grep -q "^# branch.ab " ; then
		# One line of the git status output looks like this:
		# # branch.ab +1 -2
		# In the line below:
		# - we grep for the line starting with # branch.ab
		# - we grep for the numbers and output them on separate lines
		# - we remove the + and - signs
		# - we put the two numbers into variables, while telling read to use a newline as the delimiter for reading
		read -d "\n" -r ahead_count behind_count <<< $(echo "$git_status_v" | grep "^# branch.ab" | grep -o -E '[+-][0-9]+' | sed 's/[-+]//')
		# Show the ahead and behind symbols when relevant
		[[ $ahead_count != 0 ]] && output_symbols+=" %F{blue}$ahead$ahead_count%f"
		[[ $behind_count != 0 ]] && output_symbols+=" %F{blue}$behind$behind_count%f"
	fi

	# STASHED
	echo $git_status_v | grep -q "^# stash " && output_symbols+=" $stashed"

	# STAGED
	[[ $(git diff --name-only --cached) ]] && output_symbols+=" $staged"

	# For the rest of the symbols, we use the v1 format of git status because it's easier to parse.
	local git_status

	symbols="$(git status --porcelain=v1 | cut -c1-2 | sed 's/ //g')"

	local untracked_count=0
	local modified_count=0
	local moved_count=0
	local deleted_count=0

	while IFS= read -r symbol; do
		case $symbol in
			??) (( untracked_count += 1 )) ;;
			M) (( modified_count += 1 )) ;;
			R) (( moved_count += 1 )) ;;
			D) (( deleted_count += 1 )) ;;
		esac
	done <<< "$symbols"

	[[ $untracked_count != 0 ]] && output_symbols+=" %F{green}$untracked$untracked_count%f"
	[[ $modified_count != 0 ]] && output_symbols+=" %F{yellow}$modified$modified_count%f"
	[[ $moved_count != 0 ]] && output_symbols+=" %F{yellow}$moved$moved_count%f"
	[[ $deleted_count != 0 ]] && output_symbols+=" %F{red}$deleted$deleted_count%f"

	[[ -n $output_symbols ]] && echo -n "$output_symbols"
}


# Function to display Git status with symbols
function __git_info() {
	local git_info=''
	local git_branch_name=''

	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		# Get the Git branch name
		git_branch_name="$(git symbolic-ref --short HEAD 2>/dev/null)"
		if [[ -n "$git_branch_name" ]]; then
			git_info+="%F{magenta}󰘬 $git_branch_name%f"
		fi
		# Get the Git status
		git_info+="$(__git_symbols)"
		echo "$git_info "
	fi
}


# ======== Homebrew ========
[ -d "/opt/homebrew/bin" ] && eval "$(/opt/homebrew/bin/brew shellenv)"


# ======== ZSH Options ========

# History options
HISTSIZE=99999999
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


# ======== Plugin Manager ========
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"


# ======== Initialize Plugins ========
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up  # up arrow
bindkey '^[[B' history-substring-search-down  # down arrow
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_FUZZY='true'

zinit light zsh-users/zsh-autosuggestions
bindkey '^f' autosuggest-accept
zstyle ':autocomplete:*' min-input 3

zinit light zsh-users/zsh-completions

zinit snippet OMZP::gitignore
zinit snippet OMZP::sudo


# ======== Configure Development Environment ========
__pathprepend "$HOME/.local/bin"
__pathprepend "$HOMEBREW_PREFIX/opt/openjdk@17/bin"
__pathprepend "$HOMEBREW_PREFIX/opt/postgresql@16/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


# ======== Configure Command Line Utilities ========
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
	alias ls="eza --color=never --icons=auto --group-directories-first --git"
fi


# ======== Configure Autocomplete ========
zstyle ':completion:*' menu no					# show menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'		# case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"		# colored ls
autoload -Uz compinit


# ======== Prompt ========
setopt prompt_subst  # enable prompt parameter substitution

PROMPT=''
PROMPT+='%F{blue}%~%f '			# cwd (substitute home directory with '~')
PROMPT+='$(__git_info)'	# git
PROMPT+='%(?.%#.%F{red}%#%f) '		# red prompt if previous command has a non-zero exit code


# ======== Aliases ========
alias ll="ls -l"
alias la="ls -a"
alias tree="ls --tree"
