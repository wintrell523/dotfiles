"""Exercise only the agent links; never run installers or modify the real home."""

import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import tomllib
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "dotbot/lib/pyyaml/lib3"))
import yaml


class AgentLinksTest(unittest.TestCase):

	def test_links_and_existing_file_protection(self):
		mappings = []
		for filename in ("install.conf.yaml", "install-ci.conf.yaml"):
			with self.subTest(config=filename):
				config = yaml.safe_load((ROOT / filename).read_text())
				links = {
					destination: options
					for task in config
					for destination, options in task.get("link", {}).items()
					if isinstance(options, dict) and options.get("path", "").startswith("agents/")
				}
				# Both links may be disabled while the live instructions are hand-managed.
				self.assertIn(set(links), ({"~/.codex/AGENTS.md", "~/.claude/CLAUDE.md"}, set()))
				mappings.append(links)
				if not links:
					continue
				defaults = [task for task in config if "defaults" in task]
				with tempfile.TemporaryDirectory(prefix="agent-links-") as directory:
					home = Path(directory)
					isolated_config = home / "links.json"
					isolated_config.write_text(json.dumps(defaults + [{"link": links}]))
					command = [sys.executable, str(ROOT / "dotbot/bin/dotbot"),
						"-d", str(ROOT), "-c", str(isolated_config)]
					environment = dict(os.environ, HOME=str(home), PYTHONDONTWRITEBYTECODE="1")
					for _ in range(2):
						result = subprocess.run(command, env=environment, capture_output=True, text=True)
						self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
						for destination, options in links.items():
							link = home / destination.removeprefix("~/")
							self.assertTrue(link.is_symlink())
							self.assertEqual(link.resolve(), ROOT / options["path"])
					for destination in links:
						link = home / destination.removeprefix("~/")
						link.unlink()
						link.write_text("existing personal instructions\n")
					result = subprocess.run(command, env=environment, capture_output=True, text=True)
					self.assertNotEqual(result.returncode, 0)
					for destination in links:
						original = home / destination.removeprefix("~/")
						self.assertFalse(original.is_symlink())
						self.assertEqual(original.read_text(), "existing personal instructions\n")
		self.assertEqual(*mappings)

	def test_settings_templates(self):
		codex_path = ROOT / "agents/codex/config.example.toml"
		claude_path = ROOT / "agents/claude/settings.example.json"
		self.assertIn("model", tomllib.loads(codex_path.read_text()))
		self.assertIn("model", json.loads(claude_path.read_text()))
		for path in (codex_path, claude_path):
			self.assertNotIn("/Users/", path.read_text())


if __name__ == "__main__":
	unittest.main()
