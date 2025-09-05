# Everforest Resources

Unofficial hub for Everforest color scheme resources. Generator-first approach for terminals, CLI tools, editors, and web.

## Quick Start

    # Generate all themes
    npm run generate

    # Install CLI configurations
    ./cli/install.sh

    # Verify installation
    ENGINE=docker ./verify/verify.sh

## Supported Tools

### Terminals
WezTerm, Alacritty, Kitty, Windows Terminal, Ghostty

### CLI Tools
Starship, FZF, Delta, Tmux, Fish, LS_COLORS, and 20+ more

### Editors
Neovim, VS Code, JetBrains IDEs, Zed, Sublime Text

## Theme Variants

6 variants total: dark/light × hard/medium/soft

## Development

    npm run lint          # Lint code
    npm run generate       # Generate themes
    npm run validate       # Validate outputs
    npm run ci             # Full CI pipeline

## Contributing

1. Edit only `palettes/everforest.json` and `template.txt` files
2. Run `npm run generate`
3. Commit palette + template + generated files
4. Follow conventional commits

**Important**: Never edit generated files directly. All outputs are generated from templates.

## CI Requirements

All checks must pass: lint + build + snapshots + commitlint + cli-verify
