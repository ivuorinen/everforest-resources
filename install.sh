#!/usr/bin/env bash

# Everforest Resources - Universal Installer
# Installs themes across terminals, editors, CLI tools, and web components

set -euo pipefail

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_DIR="${HOME}/.config"
readonly BACKUP_DIR="${HOME}/.everforest-backup-$(date +%Y%m%d-%H%M%S)"
readonly DEFAULT_VARIANT="${EVERFOREST_VARIANT:-dark-medium}"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }
log_header() { echo -e "${PURPLE}🎨 $1${NC}"; }

# Usage information
usage() {
  cat <<EOF
Everforest Resources Installer

Usage: $0 [OPTIONS] [CATEGORY]

OPTIONS:
    -h, --help          Show this help message
    -v, --variant       Set theme variant (default: dark-medium)
    -b, --backup        Create backup of existing configs
    -n, --dry-run       Show what would be installed without doing it
    -f, --force         Overwrite existing configurations
    --list-variants     List available theme variants

CATEGORIES:
    all                 Install all themes (default)
    terminals           Install terminal emulator themes
    editors             Install code editor themes
    cli                 Install CLI tool configurations
    web                 Install web development resources

VARIANTS:
    dark-hard, dark-medium, dark-soft
    light-hard, light-medium, light-soft

EXAMPLES:
    $0                          # Install all with dark-medium variant
    $0 --variant light-medium   # Install all with light-medium variant
    $0 terminals                # Install only terminal themes
    $0 --dry-run cli            # Preview CLI installation

EOF
}

# Parse command line arguments
VARIANT="$DEFAULT_VARIANT"
CATEGORY="all"
DRY_RUN=false
FORCE=false
CREATE_BACKUP=false

while [[ $# -gt 0 ]]; do
  case $1 in
  -h | --help)
    usage
    exit 0
    ;;
  -v | --variant)
    VARIANT="$2"
    shift 2
    ;;
  -b | --backup)
    CREATE_BACKUP=true
    shift
    ;;
  -n | --dry-run)
    DRY_RUN=true
    shift
    ;;
  -f | --force)
    FORCE=true
    shift
    ;;
  --list-variants)
    echo "Available variants:"
    echo "  dark-hard, dark-medium, dark-soft"
    echo "  light-hard, light-medium, light-soft"
    exit 0
    ;;
  all | terminals | editors | cli | web)
    CATEGORY="$1"
    shift
    ;;
  *)
    log_error "Unknown option: $1"
    usage
    exit 1
    ;;
  esac
done

# Tool detection functions
check_tool() {
  command -v "$1" >/dev/null 2>&1
}

check_directory() {
  [[ -d "$1" ]]
}

check_config_dir() {
  local dir="$1"
  [[ -d "$CONFIG_DIR/$dir" ]] || [[ -d "$HOME/.$dir" ]] || [[ -d "$HOME/Library/Application Support/$dir" ]]
}

# Check if tool is available (installed or has config directory)
check_tool_available() {
  local tool="$1"
  local config_dir="$2"

  if check_tool "$tool"; then
    return 0
  elif check_config_dir "$config_dir"; then
    return 0
  else
    return 1
  fi
}

# Install with tool availability check
install_tool_config() {
  local tool_name="$1"
  local config_name="$2"
  local src="$3"
  local dest="$4"
  local display_name="$5"

  if check_tool_available "$tool_name" "$config_name"; then
    install_file "$src" "$dest" "$display_name"
  else
    log_info "Skipping $display_name (tool not installed and no config directory found)"
  fi
}

# Validate variant
validate_variant() {
  local valid_variants=("dark-hard" "dark-medium" "dark-soft" "light-hard" "light-medium" "light-soft")
  for valid in "${valid_variants[@]}"; do
    [[ "$VARIANT" == "$valid" ]] && return 0
  done
  log_error "Invalid variant: $VARIANT"
  echo "Valid variants: ${valid_variants[*]}"
  exit 1
}

# Create backup
create_backup() {
  [[ "$CREATE_BACKUP" == "false" ]] && return

  log_info "Creating backup at $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"

  # Backup common config directories
  for dir in alacritty kitty wezterm starship tmux htop fish nvim vscode; do
    if [[ -d "$CONFIG_DIR/$dir" ]]; then
      cp -r "$CONFIG_DIR/$dir" "$BACKUP_DIR/" 2>/dev/null || true
    fi
  done

  log_success "Backup created at $BACKUP_DIR"
}

# Install file with safety checks
install_file() {
  local src="$1"
  local dest="$2"
  local name="$3"

  if [[ ! -f "$src" ]]; then
    log_warning "$name source file not found: $src"
    return 1
  fi

  if [[ -f "$dest" && "$FORCE" == "false" ]]; then
    log_warning "$name already exists: $dest (use --force to overwrite)"
    return 1
  fi

  if [[ "$DRY_RUN" == "true" ]]; then
    log_info "[DRY RUN] Would install $name: $src -> $dest"
    return 0
  fi

  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  log_success "Installed $name"
}

# Install terminal themes
install_terminals() {
  log_header "Installing Terminal Themes ($VARIANT)"

  # Alacritty
  install_tool_config "alacritty" "alacritty" \
    "$SCRIPT_DIR/terminals/alacritty/everforest-$VARIANT.yml" \
    "$CONFIG_DIR/alacritty/themes/everforest-$VARIANT.yml" \
    "Alacritty theme"

  # Kitty
  install_tool_config "kitty" "kitty" \
    "$SCRIPT_DIR/terminals/kitty/everforest-$VARIANT.conf" \
    "$CONFIG_DIR/kitty/themes/everforest-$VARIANT.conf" \
    "Kitty theme"

  # WezTerm
  install_tool_config "wezterm" "wezterm" \
    "$SCRIPT_DIR/terminals/wezterm/everforest-$VARIANT.lua" \
    "$CONFIG_DIR/wezterm/colors/everforest-$VARIANT.lua" \
    "WezTerm theme"

  # Windows Terminal (if on Windows or WSL)
  if [[ -n "${WSL_DISTRO_NAME:-}" ]] || command -v wsl.exe >/dev/null 2>&1; then
    local wt_dest="$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
    if [[ -d "$wt_dest" ]]; then
      install_file \
        "$SCRIPT_DIR/terminals/windows-terminal/everforest-$VARIANT.json" \
        "$wt_dest/everforest-$VARIANT.json" \
        "Windows Terminal theme"
    else
      log_info "Skipping Windows Terminal (config directory not found)"
    fi
  fi

  # Ghostty
  install_tool_config "ghostty" "ghostty" \
    "$SCRIPT_DIR/terminals/ghostty/everforest-$VARIANT.conf" \
    "$CONFIG_DIR/ghostty/themes/everforest-$VARIANT.conf" \
    "Ghostty theme"
}

# Install editor themes
install_editors() {
  log_header "Installing Editor Themes ($VARIANT)"

  # Neovim
  install_file \
    "$SCRIPT_DIR/editors/vim-nvim/everforest-$VARIANT.lua" \
    "$CONFIG_DIR/nvim/colors/everforest-$VARIANT.lua" \
    "Neovim theme"

  # VS Code
  local vscode_dir="$HOME/.vscode/extensions"
  [[ -d "$HOME/.vscode-insiders/extensions" ]] && vscode_dir="$HOME/.vscode-insiders/extensions"

  if [[ -d "$vscode_dir" ]]; then
    mkdir -p "$vscode_dir/everforest-themes/themes"
    install_file \
      "$SCRIPT_DIR/editors/vscode/everforest-theme-$VARIANT.json" \
      "$vscode_dir/everforest-themes/themes/everforest-$VARIANT.json" \
      "VS Code theme"
  fi

  # JetBrains
  local jetbrains_config=""
  for ide in IntelliJIdea PyCharm WebStorm PhpStorm GoLand RustRover; do
    local config_path="$HOME/Library/Application Support/JetBrains/$ide*/colors"
    if [[ -d $config_path ]]; then
      install_file \
        "$SCRIPT_DIR/editors/jetbrains/everforest-$VARIANT.xml" \
        "$config_path/everforest-$VARIANT.icls" \
        "JetBrains theme"
      break
    fi
  done

  # Zed
  install_file \
    "$SCRIPT_DIR/editors/zed/everforest-$VARIANT.json" \
    "$CONFIG_DIR/zed/themes/everforest-$VARIANT.json" \
    "Zed theme"

  # Sublime Text
  local sublime_packages="$HOME/Library/Application Support/Sublime Text/Packages/User"
  [[ ! -d "$sublime_packages" ]] && sublime_packages="$HOME/.config/sublime-text/Packages/User"

  if [[ -d "$sublime_packages" ]]; then
    install_file \
      "$SCRIPT_DIR/editors/sublime/everforest-$VARIANT.tmTheme" \
      "$sublime_packages/everforest-$VARIANT.tmTheme" \
      "Sublime Text theme"
  fi
}

# Install CLI tools
install_cli() {
  log_header "Installing CLI Tools ($VARIANT)"

  # Core shell tools
  install_tool_config "starship" "starship" \
    "$SCRIPT_DIR/cli/starship/starship-$VARIANT.toml" \
    "$CONFIG_DIR/starship/themes/everforest-$VARIANT.toml" \
    "Starship theme"

  install_tool_config "fish" "fish" \
    "$SCRIPT_DIR/cli/fish/everforest-$VARIANT.fish" \
    "$CONFIG_DIR/fish/conf.d/everforest-$VARIANT.fish" \
    "Fish colors"

  # File and directory tools
  install_file \
    "$SCRIPT_DIR/cli/ls_colors/everforest-$VARIANT.sh" \
    "$CONFIG_DIR/dircolors/everforest.sh" \
    "LS_COLORS"

  install_tool_config "eza" "eza" \
    "$SCRIPT_DIR/cli/eza/everforest-$VARIANT.sh" \
    "$CONFIG_DIR/eza/theme.sh" \
    "eza colors"

  # Git tools
  install_file \
    "$SCRIPT_DIR/cli/delta/gitconfig-$VARIANT.delta" \
    "$CONFIG_DIR/git/everforest-delta" \
    "Git delta"

  install_tool_config "lazygit" "lazygit" \
    "$SCRIPT_DIR/cli/lazygit/config-$VARIANT.yml" \
    "$CONFIG_DIR/lazygit/themes/everforest-$VARIANT.yml" \
    "LazyGit theme"

  install_tool_config "gitui" "gitui" \
    "$SCRIPT_DIR/cli/gitui/theme-$VARIANT.ron" \
    "$CONFIG_DIR/gitui/themes/everforest-$VARIANT.ron" \
    "GitUI theme"

  # System monitoring
  install_tool_config "htop" "htop" \
    "$SCRIPT_DIR/cli/htop/htoprc-$VARIANT" \
    "$CONFIG_DIR/htop/themes/everforest-$VARIANT" \
    "htop theme"

  install_tool_config "btop" "btop" \
    "$SCRIPT_DIR/cli/btop/everforest-$VARIANT.theme" \
    "$CONFIG_DIR/btop/themes/everforest.theme" \
    "btop theme"

  install_tool_config "bottom" "bottom" \
    "$SCRIPT_DIR/cli/bottom/bottom-$VARIANT.toml" \
    "$CONFIG_DIR/bottom/themes/everforest-$VARIANT.toml" \
    "bottom theme"

  # Other tools
  install_tool_config "fzf" "fzf" \
    "$SCRIPT_DIR/cli/fzf/everforest-$VARIANT.sh" \
    "$CONFIG_DIR/fzf/everforest.sh" \
    "FZF colors"

  install_tool_config "tmux" "tmux" \
    "$SCRIPT_DIR/cli/tmux/everforest.tmux-$VARIANT.conf" \
    "$CONFIG_DIR/tmux/themes/everforest.conf" \
    "tmux theme"
}

# Install web resources
install_web() {
  log_header "Installing Web Resources ($VARIANT)"

  local web_dir="$HOME/.everforest-web"
  mkdir -p "$web_dir"

  install_file \
    "$SCRIPT_DIR/web/css/everforest-$VARIANT.css" \
    "$web_dir/everforest-$VARIANT.css" \
    "CSS theme"

  # Copy demo files
  if [[ -f "$SCRIPT_DIR/docs/examples/web-demo.html" ]]; then
    install_file \
      "$SCRIPT_DIR/docs/examples/web-demo.html" \
      "$web_dir/demo.html" \
      "Web demo"
  fi

  log_info "Web resources installed to $web_dir"
}

# Print post-installation instructions
print_instructions() {
  log_header "Installation Complete!"

  cat <<EOF

Next steps to activate themes:

${CYAN}Terminals:${NC}
  • Alacritty: Add 'import = ["~/.config/alacritty/themes/everforest-$VARIANT.yml"]' to alacritty.yml
  • Kitty: Add 'include ~/.config/kitty/themes/everforest-$VARIANT.conf' to kitty.conf
  • WezTerm: Add 'colors = require("colors.everforest-$VARIANT").colors' to wezterm.lua

${CYAN}Shell:${NC}
  • Add to your shell config: source ~/.config/fzf/everforest.sh
  • Add to your shell config: source ~/.config/dircolors/everforest.sh
  • Fish users: Theme auto-loaded from conf.d/everforest-$VARIANT.fish
  • Starship: Copy ~/.config/starship/themes/everforest-$VARIANT.toml to ~/.config/starship.toml

${CYAN}Editors:${NC}
  • Neovim: Use ':colorscheme everforest-$VARIANT'
  • VS Code: Reload and select theme from Command Palette
  • JetBrains: Go to Settings → Editor → Color Scheme

${CYAN}CLI Tools:${NC}
  • LazyGit: Copy ~/.config/lazygit/themes/everforest-$VARIANT.yml to ~/.config/lazygit/config.yml
  • GitUI: Copy ~/.config/gitui/themes/everforest-$VARIANT.ron to ~/.config/gitui/theme.ron
  • htop: Copy ~/.config/htop/themes/everforest-$VARIANT to ~/.config/htop/htoprc
  • bottom: Use --config ~/.config/bottom/themes/everforest-$VARIANT.toml

${CYAN}Environment Variables:${NC}
  export STARSHIP_CONFIG=~/.config/starship.toml
  export EVERFOREST_VARIANT=$VARIANT

EOF

  if [[ "$CREATE_BACKUP" == "true" ]]; then
    log_info "Backup saved to: $BACKUP_DIR"
  fi
}

# Main installation logic
main() {
  log_header "Everforest Resources Installer"
  log_info "Variant: $VARIANT"
  log_info "Category: $CATEGORY"
  [[ "$DRY_RUN" == "true" ]] && log_info "Mode: DRY RUN"

  validate_variant
  create_backup

  case "$CATEGORY" in
  all)
    install_terminals
    install_editors
    install_cli
    install_web
    ;;
  terminals)
    install_terminals
    ;;
  editors)
    install_editors
    ;;
  cli)
    install_cli
    ;;
  web)
    install_web
    ;;
  esac

  [[ "$DRY_RUN" == "false" ]] && print_instructions
}

# Run main function
main "$@"
