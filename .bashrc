# Exit early for non-interactive shells
[[ $- != *i* ]] && return

# Shell aliases
alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -la'
alias e=nvim
alias view='nvim -R'
alias p=python3
alias pn=pnpm
alias pnx='pnpm dlx'
alias d=docker
alias oc=opencode

# Git aliases
alias ga='git add'
alias gl='git log'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gsw='git switch'

export EDITOR=nvim

# Additional PATH entries
for dir in "$HOME/.local/bin" "$HOME/.bun/bin" "$HOME/Applications/bin" "$HOME/.lmstudio/bin"; do
  [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
done
export PATH

# grr — cd to git repo root
grr() { cd -- "$(git rev-parse --show-toplevel 2>/dev/null || echo .)"; }

# cdf — fuzzy cd into a subdirectory
#
# Usage:
#   cdf
#   cdf ~/code
#   cdf -a
#   cdf --all ~/src
cdf() {
  local all=0 root_arg=. target arg

  for arg in "$@"; do
    case "$arg" in
      -a|--all) all=1 ;;
      *) root_arg=$arg ;;
    esac
  done

  local root
  root=$(realpath "$root_arg")

  local -a fd_args=(--type d --base-directory "$root")

  if (( ! all )); then
    local excl
    for excl in "$HOME/go"; do
      excl=$(realpath "$excl" 2>/dev/null) || continue
      [[ "$excl" != "$root" && "$excl" == "$root"/* ]] &&
        fd_args+=(--exclude "${excl#"$root"/}")
    done
  fi

  target=$(fd "${fd_args[@]}" 2>/dev/null | fzf \
    --height=60% --layout=reverse --border=rounded \
    --prompt="cd > " --header="type to fuzzy-match directories…" \
    --preview="ls -CF --color=always '$root/{}'" \
    --preview-window=right:30%:wrap --select-1 --exit-0)

  [[ -n "$target" ]] && cd -- "$root/$target"
}

# br — broot file navigation
br() {
  local f
  f=$(mktemp)
  broot --outcmd "$f" "$@" && eval "$(<"$f")"
  local ret=$?
  rm -f "$f"
  return "$ret"
}

# Prompt with git integration
__set_prompt() {
  local rc=$?
  local red='\[\e[31m\]' green='\[\e[32m\]' yellow='\[\e[33m\]'
  local blue='\[\e[34m\]' cyan='\[\e[36m\]' reset='\[\e[0m\]'

  local git=
  local branch
  if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
    local flags=
    git diff --cached --quiet 2>/dev/null || flags+="${green}+"
    git diff --quiet 2>/dev/null || flags+="${red}*"

    local action= gd
    gd=$(git rev-parse --git-dir 2>/dev/null)
    [[ -d "$gd/rebase-merge" || -d "$gd/rebase-apply" ]] && action='|rebase'
    [[ -z "$action" && -f "$gd/MERGE_HEAD" ]] && action='|merge'

    git=" ${cyan}(${branch}${action})${reset}${flags}${reset}"
  fi

  local err=
  (( rc )) && err="${red}${rc} ↵${reset} "

  PS1="${err}${green}\u${reset}@${blue}\h${reset}:${yellow}\w${reset}${git} \$ "
}
PROMPT_COMMAND=__set_prompt

# Activate mise
eval "$(mise activate bash)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
