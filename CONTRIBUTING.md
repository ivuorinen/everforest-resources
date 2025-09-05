# Contributing to Everforest Resources

Thank you for your interest in contributing to Everforest Resources! This project follows a **generator-first** approach where all theme files are generated from canonical palette definitions.

## Quick Start

    git clone https://github.com/ivuorinen/everforest-resources.git
    cd everforest-resources
    npm install
    npm run generate

## Development Workflow

### 1. Edit Only Source Files

**Critical Rule**: Only edit these files:
- `palettes/everforest.json` or `palettes/everforest.yaml` - Canonical color definitions
- `template.txt` files - Theme templates with color placeholders

**Never edit generated files directly** - they will be overwritten by the generator.

### 2. Template System

Templates use these placeholders:
- `{{bg}}`, `{{bg1}}`, `{{bg2}}` - Background colors
- `{{fg}}` - Foreground color
- `{{red}}`, `{{orange}}`, `{{yellow}}`, `{{green}}`, `{{aqua}}`, `{{blue}}`, `{{purple}}` - Accent colors
- `{{gray1}}`, `{{gray2}}`, `{{gray3}}` - Gray variations

### 3. Generate and Test

    npm run lint:fix     # Auto-fix linting issues
    npm run generate     # Generate all theme files
    npm run validate     # Validate outputs
    npm run ci           # Full CI pipeline

### 4. Installation Testing

    ./install.sh --dry-run    # Preview installation
    ./install.sh              # Install themes

## Adding New Tools

### CLI Tools

1. Create new directory: `cli/newtool/`
2. Add `template.txt` with color placeholders
3. Update `scripts/generate-themes.mjs` to include the new tool
4. Update `install.sh` to install the new tool's themes
5. Test all 6 variants are generated correctly

### Terminal Emulators

1. Create new directory: `terminals/newterminal/`
2. Add `template.ext` (appropriate file extension)
3. Update generator and installer
4. Test with actual terminal application

### Editors

1. Create new directory: `editors/neweditor/`
2. Add appropriate template file
3. Follow same pattern as existing editors

## Code Quality

### Linting and Formatting

    npm run lint         # Check code quality
    npm run lint:fix     # Auto-fix issues
    npm run format       # Format all files

All code must pass Biome linting and formatting checks.

### Pre-commit Hooks

The project uses Husky for:
- **Commit message validation**: Must follow [Conventional Commits](https://conventionalcommits.org/)
- **Pre-commit checks**: Linting and basic validation

Example commit messages:
    feat: add support for new terminal emulator
    fix: correct color mapping in dark variant
    docs: update installation instructions

## CI/CD Pipeline

All PRs must pass:
- **Lint**: Biome code quality checks
- **Build**: Generator + validation
- **Snapshots**: Playwright visual testing
- **Commitlint**: Conventional commit format
- **CLI Verify**: Installation testing

## Architecture Principles

1. **Generator-first**: All outputs derive from `palettes/everforest.(json|yaml)`
2. **Template system**: Use placeholders, not hardcoded values
3. **Variant completeness**: All tools must support 6 variants (dark/light × hard/medium/soft)
4. **ANSI-only for CLI**: CLI tools use ANSI codes, not hex values
5. **No manual edits**: Generated files must never be hand-edited

## Project Structure

    palettes/           # Canonical color definitions
    scripts/            # Generator and validation scripts
    terminals/          # Terminal emulator themes
    cli/                # CLI tool configurations
    editors/            # Code editor themes
    web/                # CSS themes and web demo
    docs/               # Documentation
    install.sh          # Universal installer
    verify/             # Container-based verification

## Common Issues

### Template Errors
- Ensure all placeholders use double braces: `{{color}}`
- Check template syntax matches target tool's format
- Verify all 6 variants generate without errors

### Color Mapping
- CLI tools should use ANSI codes from palette
- GUI applications can use hex values
- Follow existing patterns for color assignments

### Installation Issues
- Always install to variant-specific paths
- Never overwrite user configuration files
- Provide manual activation instructions

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/ivuorinen/everforest-resources/issues)
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Check `docs/` directory and `CLAUDE.md`

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
