# Steps to bootstrap a new Mac

1. Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew.

    ```zsh
    xcode-select --install
    ```

2. Clone repo into new hidden directory.

    ```zsh
    # Use SSH (if set up)...
    git clone git@github.com:wintrell523/dotfiles.git ~/.dotfiles

    # ...or use HTTPS and switch remotes later.
    git clone https://github.com/wintrell523/dotfiles.git ~/.dotfiles
    ```

3. Install Homebrew.

    ```zsh
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

4. Run dotbot install script

    ```zsh
    cd ~/.dotfiles
    chmod +x install
    ./install
    ```

---

## Running install only to link new dotfiles

```zsh
cd ~/.dotfiles
./install --only link
```

---

## Agent configuration

See [agents/README.md](agents/README.md) for personal instruction links, settings
templates, integration setup, and migration notes. Back up existing instruction
files before enabling the new links.

---

## TODO List

-   Organize these growing steps into multiple script files.
-   Revisit the list in [`.zshrc`](shell/.zshrc) to customize the shell.
-   Find inspiration and examples in other Dotfiles repositories at [dotfiles.github.io](https://dotfiles.github.io/).
