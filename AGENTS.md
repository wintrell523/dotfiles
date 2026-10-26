# Repository Guidelines

## Project Structure & Module Organization

This repository manages macOS dotfiles with Dotbot. `install` selects `install.conf.yaml` for normal setup and `install-ci.conf.yaml` when `CI=true`. Keep shared symlink changes consistent across both configurations.

- `shell/`: shell startup files, exports, and Vim settings; `shell/.zsh/` groups aliases and functions by domain (`git.zsh`, `dev.zsh`, `security.zsh`).
- `git/`, `ssh/`, `vscode/`, and `iterm2/`: application settings, snippets, profiles, and color schemes.
- `Brewfile`: packages, applications, and extensions; `node/npm-globals.txt`: global npm packages.
- `scripts/`: maintenance utilities. `dotbot/` and `dotbot-brewfile/` are Git submodules; keep dependency changes separate from configuration edits.
- `agents/`: personal instructions, settings templates, and setup notes. `tests/`: isolated agent-link checks.

## Build, Test, and Development Commands

There is no application build step. Run commands from the repository root:

- `git submodule update --init --recursive`: initialize installer dependencies.
- `./install`: apply links and install configured Homebrew and npm packages.
- `./install --only link`: apply only the symlink task.
- `CI=true ./install`: apply the reduced CI configuration.
- `brew bundle check --file=Brewfile`: check whether declared Homebrew dependencies are installed.
- `brew bundle install --file=Brewfile`: install the declared Homebrew dependencies.

Installer commands modify home-directory files; use a disposable account or environment for installation checks.

## Coding Style & Naming Conventions

Follow `.editorconfig`: UTF-8, LF, tab indentation with width four, and two-space indentation for YAML. Preserve surrounding formatting when editing existing files. No repository-wide formatter or linter is configured.

Place shell helpers in the matching domain file, quote path variables, and preserve the intended Bash or Zsh interpreter. Name new domain files with lowercase descriptive names ending in `.zsh`; add their Dotbot mappings when needed.

## Testing Guidelines

Pull requests run `.github/workflows/test.yml` on macOS with a temporary home directory. Run `python3 tests/test_agent_links.py` (Python 3.11+) to verify agent links and templates. No coverage threshold is configured. Check shell syntax with `bash -n install` or `zsh -n path/to/changed.zsh`. `shell/.zsh/test-runner.sh` targets an external frontend monorepo.

## Commit & Pull Request Guidelines

History favors short, action-oriented subjects such as `add …`, `update …`, and `remove …`, with occasional `fix:` and `chore:` prefixes. Keep commits focused. PR descriptions should explain affected tools, configuration changes, validation, and any manual setup. Link relevant issues; include screenshots for visible theme or profile changes.

## Security & Configuration

Keep credentials and machine-local values in ignored `.env` files or external secret stores. Review staged changes for private keys, tokens, and unintended personal configuration before committing.
