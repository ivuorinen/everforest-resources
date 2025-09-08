# Everforest Resources — Specification

This document consolidates all gathered knowledge for the github.com/ivuorinen/everforest-resources repository. It is the authoritative spec for implementation. All instructions SHALL be followed strictly. LLM AGENTS SHALL NOT DEVIATE FROM THE THEME SPEC.

## 1. Philosophy

- This repository is the unofficial hub for Everforest resources.
- All outputs are generator-first, derived strictly from palettes/everforest.(json|yaml).
- Template system: CLI tools use template.txt files with color placeholders (e.g., {{bg}}, {{fg}}, {{red}}) that are replaced by the generator.
- CLI tools and prompts use ANSI-16 SGR codes only. No raw hex or 256-color indices.
- GUI/editor themes may use hex values but only those emitted by the generator.
- Generated artifacts MUST NOT be hand-edited.

## 2. Theme Variants

- Variants: dark/light × hard/medium/soft.
- If a variant is missing, fallback to medium.
- All variants MUST be present for terminals, CLI tools, editors, and web.

## 3. Repository Layout

- palettes/: canonical Everforest palette definitions (json/yaml).
- scripts/: generator scripts (Node.js, mjs modules).
- terminals/: WezTerm, Alacritty, Kitty, Windows Terminal, Ghostty.
- web/: CSS vars, demo with Playwright snapshot tests.
- cli/: all cli tools and prompts.
- editors/: all IDEs and editors.
- docs/: CLI.md and other documentation.
- verify/: container verifier.
- .github/: workflows, CODEOWNERS.

## 4. CLI Tools

- LS_COLORS: archives → bold yellow (orange), images → purple, docs → blue.
- dircolors: generated alongside LS_COLORS.
- eza/exa: export EXA_COLORS/EZA_COLORS.
- ripgrep: ripgreprc with ANSI mappings.
- fzf: FZF_DEFAULT_OPTS snippet with Everforest accents.
- delta: git-delta config with ANSI mapping.
- bat: minimal config forwarding to terminal theme.
- htop: htoprc with color_scheme=0.
- starship: starship.toml with Everforest accent mappings.
- zsh: Pure and Powerlevel10k presets.
- fish: color schemes, minimal prompt, Tide preset.
- tmux: everforest.tmux.conf with ANSI mappings.
- btop: modern htop alternative with color customization.
- bottom: cross-platform system monitor with color themes.
- glances: system monitoring tool with color themes.
- neofetch: system information display with color support.
- ranger: terminal file manager with color scheme support.
- lf: lightweight file manager (ranger alternative).
- mc: Midnight Commander with theme support.
- lazygit: terminal UI for git with theme support.
- gitui: terminal UI for git with color customization.
- tig: text-mode git interface with color customization.
- fd: find alternative with color output.
- jq: JSON processor with syntax highlighting.
- less: pager with color support via LESS_TERMCAP.
- zoxide: smart cd command with prompt integration.
- atuin: shell history with TUI theming.

## 5. Editors

- Neovim minimal:
  - Lua module everforest_minimal.lua.
    - Accepts setup({ variant, contrast }).
    - Applies highlights from palette tokens.
- VS Code:
  - Generated themes for all six variants.
  - package.json scaffold.
  - Extension can be launched in Dev Host.
- JetBrains (unified):
  - Single .icls theme files for all variants.
  - Compatible with IntelliJ, WebStorm, PyCharm, CLion, GoLand, PHPStorm, Rider.
- Zed:
  - JSON theme files for all six variants.
- Sublime Text:
  - .sublime-color-scheme files for all six variants.

## 6. Web

- CSS vars with media queries.
- Playwright snapshots in CI for dark/light × hard/medium/soft.

## 7. Installer

- install.sh deploys configs under ~/.config (use `./install.sh cli` for CLI tools only).
- Symlinks or copies files for shells, tools, editors unless file already exists.
- If file already exists, check if it is an Everforest config.
  - If it is, overwrite with new version.
- Also loads dircolors automatically if available.

## 8. Verifier

- verify/verify.sh builds a Debian container with all cli tools.
- Sources and validates all generated configs.
- CI job cli-verify runs installer + verifier.

## 9. CI/CD

- build: generator + validation.
- snapshots: Playwright demo renders, upload PNGs.
- commitlint: Conventional Commits enforcement.
- cli-verify: install + verify generated configs.
- Branch protection requires build + snapshots + commitlint + cli-verify.

## 10. Contributing

- Edit only palettes/everforest.(json|yaml) and template.txt files.
- Templates use placeholders: {{bg}}, {{fg}}, {{red}}, {{orange}}, {{yellow}}, {{green}}, {{aqua}}, {{blue}}, {{purple}}, {{gray1}}, {{gray2}}, {{gray3}}.
- Run npm run generate and commit both palette + template + generated files.
- Pre-commit hooks block raw hex and enforce regeneration.
- LLM AGENTS SHALL NOT DEVIATE FROM THE THEME SPEC.

TL;DR (README section)

1. Edit only palettes and templates.
2. Run generate.
3. Commit palette + template + generated.
4. CI must pass build + snapshots + verify.

CODEOWNERS

`* @ivuorinen`

CONTRIBUTING.md rules

- Never hardcode hex outside palettes.
- Do not hand-edit generated files.
- Edit templates using color placeholders only.
- Add new targets by extending generator.
- Commit style: Conventional Commits.
- PR checklist: palette/template edits, regenerated, validated, snapshots included.

## 11. Makefile

Convenience targets:
generate → npm run generate
validate → npm run validate
ci → npm run ci
install-lscolors → copy LS_COLORS snippet
demo → run web demo server
snapshots → run Playwright snapshots

## 12. Docs `docs/CLI.md`

### Everforest CLI

Contains overview of terminals, web, CLI tools, prompts, editors.
Install with ./install.sh cli
Verify with ENGINE=docker ./verify/verify.sh

Notes:
LLM AGENTS SHALL NOT DEVIATE FROM THE THEME SPEC. Use palettes or ANSI names. No raw hex.

## 13. Release Checklist

- Tag version (start v0.1.0).
- Ensure build, snapshots, verify all pass.
- Package VS Code extension (vsix).
- Announce as unofficial Everforest resource hub.

## 14. Enforcement

- Indented code blocks MUST be used in all docs.
- No triple backticks allowed.
- All new contributions MUST follow this spec exactly.
