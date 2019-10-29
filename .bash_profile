alias l='ls -l'
alias la='ls -al'
alias e=vim
alias d=docker
alias enter='docker run -it --rm'
alias search='mdfind -onlyin .'
alias config='git --git-dir="$HOME/.cfg" --work-tree="$HOME"'

PS1="
\w 👉 "

export PATH="/Users/me/Applications/jdk-12.0.2.jdk/Contents/Home/bin:$PATH"
export EDITOR=vim
export VISUAL='code --wait'
export CLICOLOR=1
export JAVA_HOME="/Users/me/Applications/jdk-12.0.2.jdk/Contents/Home"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -e /Users/me/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/me/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

