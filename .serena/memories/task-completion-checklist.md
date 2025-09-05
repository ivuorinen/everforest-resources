# Task Completion Checklist - Everforest Resources

## When a Development Task is Completed

### 1. Code Quality Checks
```bash
# Lint and format code first
npm run lint:fix         # Auto-fix any linting issues
npm run format           # Ensure consistent formatting

# Generate themes from updated templates/palettes
npm run generate

# Validate all outputs
npm run validate

# Check for any errors or warnings
# All validation must pass before proceeding
```

### 2. Testing Requirements
```bash
# Run Playwright snapshots (for web changes)
npm run snapshots

# Full CI pipeline (includes linting)
npm run ci

# Verify no errors in any step
```

### 3. File Verification
- **Never commit generated files without running generator**
- **Always commit palette + template + generated files together**
- Check that all 6 variants are generated (dark/light × hard/medium/soft)
- Ensure code passes Biome linting and formatting

### 4. Documentation Updates
- Update relevant README or docs if adding new tools
- Ensure all examples use indented code blocks (4 spaces)
- Never use triple backticks in documentation
- Run `npm run format` to ensure consistent formatting

### 5. Git Workflow
```bash
# Check status
git status

# Lint and format before committing
npm run lint:fix
npm run format

# Stage all changes (palette + template + generated)
git add -A

# Commit with conventional format
git commit -m "feat: add new CLI tool theme"
# or
git commit -m "fix: correct color mapping in starship"
# or
git commit -m "docs: update installation guide"

# Push changes
git push
```

### 6. CI/CD Requirements
All these checks must pass in CI before merge:
- ✅ **lint**: Biome linting and formatting checks
- ✅ **build**: Generator + validation
- ✅ **snapshots**: Playwright demo renders
- ✅ **commitlint**: Conventional Commits enforcement
- ✅ **cli-verify**: Install + verify generated configs

### 7. Critical Rules Verification
- [ ] Code passes Biome linting (no errors)
- [ ] Code is properly formatted with Biome
- [ ] No raw hex values in CLI configs (ANSI only)
- [ ] All generated files come from templates/palettes
- [ ] No manual edits to generated files
- [ ] Template placeholders used correctly
- [ ] All 6 theme variants present where applicable

### 8. Special Considerations

#### For New CLI Tools
- Create `template.txt` with proper placeholders
- Add to generator processing logic
- Update installer script
- Add to verifier container
- Document in appropriate README
- Ensure any new JS/MJS files follow Biome style

#### For Palette Changes
- Regenerate ALL theme files
- Verify no breaking changes in output formats
- Test web demo still renders correctly
- Check that ANSI mappings remain valid

#### For Template Updates
- Test with all 6 variants
- Verify placeholder replacement works
- Check output format matches tool expectations

#### For JavaScript/Code Changes
- Run `npm run lint:fix` to auto-fix issues
- Run `npm run format` for consistent formatting
- Ensure imports are organized correctly
- Follow established naming conventions

### 9. Before Pushing
```bash
# Final verification with full CI
npm run ci

# If all passes, ready to push
git push origin main
```

## Emergency Fixes
If CI fails after push:
1. Check error logs in GitHub Actions
2. For linting errors: `npm run lint:fix` locally
3. For generation errors: `rm -rf generated/ && npm run generate`
4. Fix locally with proper workflow above
5. Push fix immediately

## Biome-Specific Troubleshooting
```bash
# Check what Biome would fix
npm run lint

# Auto-fix all fixable issues
npm run lint:fix

# Format all files
npm run format

# Check specific file
biome check scripts/generate-themes.mjs
```
