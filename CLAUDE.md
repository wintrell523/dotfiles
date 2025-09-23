# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository that uses Dotbot for automated configuration management. The repository manages shell configurations, application settings, and system tools through declarative YAML configuration files.

## Architecture

- **Dotbot Framework**: Uses Dotbot as the core automation tool with custom plugins
- **Configuration Files**: Two main config files - `install.conf.yaml` (full setup) and `install-ci.conf.yaml` (CI/testing)
- **Brewfile Integration**: Uses `dotbot-brewfile` plugin to manage Homebrew packages, casks, and Mac App Store apps
- **Shell Management**: Zsh configuration with zplug for plugin management and Powerlevel10k theme
- **Symlink Strategy**: Creates symlinks from repository files to home directory locations

## Key Commands

### Installation and Setup
```bash
# Full initial setup (run after cloning)
./install

# Link only new dotfiles without running other tasks
./install --only link

# CI testing install (uses install-ci.conf.yaml)
CI=true ./install
```

### Development and Testing
```bash
# Test locally using act (GitHub Actions locally)
act pull_request

# Sync git submodules (if needed)
git submodule sync --quiet --recursive
git submodule update --init --recursive
```

### Package Management
```bash
# Install/update Homebrew packages via Brewfile
brew bundle install --file=Brewfile

# Generate current Brewfile from installed packages
brew bundle dump --file=Brewfile --force
```

## Configuration Structure

### Main Config Files
- `install.conf.yaml`: Full installation configuration including Brewfile processing
- `install-ci.conf.yaml`: Minimal configuration for CI testing
- `Brewfile`: Homebrew package definitions (taps, brews, casks, mas apps, vscode extensions)

### Directory Structure
- `shell/`: Zsh configuration files (.zshrc, .zprofile, aliases, functions)
- `git/`: Git configuration (.gitconfig, .gitignore_global)
- `ssh/`: SSH client configuration
- `node/`: Node.js/npm configuration (.npmrc, .yarnrc)
- `vscode/`: VS Code settings and extensions
- `iterm2/`: iTerm2 configuration and color schemes

### Key Dotbot Plugins Used
- **dotbot-brewfile**: Manages Homebrew packages and applications
- **Built-in plugins**: link, clean, create, shell

## Development Workflow

When making changes to dotfiles:

1. Edit configuration files in the repository
2. Test changes with `./install --only link` for quick symlink updates
3. For Brewfile changes, test with `brew bundle install --file=Brewfile`
4. Use CI workflow to test complete installation on fresh environment

## Important Files

- `install`: Main installation script that detects CI environment and uses appropriate config
- `shell/.zshrc`: Primary shell configuration with zplug plugin management
- `Brewfile`: Complete package manifest for macOS applications and tools
- `.github/workflows/test.yml`: CI pipeline that tests dotbot installation process