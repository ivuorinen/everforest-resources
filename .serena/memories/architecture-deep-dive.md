# Architecture Deep Dive - Everforest Resources

## Core Generator Architecture

### EverforestGenerator Class
Located in `scripts/generate-themes.mjs`, this is the heart of the system:

```javascript
class EverforestGenerator {
  constructor() {
    this.palette = null;  // Loaded from palettes/everforest.json
  }

  // Key methods:
  async loadPalette()           // Loads JSON palette definition
  async processTemplate()       // Processes template.txt with placeholders
  getColorsForVariant()        // Maps palette to color variables
  async generateAll()          // Main entry point - generates all variants
  async generateVariant()      // Processes single variant
}
```

### Template Processing System
1. **Template Files**: Each CLI tool has `template.txt` in its directory
2. **Placeholders**: `{{bg}}`, `{{fg}}`, `{{red}}`, etc. replaced with actual colors
3. **Variant Processing**: Generates 6 versions (dark/light × hard/medium/soft)
4. **Output Generation**: Creates final config files from processed templates

### Palette Structure
```json
{
  "variants": {
    "dark": { "hard": {...}, "medium": {...}, "soft": {...} },
    "light": { "hard": {...}, "medium": {...}, "soft": {...} }
  },
  "accents": { "red": "#e67e80", "orange": "#e69875", ... },
  "grays": { "dark": {...}, "light": {...} }
}
```

## Supported Tools & Platforms

### CLI Tools (24+ supported)
- **System Monitors**: btop, bottom, glances, neofetch, htop
- **File Management**: ranger, lf, mc, LS_COLORS, eza/exa
- **Git Tools**: lazygit, gitui, tig, delta
- **Search & Processing**: ripgrep, fzf, fd, jq, bat
- **Shell & Productivity**: starship, zsh, fish, tmux, less
- **Modern Utils**: zoxide, atuin

### Editors (5 types)
- **Neovim**: Lua module with setup() function
- **VS Code**: JSON themes + package.json
- **JetBrains**: Unified .icls files (IntelliJ, WebStorm, PyCharm, etc.)
- **Zed**: JSON theme files
- **Sublime Text**: .sublime-color-scheme files

### Terminals
- WezTerm, Alacritty, Kitty, Windows Terminal, Ghostty

## Color Philosophy

### ANSI vs Hex Usage
- **CLI Tools**: ANSI-16 SGR codes only (no raw hex)
- **GUI Applications**: Hex values allowed (from generator only)
- **Consistent Mapping**: Same semantic colors across all tools

### Theme Variants
- **Dark**: hard/medium/soft (different background intensities)
- **Light**: hard/medium/soft (different background intensities)
- **Fallback**: Medium variant if specific not available

## File Structure Pattern

```
cli/
  starship/
    template.txt          # Template with {{color}} placeholders
    starship.toml         # Generated output (never edit directly)
    README.md            # Tool-specific documentation

  fish/
    colors-template.txt   # Multiple templates for complex tools
    prompt-template.txt
    tide-template.txt
    everforest-*.fish     # Generated variants
    README.md
```

## Development Patterns

### Generator Extension
To add new CLI tool:
1. Create `cli/newtool/template.txt`
2. Add processing logic to generator
3. Update installer and verifier
4. Add to documentation

### Template Design
- Use semantic color names: `{{bg}}` not `{{color1}}`
- Include tool-specific syntax
- Test with all 6 variants
- Follow tool's native config format

### Error Handling
- Graceful failures with descriptive messages
- Exit codes for CI integration
- Emoji-prefixed console output for visibility

## CI/CD Integration

### Required Checks
1. **build**: Generator runs successfully
2. **snapshots**: Web demo renders correctly
3. **commitlint**: Conventional commit format
4. **cli-verify**: Generated configs work in container

### Validation Pipeline
1. Palette structure validation
2. Template processing verification
3. No raw hex in CLI configs
4. All variants present
5. File structure compliance
