# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the **everforest-resources** repository - an unofficial hub for Everforest color scheme resources. The project follows a **generator-first** approach where all theme files, configurations, and outputs are generated from canonical palette definitions.

**Critical Rule**: LLM AGENTS SHALL NOT DEVIATE FROM THE THEME SPEC. All changes must strictly follow the specification in AGENTS.md.

## Architecture

### Core Philosophy

- **Generator-first**: All outputs derive from `palettes/everforest.(json|yaml)`
- **Template system**: CLI tools use `template.txt` files with color placeholders (e.g., `{{bg}}`, `{{fg}}`, `{{red}}`) that are replaced by the generator
- **No manual edits**: Generated artifacts MUST NOT be hand-edited
- **ANSI-only for CLI**: CLI tools use ANSI-16 SGR codes only, never raw hex
- **Hex for GUI**: GUI/editor themes may use hex values but only from generator output

### Repository Structure

- `palettes/`: Canonical Everforest palette definitions (JSON/YAML)
- `scripts/`: Generator scripts (Node.js .mjs modules)
- `terminals/`: Terminal configs (WezTerm, Alacritty, Kitty, Windows Terminal, Ghostty)
- `web/`: CSS variables and demo with Playwright snapshots
- `cli/`: CLI tool configs (LS_COLORS, dircolors, eza, ripgrep, fzf, delta, bat, htop, starship, zsh, fish, tmux, btop, bottom, glances, neofetch, ranger, lf, mc, lazygit, gitui, tig, fd, jq, less, zoxide, atuin)
- `editors/`: Editor themes (Neovim minimal Lua, VS Code, JetBrains unified, Zed, Sublime Text)
- `docs/`: Documentation (CLI.md)
- `verify/`: Container verifier
- `.github/`: Workflows and CODEOWNERS

### Theme Variants

- Six variants total: dark/light × hard/medium/soft
  - If variant missing, fallback to medium
  - All variants MUST be present for terminals, CLI tools, editors, web

## Development Commands

Core development commands for the project:

    npm run lint        # Check code with Biome linter
    npm run lint:fix    # Auto-fix linting issues with Biome
    npm run format      # Format code with Biome
    npm run generate    # Generate all theme files from palettes
    npm run validate    # Validate generated outputs
    npm run ci          # Run full CI suite (lint + generate + validate + snapshots)
    npm run snapshots   # Generate Playwright snapshots
    make generate       # Alternative to npm run generate
    make validate       # Alternative to npm run validate
    make ci             # Alternative to npm run ci
    make install-lscolors  # Copy LS_COLORS snippet
    make demo           # Run web demo server
    make snapshots      # Run Playwright snapshots

## Installation and Verification

    ./install.sh cli                      # Deploy CLI configs to ~/.config
    ENGINE=docker ./verify/verify.sh      # Verify in container

## Implementation Guidelines

### Editing Rules

1. **Only edit palette and template files**: Changes should only be made to `palettes/everforest.(json|yaml)` and `template.txt` files
2. **Template placeholders**: Use `{{bg}}`, `{{fg}}`, `{{red}}`, `{{orange}}`, `{{yellow}}`, `{{green}}`, `{{aqua}}`, `{{blue}}`, `{{purple}}`, `{{gray1}}`, `{{gray2}}`, `{{gray3}}`
3. **Never hand-edit outputs**: All generated files are regenerated automatically
4. **Run generator after changes**: Always regenerate after palette or template modifications
5. **Commit all sources**: Include palette, template, and generated files in commits

### Code Quality

- **Biome linting**: All JavaScript code must pass Biome linting and formatting
- **Auto-formatting**: Use `npm run format` to ensure consistent code style
- **No raw hex in CLI configs**: Use ANSI color names/codes only
- **Use indented code blocks**: Never use triple backticks in documentation
- **Follow conventional commits**: All commits must follow conventional commit format
- **Pre-commit validation**: Pre-commit hooks prevent raw hex and enforce regeneration

### Generator Architecture

The main generator (`scripts/generate-themes.mjs`) implements:

- Palette loader for JSON/YAML
- Template processor: reads `template.txt` files and replaces placeholders with palette values
- Writers for each target (terminals, CLI tools, editors, web)
- Variant generation (all 6 variants where applicable)
- ANSI mapping for CLI tools
- Hex output for GUI applications

### CLI Tool Specifications

- **LS_COLORS**: Archives→bold yellow, images→purple, docs→blue
- **ripgrep**: ripgreprc with ANSI mappings
- **fzf**: FZF_DEFAULT_OPTS with Everforest accents
- **delta**: git-delta config with ANSI mapping
- **bat**: Minimal config forwarding to terminal theme
- **htop**: htoprc with color_scheme=0
- **starship**: starship.toml with accent mappings
- **fish**: Color schemes + minimal prompt + Tide preset
- **tmux**: everforest.tmux.conf with ANSI mappings
- **btop**: Modern htop alternative with extensive color customization
- **bottom**: Cross-platform system monitor (Rust) with color themes
- **glances**: System monitoring tool with color themes
- **neofetch**: System information display with color support
- **ranger**: Terminal file manager with color scheme support
- **lf**: Lightweight file manager (ranger alternative)
- **mc**: Midnight Commander with theme support
- **lazygit**: Terminal UI for git with theme support
- **gitui**: Terminal UI for git with color customization
- **tig**: Text-mode git interface with color customization
- **fd**: Find alternative with color output
- **jq**: JSON processor with syntax highlighting
- **less**: Pager with color support via LESS_TERMCAP
- **zoxide**: Smart cd command with prompt integration
- **atuin**: Shell history with TUI theming

## CI/CD Pipeline

Required checks (all must pass for merge):

- **lint**: Biome linting and formatting checks
- **build**: Generator + validation
- **snapshots**: Playwright demo renders
- **commitlint**: Conventional Commits enforcement
- **cli-verify**: Install + verify generated configs

## Contributing Workflow

1. Edit only `palettes/everforest.(json|yaml)` and `template.txt` files
2. Use template placeholders: `{{bg}}`, `{{fg}}`, `{{red}}`, `{{orange}}`, `{{yellow}}`, `{{green}}`, `{{aqua}}`, `{{blue}}`, `{{purple}}`, `{{gray1}}`, `{{gray2}}`, `{{gray3}}`
3. Lint and format code: `npm run lint:fix && npm run format`
4. Run `npm run generate` (when implemented)
5. Commit palette + template + generated files
6. Ensure all CI checks pass
7. Follow conventional commit format

## Documentation Rules

- **Indented code blocks only**: Never use triple backticks (```)
- **Examples use 4-space indentation**
- **Generator-derived content**: Don't document what can be discovered from files
- **Focus on architecture**: Document high-level patterns requiring multiple files to understand

## Current Status

The repository is in initial development phase:
- ✅ Palette definitions created
- ✅ Comprehensive specification written
- ⏳ Generator implementation pending
- ⏳ File structure creation pending
- ⏳ CI/CD setup pending

Follow the implementation steps in `meta/implementation-steps.md` for systematic development.
