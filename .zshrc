export CLICOLOR=1
PROMPT='%~ 👉 '

alias l='ls -l'
alias la='l -a'
alias e=vim
alias p=python3

eval "$(fnm env)"

precmd() { print "" }
