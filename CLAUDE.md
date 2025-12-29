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
