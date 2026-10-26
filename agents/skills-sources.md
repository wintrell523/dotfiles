# Shared skill sources

Observed from the local skill installer lock on 2026-10-26. This is an inventory, not an automatic installer or an instruction to import these skills into Notion.

Keep downloaded skills in `~/.agents/skills`; retain installer-created links into each agent. Keep personal authored skills in their owning repository. Reinstall selected third-party skills from their source instead of committing caches or the machine-local lock file.

| Skill | Source | Skill path |
| --- | --- | --- |
| agent-browser | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser.git) | `skills/agent-browser/SKILL.md` |
| deslop | [cursor/plugins](https://github.com/cursor/plugins.git) | `cursor-team-kit/skills/deslop/SKILL.md` |
| find-skills | [vercel-labs/skills](https://github.com/vercel-labs/skills.git) | `skills/find-skills/SKILL.md` |
| frontend-design | [anthropics/skills](https://github.com/anthropics/skills.git) | `skills/frontend-design/SKILL.md` |
| grill-me | [mattpocock/skills](https://github.com/mattpocock/skills.git) | `skills/productivity/grill-me/SKILL.md` |
| grill-with-docs | [mattpocock/skills](https://github.com/mattpocock/skills.git) | `skills/engineering/grill-with-docs/SKILL.md` |
| playwriter | [playwriter.dev](https://playwriter.dev/.well-known/agent-skills/playwriter/SKILL.md) | `SKILL.md` |

Work-project skills and agent definitions remain in their original project. Their absolute local links are not portable personal configuration.

Codex discovers user skills in `~/.agents/skills` and supports symlinked skill folders: [official documentation](https://learn.chatgpt.com/docs/build-skills).
