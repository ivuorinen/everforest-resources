#!/usr/bin/env bash

# Everforest Resources Installer
# Installs all CLI tool configurations to ~/.config

set -euo pipefail

CONFIG_DIR="${HOME}/.config"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🎨 Installing Everforest CLI configurations..."

# Create config directories
mkdir -p "${CONFIG_DIR}/starship"
mkdir -p "${CONFIG_DIR}/fzf"
mkdir -p "${CONFIG_DIR}/git"
mkdir -p "${CONFIG_DIR}/fish"
mkdir -p "${CONFIG_DIR}/tmux"

# Install configurations
install_config() {
    local tool="$1"
    local file="$2"
    local target="$3"

    if [[ -f "${SCRIPT_DIR}/${tool}/${file}" ]]; then
        echo "📝 Installing ${tool}/${file} -> ${target}"
        cp "${SCRIPT_DIR}/${tool}/${file}" "${target}"
    else
        echo "⚠️  Warning: ${tool}/${file} not found (may not be generated yet)"
    fi
}

# Install tool configurations
install_config "starship" "starship.toml" "${CONFIG_DIR}/starship/starship.toml"
install_config "fzf" "everforest.sh" "${CONFIG_DIR}/fzf/everforest.sh"
install_config "delta" "gitconfig.delta" "${CONFIG_DIR}/git/everforest-delta"
install_config "tmux" "everforest.tmux.conf" "${CONFIG_DIR}/tmux/everforest.conf"

# Install fish colors (all variants)
for variant in dark-hard dark-medium dark-soft light-hard light-medium light-soft; do
    install_config "fish" "everforest-${variant}.fish" "${CONFIG_DIR}/fish/conf.d/everforest-${variant}.fish"
done

# Install LS_COLORS
if [[ -f "${SCRIPT_DIR}/ls_colors/everforest.sh" ]]; then
    echo "📝 Installing LS_COLORS"
    mkdir -p "${CONFIG_DIR}/dircolors"
    cp "${SCRIPT_DIR}/ls_colors/everforest.sh" "${CONFIG_DIR}/dircolors/everforest.sh"
    cp "${SCRIPT_DIR}/ls_colors/dircolors" "${CONFIG_DIR}/dircolors/everforest"
fi

echo "✅ Installation complete!"
echo ""
echo "To use the themes:"
echo "  - Starship: export STARSHIP_CONFIG=~/.config/starship/starship.toml"
echo "  - FZF: source ~/.config/fzf/everforest.sh"
echo "  - LS_COLORS: source ~/.config/dircolors/everforest.sh"
echo "  - Fish: restart fish or run 'exec fish'"
