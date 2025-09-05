# Everforest Resources - Project Overview

## Purpose
The **everforest-resources** repository is an unofficial hub for Everforest color scheme resources. It generates theme files, configurations, and color schemes for terminals, CLI tools, and editors from canonical palette definitions.

## Key Philosophy
- **Generator-first approach**: All outputs are generated from `palettes/everforest.json`
- **Template system**: Uses `template.txt` files with color placeholders (e.g., `{{bg}}`, `{{fg}}`, `{{red}}`)
- **No manual editing**: Generated artifacts must never be hand-edited
- **Comprehensive coverage**: Supports 24+ CLI tools, 5+ editors, multiple terminals

## Tech Stack
- **Runtime**: Node.js with ES modules (type: "module")
- **Language**: JavaScript (.mjs files)
- **Code Quality**: Biome 2.2.3 for linting and formatting
- **Testing**: Playwright for web snapshots (when implemented)
- **CI/CD**: Husky for git hooks, conventional commits
- **Package Management**: npm

## Core Architecture
- **Palette**: JSON definitions with 6 variants (dark/light × hard/medium/soft)
- **Generator**: `EverforestGenerator` class processes templates and generates themes
- **Templates**: Color placeholder system for consistent theming
- **Output**: Generates configs for terminals, CLI tools, editors, and web

## Target Platforms
- **Terminals**: WezTerm, Alacritty, Kitty, Windows Terminal, Ghostty
- **CLI Tools**: 24+ tools including btop, lazygit, starship, fzf, ripgrep
- **Editors**: Neovim, VS Code, JetBrains IDEs, Zed, Sublime Text
- **Web**: CSS variables with media queries

## Development Status
- ✅ Project structure and specifications complete
- ✅ Basic generator scaffold implemented
- ✅ Biome 2.x linting and formatting integrated and working
- ✅ Code quality pipeline working (lint → generate → validate)
- ✅ Latest tooling versions (Biome 2.2.3)
- ⏳ Full template processing implementation pending
- ⏳ CLI tool generators pending
- ⏳ Editor theme generators pending
- ⏳ Playwright web tests pending

## Quality Assurance
- **Biome 2.x**: All JavaScript code passes linting and formatting with latest version
- **Validation**: Generator outputs validated for structure and compliance
- **CI Pipeline**: Automated checks for code quality and generation consistency
- **Modern Tooling**: Using latest stable versions of all development tools
