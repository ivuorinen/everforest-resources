# Suggested Commands - Everforest Resources

## Core Development Commands

### Theme Generation
```bash
npm run generate          # Generate all theme files from palettes
node scripts/generate-themes.mjs  # Direct generator execution
```

### Code Quality & Linting
```bash
npm run lint             # Check code with Biome linter
npm run lint:fix         # Auto-fix linting issues with Biome
npm run format           # Format code with Biome
npm run validate         # Validate generated outputs and structure
npm run ci               # Full CI suite: lint + generate + validate + snapshots
```

### Testing
```bash
npm run snapshots        # Generate Playwright web snapshots
playwright test          # Direct Playwright execution
```

### Git & Setup
```bash
npm run prepare          # Install Husky git hooks
npm install              # Install dependencies
```

### Alternative Commands (Makefile - when implemented)
```bash
make generate            # Alternative to npm run generate
make validate            # Alternative to npm run validate
make ci                  # Alternative to npm run ci
make snapshots           # Generate web snapshots
make demo                # Run web demo server
```

## Installation & Deployment
```bash
./install.sh cli         # Deploy CLI configs to ~/.config
ENGINE=docker ./verify/verify.sh  # Verify in container (when implemented)
```

## Development Workflow Commands
```bash
# 1. Edit palette or templates
vim palettes/everforest.json
vim cli/starship/template.txt

# 2. Lint and format code
npm run lint:fix         # Fix any linting issues
npm run format           # Ensure consistent formatting

# 3. Generate themes
npm run generate

# 4. Validate output
npm run validate

# 5. Test web components
npm run snapshots

# 6. Full CI check
npm run ci

# 7. Commit changes
git add -A
git commit -m "feat: update starship theme colors"
```

## Biome Commands
```bash
biome check .            # Check all files for issues
biome check . --write    # Auto-fix issues
biome format . --write   # Format all supported files
biome lint .             # Lint JavaScript/TypeScript files
```

## System Commands (macOS/Darwin)
```bash
# File operations
ls -la                   # List files with details
find . -name "*.mjs"     # Find JavaScript modules
grep -r "template" .     # Search for template references

# Directory navigation
pwd                      # Current directory
cd scripts/              # Change to scripts directory

# Git operations
git status               # Check git status
git log --oneline        # View commit history
git diff                 # View changes
```
