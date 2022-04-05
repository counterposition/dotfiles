export CLICOLOR=1
export EDITOR=vim
export VISUAL='code -w'

bindkey -e

alias l='ls -l'
alias la='l -A'
alias e=vim
alias p=python3
alias pn=pnpm
alias pg=pg_ctl
alias d=docker
alias be='bundle exec'
alias tf=terraform
alias k=kubectl
alias nine=k9s

# sindresorhus/pure prompt
fpath+=("$HOME/.zsh/pure")
autoload -U promptinit; promptinit
prompt pure

# Other ZSH completions
fpath+=("/opt/homebrew/share/zsh/site-functions")

# Custom ZSH completions
fpath+=("$HOME/.zsh/functions") 

# pe stands for "path exists?"
# Checks whether the given argument exists as a file or a folder
# If it exists, the function prints "$1 is a [file|directory]". Otherwise it prints nothing
function pe {
	if [[ -f $1 ]]; then
		echo $1 is a file
	elif [[ -d $1 ]]; then
		echo $1 is a directory
	fi
}	

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

# asdf
fpath+=("$HOME/.asdf/completions")
autoload -Uz compinit && compinit

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
complete -C /usr/local/bin/aws_completer aws


. $HOME/.asdf/asdf.sh

# Functions

function grr {
	cd $(git rev-parse --show-toplevel)
}
