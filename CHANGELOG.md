# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive theme generator system with template-based approach
- Support for 26 CLI tools with complete 6-variant coverage
- Support for 5 terminal emulators (WezTerm, Alacritty, Kitty, Windows Terminal, Ghostty)
- Support for 5 code editors (Neovim, VS Code, JetBrains IDEs, Zed, Sublime Text)
- Web CSS themes with Playwright visual testing
- Universal installer script with variant-specific paths
- Complete CI/CD pipeline with automated testing
- Docker-based verification system
- Generator-first architecture preventing manual edits
- ANSI-based CLI tool theming for terminal compatibility
- Comprehensive documentation and contribution guidelines

### CLI Tools Supported
- Shell: Fish, Zsh, Starship prompt
- File Management: LS_COLORS, eza, fd, ranger, lf, mc
- Git Tools: delta, lazygit, gitui, tig
- Search: fzf, ripgrep, jq
- System Monitoring: htop, btop, bottom, glances, neofetch
- Terminal: tmux, less, atuin, zoxide
- Development: bat

### Fixed
- Installation script now uses variant-specific file names to prevent overwriting user configurations
- Removed inconsistent non-variant files that bypassed the generator architecture
- Added proper theme directory structure for safe installation

### Infrastructure
- Biome linting and formatting
- Husky pre-commit hooks
- Conventional Commits enforcement
- Playwright visual testing
- Container-based verification
- Comprehensive Makefile for development workflows

## [0.1.0] - 2024-09-06

### Added
- Initial project scaffold and architecture
- Canonical Everforest palette definitions in JSON and YAML formats
- Template system with color placeholder support
- Complete theme generation for all 6 variants (dark/light × hard/medium/soft)
- Universal installation script
- Basic documentation and project structure

---

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

All changes should be documented in this changelog following the [Keep a Changelog](https://keepachangelog.com/) format.
