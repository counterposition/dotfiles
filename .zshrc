export CLICOLOR=1
PROMPT='%~ 👉 '

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

precmd() { print "" }

# asdf
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

. $HOME/.asdf/asdf.sh
