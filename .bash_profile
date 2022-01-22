export CLICOLOR=1
PROMPT_COMMAND=echo
PS1="\w 👉 "

alias l='ls -l'
alias la='l -A'
alias e=vim
alias p=python3
alias pg=pg_ctl
alias d=docker
alias be='bundle exec'
alias tf=terraform
alias k=kubectl
alias nine=k9s
alias enter='docker run -it --rm'
alias search='mdfind -onlyin .'
alias config='git --git-dir="$HOME/.cfg" --work-tree="$HOME"'

# For command line utilities not installed from a package manager
export PATH="$HOME/Applications/bin:$PATH"

# For Poetry
export PATH="$HOME/.local/bin:$PATH"

# Self-explanatory
. "$HOME/.cargo/env"
export PGDATA=/opt/homebrew/var/postgres
export EDITOR=vim
export VISUAL='code --wait'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. $HOME/.asdf/asdf.sh

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
