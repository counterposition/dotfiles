# Shell aliases
alias l='ls -l'
alias la='ls -la'
alias e=nvim
alias view='nvim -R'
alias p=python3
alias pn=pnpm
alias pnx='pnpm dlx'
alias d=docker
alias oc=opencode

# git aliases
alias ga='git add'
alias gl='git log'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

export CLICOLOR=1
export EDITOR=nvim
export VISUAL='cursor --wait'

# Applications installed using package managers other than Homebrew, and custom shell scripts
path+=(
  "$HOME/.local/bin"
  "$HOME/.bun/bin"
  "$HOME/Applications/bin"
  "$HOME/.lmstudio/bin"
  /Applications/Obsidian.app/Contents/MacOS
)

# Lazy-load my custom shell functions
fpath+=( ~/.zfunctions )
for func in ~/.zfunctions/*; do
  autoload -Uz ${func:t}
done

# Prompt with git integration (uses built-in vcs_info for speed)
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:git:*' formats ' %F{cyan}(%b)%f%c%u'
zstyle ':vcs_info:git:*' actionformats ' %F{cyan}(%b|%a)%f%c%u'

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

PROMPT='%F{green}%n%f@%F{blue}Quint%f:%F{yellow}%~%f${vcs_info_msg_0_} %# '
RPROMPT='%(?..%F{red}%? ↵%f)'

# Automatically included by the broot post-install script
function br {
    f=$(mktemp)
    (
	set +e
	broot --outcmd "$f" "$@"
	code=$?
	if [ "$code" != 0 ]; then
	    rm -f "$f"
	    exit "$code"
	fi
    )
    code=$?
    if [ "$code" != 0 ]; then
	return "$code"
    fi
    d=$(<"$f")
    rm -f "$f"
    eval "$d"
}

# Activate mise hook
eval "$(mise activate zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)