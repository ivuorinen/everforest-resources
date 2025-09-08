# Installation Guide

This guide covers how to install and configure Everforest themes across different platforms and tools.

## Quick Installation

### All CLI Tools at Once
```bash
# Install CLI configurations to ~/.config (macOS/Linux)
./install.sh cli

# Or manually copy specific tools:
cp cli/starship/starship-dark-medium.toml ~/.config/starship.toml
cp cli/alacritty/everforest-dark-medium.yml ~/.config/alacritty/themes/
```

### Verify Installation
```bash
# Run verification script in container
ENGINE=docker ./verify.sh
```

## Platform-Specific Installation

### Terminal Emulators

#### Alacritty
```bash
# Copy theme file
cp terminals/alacritty/everforest-dark-medium.yml ~/.config/alacritty/themes/

# Add to alacritty.yml
echo 'import = ["~/.config/alacritty/themes/everforest-dark-medium.yml"]' >> ~/.config/alacritty/alacritty.yml
```

#### Kitty
```bash
# Copy theme file
cp terminals/kitty/everforest-dark-medium.conf ~/.config/kitty/themes/

# Add to kitty.conf
echo 'include ./themes/everforest-dark-medium.conf' >> ~/.config/kitty/kitty.conf
```

#### WezTerm
```lua
-- In ~/.config/wezterm/wezterm.lua
local everforest = require('everforest-dark-medium')
return {
  colors = everforest.colors,
}
```

#### Windows Terminal
Add the theme to your Windows Terminal `settings.json`:
```json
{
  "schemes": [
    // Copy contents from terminals/windows-terminal/everforest-dark-medium.json
  ]
}
```

### Code Editors

#### Neovim
```lua
-- Copy theme file to ~/.config/nvim/lua/
local everforest = require('everforest-dark-medium')

-- Apply colors
for group, colors in pairs(everforest.highlights) do
  vim.api.nvim_set_hl(0, group, colors)
end
```

#### VS Code
1. Copy `editors/vscode/everforest-theme-dark-medium.json` to your VS Code extensions folder
2. Install as custom theme or use existing Everforest extension

#### JetBrains IDEs
1. Go to Settings → Editor → Color Scheme
2. Import `editors/jetbrains/everforest-dark-medium.xml`
3. Apply the theme

#### Zed
Copy theme to Zed themes directory:
```bash
cp editors/zed/everforest-dark-medium.json ~/.config/zed/themes/
```

#### Sublime Text
1. Copy `editors/sublime/everforest-dark-medium.tmTheme` to Sublime Text packages folder
2. Select theme from Preferences → Color Scheme

### CLI Tools

#### Shell Configuration
```bash
# Bash/Zsh
source cli/zsh/everforest-dark-medium.zsh

# Fish
source cli/fish/everforest-dark-medium.fish
```

#### Git Configuration
```bash
# Delta (git diff)
cat cli/delta/gitconfig-dark-medium.delta >> ~/.gitconfig

# Tig
cp cli/tig/config-dark-medium ~/.config/tig/config
```

#### File Managers
```bash
# Ranger
cp cli/ranger/colorscheme-dark-medium.py ~/.config/ranger/colorschemes/everforest.py

# lf
cp cli/lf/colors-dark-medium ~/.config/lf/colors

# Midnight Commander
cp cli/mc/everforest-dark-medium.ini ~/.config/mc/skins/everforest.ini
```

#### System Monitoring
```bash
# htop
cp cli/htop/htoprc-dark-medium ~/.config/htop/htoprc

# btop
cp cli/btop/everforest-dark-medium.theme ~/.config/btop/themes/everforest.theme

# bottom
cp cli/bottom/bottom-dark-medium.toml ~/.config/bottom/bottom.toml

# glances
cp cli/glances/glances-dark-medium.conf ~/.config/glances/glances.conf
```

#### Developer Tools
```bash
# Starship prompt
cp cli/starship/starship-dark-medium.toml ~/.config/starship.toml

# LazyGit
cp cli/lazygit/config-dark-medium.yml ~/.config/lazygit/config.yml

# GitUI
cp cli/gitui/theme-dark-medium.ron ~/.config/gitui/theme.ron
```

### Web Development

#### CSS Framework
```html
<!-- Include Everforest CSS in your project -->
<link rel="stylesheet" href="web/css/everforest-dark-medium.css">

<!-- Apply base theme -->
<body class="everforest">
  <div class="bg-everforest text-everforest">
    <h1 class="text-everforest-green">Hello Everforest!</h1>
    <button class="everforest-button">Click me</button>
  </div>
</body>
```

#### CSS Variables
```css
/* Use Everforest color variables */
.my-component {
  background: var(--everforest-bg);
  color: var(--everforest-fg);
  border: 1px solid var(--everforest-blue);
}
```

## Theme Variants

Choose from 6 variants:

- **dark-hard**: Deepest contrast
- **dark-medium**: Balanced dark theme (recommended)
- **dark-soft**: Softer dark theme
- **light-hard**: Highest contrast light theme
- **light-medium**: Balanced light theme (recommended)
- **light-soft**: Softest light theme

## Environment Variables

Set these in your shell configuration:

```bash
# LS_COLORS for file listings
source cli/ls_colors/everforest-dark-medium.sh

# FZF colors
source cli/fzf/everforest-dark-medium.sh

# Less pager colors
source cli/less/lesskey-dark-medium

# JQ colors
source cli/jq/jq-colors-dark-medium.sh
```

## Troubleshooting

### Colors Not Appearing
- Ensure your terminal supports 24-bit color: `echo $COLORTERM` should show `truecolor`
- Test with: `printf "\x1b[38;2;%d;%d;%dm%s\x1b[0m\n" 231 130 132 "Hello Everforest"`

### Theme Not Loading
- Check file permissions: `chmod 644 ~/.config/*/everforest*`
- Verify file paths match your system configuration
- Restart terminal/application after installation

### Missing Dependencies
- Some tools require restart after theme installation
- Ensure configuration files are in the correct locations for your system
- Check tool documentation for theme loading requirements

## Automation

### Install Script
Use the provided installation script:
```bash
# Install all CLI tools
./install.sh cli

# Install specific category
./install.sh terminals
./install.sh editors
```

### Theme Switching
Create aliases for quick theme switching:
```bash
# In your shell configuration
alias everforest-dark='source ~/.everforest/switch-dark.sh'
alias everforest-light='source ~/.everforest/switch-light.sh'
```

For questions or issues, please refer to the main [README.md](../README.md) or open an issue on GitHub.
