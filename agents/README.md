# Agent configuration

Dotbot links only the personal instruction files below. The repository root's
`AGENTS.md` and `CLAUDE.md` remain specific to maintaining this repository.

| Repository file | Destination |
| --- | --- |
| `codex/AGENTS.md` | `~/.codex/AGENTS.md` |
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |

## Install instructions

Review the tracked instructions before enabling them. The Codex instructions
reference the approved personal Notion guide; the Claude instructions retain
their existing communication preferences and RTK import.

Dotbot creates missing parent directories. It refuses to replace existing regular
files. After comparing any existing instructions with these versions, move the
originals to backups before linking:

```sh
backup_stamp=$(date +%Y%m%d-%H%M%S)
for instruction in "$HOME/.codex/AGENTS.md" "$HOME/.claude/CLAUDE.md"; do
  if [ -f "$instruction" ] && [ ! -L "$instruction" ]; then
    mv -n "$instruction" "$instruction.backup-$backup_stamp"
  fi
done
./install --only link
```

The normal and CI Dotbot configurations contain the same agent mappings. Further
edits to linked instructions change the tracked files. To roll back, remove only
the new instruction symlink and restore its backup.

## Merge settings explicitly

`codex/config.example.toml` and `claude/settings.example.json` contain selected
preferences observed on 2026-10-26. They are templates, not linked live settings.
Model and plugin availability can differ between accounts and installations.

Back up each existing settings file before opening it:

```sh
backup_stamp=$(date +%Y%m%d-%H%M%S)
for settings in "$HOME/.codex/config.toml" "$HOME/.claude/settings.json"; do
  if [ -f "$settings" ]; then
    cp -p -n "$settings" "$settings.backup-$backup_stamp"
  fi
done
```

Merge the desired template keys into the corresponding file with your editor;
create the file from the template only on a fresh installation. Preserve existing
permission restrictions, MCP configuration, and application-managed settings.
Restart the agent and confirm its selected model and enabled integrations.

The templates omit project permission grants, work-specific integrations, desktop
runtime paths, plugin caches, authentication, and generated hook trust hashes.
Claude's status line runs `npx -y ccstatusline@latest` and requires Node/npm; its
configuration remains in the repository root's `ccstatusline-config.json`.
Review and install the listed plugins through Claude's plugin manager.

Settings references: [Codex](https://learn.chatgpt.com/docs/config-file/config-basic),
[Claude Code](https://code.claude.com/docs/en/settings).

## Reinstall integrations

The Brewfile already declares RTK, Herdr, and Peon Ping. Use their installed setup
commands to regenerate hooks for the current machine instead of copying scripts
with absolute home-directory or Homebrew paths.

After linking instructions and installing RTK, generate its imported instructions
and hooks locally:

```sh
rtk init --global
rtk init --global --codex
```

These commands may also update linked instruction files; review the resulting
Git diff. Claude's `@RTK.md` import requires this setup. Complete Herdr and Peon
Ping setup using their current installer instructions before adding their hooks.
See [skill sources](skills-sources.md) for the shared skill inventory.

Keep credentials, histories, sessions, databases, managed skills, and caches
outside the repository.

## Verify

Use Python 3.11 or newer with the initialized Dotbot submodule:

```sh
python3 tests/test_agent_links.py
```

This runs the actual Dotbot link plugin in temporary directories, checks repeat
installation and existing-file protection, and validates both settings templates.
It does not run package installers or touch live agent files.
