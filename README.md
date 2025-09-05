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

## Acknowledgements

This project is based on the beautiful **Everforest** color scheme created by [sainnhe](https://github.com/sainnhe). 

- **Original Everforest theme**: https://github.com/sainnhe/everforest
- **Original author**: [@sainnhe](https://github.com/sainnhe)

Thank you to sainnhe for creating such an elegant and well-balanced color scheme that works beautifully across so many different tools and environments. This resource hub exists to make it easier for developers to apply the Everforest theme consistently across their entire development workflow.

The color palette definitions in this project are derived from the original Everforest theme specifications.
