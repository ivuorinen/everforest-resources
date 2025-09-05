# Everforest Resources - Makefile
# Alternative build commands for development and CI

.PHONY: all generate validate lint format clean install demo ci help

# Default target
all: generate validate

# Core development commands
generate:
	@echo "🎨 Generating all theme files..."
	node scripts/generate-themes.mjs

validate:
	@echo "✅ Validating generated outputs..."
	node scripts/validate.mjs

lint:
	@echo "🔍 Checking code quality..."
	npm run lint

lint-fix:
	@echo "🔧 Auto-fixing linting issues..."
	npm run lint:fix

format:
	@echo "✨ Formatting code..."
	npm run format

# Installation commands
install:
	@echo "📦 Installing themes to system..."
	./install.sh

install-dry:
	@echo "🔍 Preview theme installation..."
	./install.sh --dry-run

install-backup:
	@echo "💾 Installing themes with backup..."
	./install.sh --backup

# Development server
demo:
	@echo "🌐 Starting web demo server..."
	@echo "Open http://localhost:3000/docs/examples/web-demo.html"
	python3 -m http.server 3000

# Testing and validation
test:
	@echo "🧪 Running Playwright tests..."
	npx playwright test

snapshots:
	@echo "📸 Updating Playwright snapshots..."
	npx playwright test --update-snapshots

verify:
	@echo "🔬 Verifying installation in container..."
	ENGINE=docker ./verify/verify.sh

# CI pipeline
ci: lint generate validate test
	@echo "🚀 Full CI pipeline completed successfully"

build: generate validate
	@echo "🏗️  Build completed successfully"

# Maintenance
clean:
	@echo "🧹 Cleaning generated files..."
	@find . -name "*-dark-*" -type f ! -path "./node_modules/*" -delete
	@find . -name "*-light-*" -type f ! -path "./node_modules/*" -delete
	@echo "Generated theme files cleaned"

clean-node:
	@echo "🧹 Cleaning node_modules..."
	rm -rf node_modules package-lock.json
	npm install

stats:
	@echo "📊 Project Statistics:"
	@echo "Generated files: $$(find . -name '*-dark-*' -o -name '*-light-*' | grep -v node_modules | wc -l)"
	@echo "Templates: $$(find . -name 'template.*' | wc -l)"
	@echo "CLI tools: $$(find cli -maxdepth 1 -type d | grep -v '^cli$$' | wc -l)"
	@echo "Terminals: $$(find terminals -maxdepth 1 -type d | grep -v '^terminals$$' | wc -l)"
	@echo "Editors: $$(find editors -maxdepth 1 -type d | grep -v '^editors$$' | wc -l)"

# Development workflow
dev: generate demo
	@echo "🚀 Development server started"

release: ci
	@echo "🎯 Creating release..."
	npm run release

# Help target
help:
	@echo "Everforest Resources - Available Commands:"
	@echo ""
	@echo "Development:"
	@echo "  make generate     - Generate all theme files from templates"
	@echo "  make validate     - Validate generated outputs"
	@echo "  make lint         - Check code quality with Biome"
	@echo "  make lint-fix     - Auto-fix linting issues"
	@echo "  make format       - Format code with Biome"
	@echo "  make dev          - Generate themes and start demo server"
	@echo ""
	@echo "Installation:"
	@echo "  make install      - Install themes to ~/.config"
	@echo "  make install-dry  - Preview installation without changes"
	@echo "  make install-backup - Install with backup of existing configs"
	@echo ""
	@echo "Testing:"
	@echo "  make test         - Run Playwright visual tests"
	@echo "  make snapshots    - Update Playwright snapshots"
	@echo "  make verify       - Verify installation in Docker container"
	@echo ""
	@echo "CI/CD:"
	@echo "  make ci           - Run full CI pipeline"
	@echo "  make build        - Run build pipeline (generate + validate)"
	@echo "  make release      - Create release after CI checks"
	@echo ""
	@echo "Utilities:"
	@echo "  make demo         - Start web demo server"
	@echo "  make clean        - Remove generated theme files"
	@echo "  make clean-node   - Clean and reinstall node_modules"
	@echo "  make stats        - Show project statistics"
	@echo "  make help         - Show this help message"
	@echo ""
	@echo "Quick start: make generate && make install"
