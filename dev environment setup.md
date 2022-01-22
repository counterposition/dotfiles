# Setting up your dev environment from scratch

## What we will be installing

1. Rustup
    1. tealdeer
    1. fd-find
    1. ripgrep
    1. broot
1. Homebrew
    1. GitHub CLI
    1. Go
    1. asdf (to install and manage Ruby, Node.js, Python, and Java)
        1. gpg and gawk are dependencies
    1. fzf
1. Visual Studio Code

## The installation process

### Set up your dotfiles and text editor

To fetch your dotfiles from GitHub you will first need access to git.
And to get access to git you first need to install Xcode command line utilities.
So let's do that first.
Open up a Terminal window and just type `git --version`. macOS will automatically prompt you to install the command line tools.

Once you have installed the command line tools, create a root directory for all your code, switch to it, and fetch your dotfiles from GitHub

```shell
git clone https://github.com/hkukreja/dotfiles
```

Now carefully copy each dotfile to your home directory. Watch out for `eval`s of software that doesn't yet exist on the new system, like *asdf*. Comment these out for now.

Install Visual Studio Code for a graphical text editor.

### Install the Rust toolchain

Go to [the rustup homepage](rustup.rs) and run the command listed there.

After you're done adding the right commands to your shell config files to put `cargo` on your `PATH` and such, install the aforementioned utilities

```shell
cargo install tealdeer fd-find ripgrep broot
```

### Install Node.js, Python, Ruby, and other language toolchains

First, install *asdf* and its associated plugin for Node.js.

Next, install the latest LTS release of Node.js by running `asdf install nodejs <version>`

Set the global Node.js version with `asdf global nodejs <version>`.
This version will be used by default unless overriden per-project by `asdf local nodejs <version>`.

Apply these steps for Python, Ruby, and whatever else you wish to install.

### Install Homebrew

Go to the [Homebrew homepage](brew.sh) and run the command listed there.

After you're done adding the right commands to your shell config (probably `.zprofile`), install the aforementioned utilities

```shell
brew install gh go
```

Now get the login token for GitHub CLI by running `gh auth login`.

### Other configuration

#### Node.js

If you installed Node.js earlier, be sure to edit your global npm config:

```shell
npm config -g set init-author-name 'Harish Kukreja'
npm config -g set init-author-email 'your.email@domain.tld'
```

#### Python

If you installed Python earlier, be sure to install Poetry and configure it so that it creates virtualenvs in the project root instead of `~/Library/Caches`.

Install Poetry from its official website using the showcased shell script.

Afer that, ensure your `PATH` has been updated accordingly.
Finally, run `poetry config virtualenvs.in-project true` to make it create all virtualenvs in the project root

You're all set. Happy hacking!
