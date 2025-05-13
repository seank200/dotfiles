# ========= Set XDG Path =========
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"


# ========= Define Utility Functions ========
function __pathprepend() {
	[ -d "$1" ] && export PATH="$1:$PATH"
}


# ======== Homebrew ========
[ -d "/opt/homebrew/bin" ] && eval "$(/opt/homebrew/bin/brew shellenv)"


# ======== ZSH Options ========

# History options
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

if command -v nvm &> /dev/null
then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if command -v pyenv &> /dev/null
then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi


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
	alias ls="eza --color=auto --icons=never --group-directories-first --git"
fi

if command -v nvim &> /dev/null
then
  export EDITOR="nvim"
fi


# ======== Configure Autocomplete ========
zstyle ':completion:*' menu no					# show menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'		# case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"		# colored ls
autoload -Uz compinit


# ======== Prompt ========
setopt prompt_subst  # enable prompt parameter substitution

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn  # only enable specific backends
zstyle ':vcs_info:*' check-for-changes true  # enables %u, %c
zstyle ':vcs_info:*' unstagedstr '~'  # unstaged changes
zstyle ':vcs_info:*' stagedstr '+'  # staged changes
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# Inside VCS repository
# - %r: Repository name
# - %S: Repository subdirectory
# - %c: staged changes (stagedstr)
# - %u: unstaged changes (unstagedstr)
# - %m: misc (see set-message hooks below)
zstyle ':vcs_info:*' formats '%F{blue}%B%r%%b%S%f %b%F{green}%c%F{red}%u%F{magenta}%m%f'

# Ongoing action (e.g. interactive rebase, merge conflict, etc.)
# - (identical to 'formats' above)
# - %a: action
zstyle ':vcs_info:*' actionformats '%F{blue}%B%r%%b%S%f %b%F{green}%c%F{red}%u%F{magenta}%m%f %F{yellow}%B%a%%b%f'

# No VCS detected 
# - %~: cwd (with $HOME replaced with '~') 
zstyle ':vcs_info:*' nvcsformats '%~'

zstyle ':vcs_info:git*+set-message:*' hooks git-st

+vi-git-st(){
    git rev-parse --is-inside-work-tree &>/dev/null || return

    hook_com[subdir]="/${hook_com[subdir]}"
    hook_com[subdir]="${hook_com[subdir]%%/.}"

    local ahead behind
    local -a gitstatus

    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "+${ahead// /}" )

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "-${behind// /}" )

    if [[ $ahead -gt 0 || $behind -gt 0 ]]; then
      hook_com[misc]+=" [${(j:|:)gitstatus}]"
    fi
    
    # If there are untracked files in repo
    if git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[unstaged]='~'
    fi

    stashed=$(git stash list --no-color --oneline | wc -l)
    if [[ $stashed -gt 0 ]]; then
      hook_com[unstaged]+='*'
    fi
}

precmd () { vcs_info }

PROMPT='$vcs_info_msg_0_ %B%(?.%#.%F{red}?%? %#%f)%b '

# ======== Aliases ========
alias ll="ls -l"
alias la="ls -la"
alias tree="ls --tree"
