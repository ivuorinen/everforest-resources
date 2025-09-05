# Everforest CLI

Command-line tools and terminal configurations for the Everforest color scheme.

## Installation

    ./cli/install.sh

This installs configurations for all supported CLI tools to `~/.config`.

## Supported Tools

### Shell & Terminal
- **Starship**: Cross-shell prompt with Everforest colors
- **Fish**: Shell colors and prompt themes
- **Tmux**: Terminal multiplexer theme
- **LS_COLORS**: Directory colors for `ls` and file managers

### Development Tools
- **FZF**: Fuzzy finder with Everforest colors
- **Delta**: Git diff viewer theme
- **Ripgrep**: Search tool colors
- **Bat**: Syntax highlighter theme

### System Tools
- **Htop**: System monitor colors
- **Btop**: Modern system monitor theme

## Usage Examples

After installation:

    # Set Starship theme
    export STARSHIP_CONFIG=~/.config/starship/starship.toml

    # Load FZF colors
    source ~/.config/fzf/everforest.sh

    # Load LS_COLORS
    source ~/.config/dircolors/everforest.sh

## Verification

    ENGINE=docker ./verify/verify.sh

Tests all configurations in a clean container environment.

## Theme Variants

Each tool supports 6 variants:
- `dark-hard`, `dark-medium`, `dark-soft`
- `light-hard`, `light-medium`, `light-soft`

Default is `medium` contrast.
