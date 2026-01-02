# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Overview

Personal dotfiles for Fedora Linux, managed by chezmoi. Development tools are
managed via mise ([dot_config/mise/config.toml](dot_config/mise/config.toml)).

## Key Commands

```bash
# Edit and manage dotfiles
chezmoi edit .bashrc
chezmoi add .config/mise/config.toml  # Re-add manually edited files
chezmoi diff                          # View changes
chezmoi apply                         # Apply to home directory

# Add development tools via mise
mise use -g <tool-name>
# After adding tools, always run: chezmoi add .config/mise/config.toml

# Test configuration
bash ./test-chezmoi.sh
```

## Architecture

- `.chezmoiscripts/`: Setup scripts (numbered prefixes control execution order)
  - `run_once_before_*`: Run before applying dotfiles
  - `run_once_after_*`: Run after applying dotfiles
- `dot_*`: Synced to home directory (dot_ prefix becomes .)
- `dot_claude/`: Custom Claude Code skills (pr-workflow, markdown-fix)

## mise Version Policy

Version pinning strategy for tools in `dot_config/mise/config.toml`:

| Category          | Policy          | Examples                            |
| ----------------- | --------------- | ----------------------------------- |
| Language runtimes | Pin major.minor | `python`, `node`, `go`, `rust`      |
| CLI tools         | Use latest      | `chezmoi`, `uv`, `markdownlint-cli2`|
| Claude Code       | Use latest      | Always want newest features         |

Notes:

- `uv`: Package manager tool. Safe to use latest as project dependencies are
  managed by `pyproject.toml` / `uv.lock`, not by uv version itself.

Review versions periodically when major releases occur.
