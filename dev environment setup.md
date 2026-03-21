# Setting up your dev environment from scratch

## What we will be installing

1. Homebrew
    1. GitHub CLI
    1. tlrc
    1. fd
    1. ripgrep
    1. fzf
    1. anomalyco/tap/opencode
1. Using mise, install
    1. Python
    1. uv
    1. Node.js
    1. Go

1. Cursor

## The installation process

### Set up your dotfiles and text editor

To fetch your dotfiles from GitHub you will first need access to git.
And to get access to git you first need to install Xcode command line utilities.
So let's do that first.
Open up a Terminal window and just type `git --version`. macOS will automatically prompt you to install the command line tools.

Once you have installed the command line tools, create a root directory for all your code, switch to it, and fetch your dotfiles from GitHub

```shell
gh repo clone https://github.com/hkukreja/dotfiles
```

Now carefully copy each dotfile to your home directory. Watch out for `eval`s of software that doesn't yet exist on the new system, like *mise*. Comment these out for now.

You're all set. Happy hacking!
