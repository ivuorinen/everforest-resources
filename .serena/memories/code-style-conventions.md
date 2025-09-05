# Code Style & Conventions - Everforest Resources

## JavaScript/Node.js Style

### Module System
- **ES Modules**: All files use `.mjs` extension
- **Imports**: Use ES6 import/export syntax
- **Type**: `"type": "module"` in package.json

### Biome Configuration
The project uses **Biome 2.x** for linting and formatting with these settings:
- **Version**: 2.2.3 (latest)
- **Indent**: 2 spaces
- **Line width**: 100 characters
- **Quotes**: Single quotes for JavaScript, double for JSX
- **Semicolons**: Always required
- **Trailing commas**: ES5 style
- **Arrow parentheses**: As needed

### Class Structure
```javascript
class EverforestGenerator {
  constructor() {
    this.palette = null;
  }

  async methodName() {
    // Async/await preferred over Promises
  }
}
```

### Naming Conventions
- **Classes**: PascalCase (`EverforestGenerator`)
- **Methods**: camelCase (`loadPalette`, `processTemplate`)
- **Constants**: camelCase for most, UPPER_SNAKE_CASE for true constants
- **Files**: kebab-case (`generate-themes.mjs`)

### Error Handling
- Use try-catch blocks for async operations
- Log errors with emoji prefixes: `console.error('❌ Failed to load palette')`
- Exit with code 1 on critical errors: `process.exit(1)`

### Console Output
- Use emoji for visual feedback:
  - ✅ Success messages
  - ❌ Error messages
  - 🎨 Starting operations
  - 📝 Progress updates
  - ✨ Completion messages

### Code Quality Rules
- **Variables**: Use `const` by default, `let` when reassignment needed
- **Functions**: Prefer arrow functions for callbacks
- **Imports**: Organize imports automatically with Biome
- **Unused Variables**: Not allowed (error level)
- **Block Statements**: Always use braces for control structures
- **forEach**: Allowed for side effects (useIterableCallbackReturn disabled)

## Template System Conventions

### Placeholder Format
- Use double curly braces: `{{colorName}}`
- Available placeholders: `{{bg}}`, `{{fg}}`, `{{red}}`, `{{orange}}`, `{{yellow}}`, `{{green}}`, `{{aqua}}`, `{{blue}}`, `{{purple}}`, `{{gray1}}`, `{{gray2}}`, `{{gray3}}`

### Template Files
- Named `template.txt` in each tool directory
- Multiple templates for complex tools (e.g., `colors-template.txt`, `prompt-template.txt`)
- Never edit generated output files directly

## Documentation Style

### Code Comments
- Use JSDoc-style comments for classes and methods
- Include purpose and architecture notes at file top
- Explain complex logic inline

### Markdown
- **Critical Rule**: Use indented code blocks only (4 spaces)
- Never use triple backticks (```)
- Use emoji in headers and lists for visual hierarchy

## Git Conventions

### Commit Messages
- Follow Conventional Commits format
- Examples:
  - `feat: add starship theme generator`
  - `fix: correct color mapping in templates`
  - `docs: update CLI installation guide`

### Branch Strategy
- Main branch: `main`
- All CI checks must pass for merge
- Required checks: lint + build + snapshots + commitlint + cli-verify

## File Organization

### Directory Structure
```
palettes/           # Color definitions (JSON/YAML)
scripts/            # Generator and validation scripts
cli/               # CLI tool templates and configs
editors/           # Editor theme files
terminals/         # Terminal configurations
web/               # CSS and demo files
docs/              # Documentation
meta/              # Project specifications
biome.json         # Biome 2.x configuration
```

### File Naming
- Scripts: `kebab-case.mjs`
- Configs: Tool-specific conventions
- Templates: `template.txt` or `tool-template.txt`

### Biome File Processing
Biome processes these files:
- JavaScript modules: `scripts/**/*.mjs`, `scripts/**/*.js`
- JSON files: `*.json`
- Root level JS files: `*.mjs`, `*.js`

Biome ignores:
- Generated output files
- Node modules and build artifacts
- Unknown file types (by default)

## Development Commands
```bash
# Format code
npm run format           # Format all files with Biome 2.x

# Lint code
npm run lint            # Check for issues
npm run lint:fix        # Auto-fix issues

# Before committing
npm run lint:fix && npm run format
```
